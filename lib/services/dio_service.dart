import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/services/authentication_service.dart';

import '../app/app.locator.dart';
import '../ui/common/app_constants.dart';

class DioService {
  // Background token sync must not log credentials or initiate a logout/refresh.
  // The normal app requests still own authentication recovery.
  static const backgroundDeviceRegistration = 'backgroundDeviceRegistration';
  // Hide reminder traffic from credential-bearing debug logs without disabling 401 recovery.
  static const privateReminderRequest = 'privateReminderRequest';
  // Optional activity must not refresh credentials, clear a session, or navigate.
  static const backgroundReminderActivity = 'backgroundReminderActivity';

  // Dependency injection
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  // Initialization
  final Dio _dio;

  Dio get dio => _dio;

  // Deliberately bypass auth refresh, session reads and credential-bearing logs.
  // The snapshot belongs to the account whose logout is being serialized.
  Future<void> unregisterDevice(String token,
      {required String accessToken}) async {
    final cancellation = CancelToken();
    try {
      await _refreshDio
          .post(
            '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kDevicesUrl/unregister',
            data: {'device_token': token},
            options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
            cancelToken: cancellation,
          )
          .timeout(const Duration(seconds: 3));
    } finally {
      cancellation.cancel('Logout cleanup finished');
    }
  }

  // No auth interceptor: a refresh cannot refresh itself.
  final Dio _refreshDio;
  Future<bool>? _refreshing;
  int? _refreshGeneration;
  static const _sessionKey = 'authSessionGeneration';
  static const _accessKey = 'requestAccessToken';
  static const _retriedKey = 'authRetried';

  // Initialization
  DioService({Dio? client, Dio? refreshClient})
      : _dio = client ?? Dio(),
        _refreshDio = refreshClient ?? Dio() {
    _dio.options
      ..baseUrl = kBaseUrl
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 15);
    _refreshDio.options
      ..connectTimeout = const Duration(seconds: 10)
      ..sendTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 15);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: _onError,
        onRequest: _onRequest,
        onResponse: _onResponse,
      ),
    );
  }

  // Response logger
  void _onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.requestOptions.extra[backgroundDeviceRegistration] == true ||
        response.requestOptions.extra[privateReminderRequest] == true) {
      handler.next(response);
      return;
    }
    debugPrint('✅✅✅✅INITIALIZING RESPONSE✅✅✅✅');
    debugPrint('✅ ${response.statusCode} ${response.requestOptions.uri.path}');
    debugPrint('✅✅✅✅FINALIZING RESPONSE✅✅✅✅');

    handler.next(response);
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.extra[_sessionKey] ??= _authenticationService.sessionGeneration;
    final access = await _authenticationService.getAccessToken();
    if (options.extra[_sessionKey] !=
        _authenticationService.sessionGeneration) {
      handler.reject(DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
          error: 'Authentication session changed'));
      return;
    }
    options.extra[_accessKey] = access;

    if (access != null) {
      options.headers['Authorization'] = 'Bearer $access';
    } else {
      options.headers.remove('Authorization');
    }

    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    if (options.extra[backgroundDeviceRegistration] == true ||
        options.extra[privateReminderRequest] == true) {
      handler.next(options);
      return;
    }

    debugPrint('️️➡️➡️➡️➡️INITIALIZING REQUEST➡️➡️➡️➡️');
    // Never log credentials, login payloads, or token-bearing query strings.
    debugPrint('➡️ ${options.method} ${options.uri.path}');
    debugPrint('️️➡️➡️➡️➡️FINALIZING REQUEST➡️➡️➡️➡️');

    handler.next(options);
  }

  // Error logger
  Future<void> _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    if (error.requestOptions.extra[backgroundDeviceRegistration] == true ||
        error.requestOptions.extra[backgroundReminderActivity] == true) {
      handler.next(error);
      return;
    }
    if (error.requestOptions.extra[privateReminderRequest] != true) {
      debugPrint('❌❌❌❌INITIALIZING ERROR❌❌❌❌');
      debugPrint(
          '❌ ${error.response?.statusCode} ${error.requestOptions.uri.path}');
      debugPrint('❌❌❌❌FINALIZING ERROR❌❌❌❌');
    }
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
    final generation = requestOptions.extra[_sessionKey];
    if (generation != _authenticationService.sessionGeneration ||
        requestOptions.extra[_retriedKey] == true) {
      handler.next(error);
      return;
    }
    try {
      final currentAccess = await _authenticationService.getAccessToken();
      if (generation != _authenticationService.sessionGeneration) {
        handler.next(error);
        return;
      }
      // A delayed 401 may belong to the token that another request refreshed.
      if (currentAccess == null ||
          currentAccess == requestOptions.extra[_accessKey]) {
        if (!await _refreshForSession(generation as int)) {
          handler.next(error);
          return;
        }
      }
      if (generation != _authenticationService.sessionGeneration) {
        handler.next(error);
        return;
      }
      requestOptions.extra[_retriedKey] = true;
      final data = requestOptions.data;
      if (data is FormData && data.isFinalized) {
        requestOptions.data = data.clone();
      }
      // Every waiter retries independently; one failure cannot strand the others.
      handler.resolve(await _dio.fetch(requestOptions));
    } on DioException catch (failure) {
      handler.reject(DioException(
          requestOptions: requestOptions,
          type: failure.type,
          response: failure.response,
          error: failure.error));
    } catch (failure) {
      handler
          .reject(DioException(requestOptions: requestOptions, error: failure));
    }
  }

  Future<bool> _refreshForSession(int generation) {
    if (_refreshing != null && _refreshGeneration == generation) {
      return _refreshing!;
    }
    late final Future<bool> flight;
    flight = _refreshToken(generation).whenComplete(() {
      if (identical(_refreshing, flight)) {
        _refreshing = null;
        _refreshGeneration = null;
      }
    });
    _refreshGeneration = generation;
    return _refreshing = flight;
  }

  Future<bool> _refreshToken(int generation) async {
    final user = await _authenticationService.getUser();
    if (generation != _authenticationService.sessionGeneration ||
        user?.refreshToken == null ||
        user!.refreshToken!.isEmpty) {
      return false;
    }
    try {
      final response = await _refreshDio.post(
        '$kBaseUrl/$kRefreshTokenUrl',
        data: {
          'access_token': user.accessToken,
          'refresh_token': user.refreshToken
        },
      );
      if (generation != _authenticationService.sessionGeneration) return false;
      final body = response.data;
      final tokens = body is Map ? (body['data'] ?? body) : null;
      final access = tokens is Map ? tokens['access_token'] : null;
      final refresh = tokens is Map ? tokens['refresh_token'] : null;
      if (access is! String ||
          access.isEmpty ||
          refresh is! String ||
          refresh.isEmpty ||
          refresh == user.refreshToken) {
        throw StateError('Invalid refresh response');
      }
      await _authenticationService.saveTokens(
        access: access,
        refresh: refresh,
        expectedSessionGeneration: generation,
      );
      return generation == _authenticationService.sessionGeneration;
    } on DioException catch (error) {
      final status = error.response?.statusCode;
      if (status != 401 && status != 403) rethrow;
      if (generation == _authenticationService.sessionGeneration) {
        await _authenticationService.logout();
        if (_authenticationService.sessionGeneration == generation + 1) {
          await _navigationService.replaceWithLoginView();
        }
      }
      return false;
    }
  }

  // Check request if immediately after token refreshed
  bool _isRefreshRequest(RequestOptions options) {
    return options.path.contains(kRefreshTokenUrl);
  }
}
