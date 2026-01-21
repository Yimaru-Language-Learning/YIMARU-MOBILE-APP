import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/user_model.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';

import '../app/app.locator.dart';
import '../ui/common/app_constants.dart';

class DioService {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  final Dio _dio = Dio();
  final Dio _refreshDio = Dio(); // separate instance

  bool _isRefreshing = false;
  final List<void Function()> _retryQueue = [];

  DioService() {
    _dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: _onError,
        onRequest: _onRequest,
        onResponse: _onResponse,
      ),
    );
  }

  void _onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint('✅✅✅✅INITIALIZING RESPONSE✅✅✅✅');
    debugPrint('✅ ${response.statusCode} ${response.requestOptions.uri}');
    debugPrint('✅ DATA: ${response.data}');
    debugPrint('✅✅✅✅FINALIZING RESPONSE✅✅✅✅');

    handler.next(response);
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _authenticationService.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    debugPrint('️️➡️➡️➡️➡️INITIALIZING REQUEST➡️➡️➡️➡️');
    debugPrint('➡️ ${options.method} ${options.uri}');
    debugPrint('➡️ HEADERS: ${options.headers}');
    debugPrint('➡️ DATA: ${options.data}');
    debugPrint('️️➡️➡️➡️➡️FINALIZING REQUEST➡️➡️➡️➡️');

    handler.next(options);
  }

  Future<void> _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint('❌❌❌❌INITIALIZING ERROR❌❌❌❌');
    debugPrint('❌ ${error.response?.data} ${error.requestOptions.uri}');
    debugPrint('❌ ${error.response?.statusCode} ${error.requestOptions.uri}');
    debugPrint('❌❌❌❌FINALIZING ERROR❌❌❌❌');

    if (error.response?.statusCode == 401 &&
        !_isRefreshRequest(error.requestOptions)) {
      return _handle401(error, handler);
    }

    handler.next(error);
  }

  Future<void> _handle401(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = error.requestOptions;

    if (_isRefreshing) {
      _retryQueue.add(() async {
        final response = await _dio.fetch(requestOptions);
        handler.resolve(response);
      });
      return;
    }

    _isRefreshing = true;

    try {
      final refreshed = await _refreshToken();

      if (!refreshed) {
        handler.reject(error);
        return;
      }

      final response = await _dio.fetch(requestOptions);

      for (final retry in _retryQueue) {
        retry();
      }
      _retryQueue.clear();

      handler.resolve(response);
    } catch (e) {
      handler.reject(error);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<bool> _refreshToken() async {
    final UserModel user = await _authenticationService.getUser();

    if (user.refreshToken == null) return false;

    try {
      Map<String, dynamic> data = {
        'role': 'STUDENT',
        'user_id': user.userId,
        'access_token': user.accessToken,
        'refresh_token': user.refreshToken
      };
      print(data);
      final response = await _refreshDio.post(
        '$baseUrl/$kRefreshTokenUrl',
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Refresh response');
      print(response.data);
      await _authenticationService.saveTokens(
        access: response.data['access_token'],
        refresh: response.data['refresh_token'],
      );

      return true;
    } catch (e) {
      print('Refresh response exception');
      print(e.toString());
      // await _authenticationService.logOut();
      // await _navigationService.replaceWithLoginView();
      return false;
    }
  }

  bool _isRefreshRequest(RequestOptions options) {
    return options.path.contains(kRefreshTokenUrl);
  }

  Dio get dio => _dio;
}
