import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/dio_service.dart';

class RegistrationTestAuth extends Mock implements AuthenticationService {
  @override
  int get sessionGeneration => 0;
  int refreshUserReads = 0;

  @override
  Future<User?> getUser() async {
    refreshUserReads++;
    return null;
  }

  @override
  Future<String?> getAccessToken() async => 'test-access-token';
  @override
  Future<String?> getRefreshToken() async => null;
}

class RegistrationTestNavigation extends Mock implements NavigationService {}

void main() {
  setUp(() {
    locator.registerSingleton<AuthenticationService>(RegistrationTestAuth());
    locator.registerSingleton<NavigationService>(RegistrationTestNavigation());
  });
  tearDown(() => locator.reset());

  test('Android registration uses the existing endpoint and auth interceptor',
      () async {
    final transport = DioService();
    addTearDown(() => transport.dio.close());
    locator.registerSingleton<DioService>(transport);
    final api = ApiService();
    final cancellation = CancelToken();
    transport.dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        expect(options.uri.path, '/api/v1/devices/register');
        expect(options.headers['Authorization'], 'Bearer test-access-token');
        expect(options.data, {
          'device_token': 'test-fcm-token',
          'platform': 'android',
        });
        expect(identical(options.cancelToken, cancellation), isTrue);
        expect(options.extra[DioService.backgroundDeviceRegistration], isTrue);
        handler.resolve(Response(requestOptions: options, statusCode: 201));
      }),
    );
    await api.registerDevice({
      'device_token': 'test-fcm-token',
      'platform': 'android',
    }, cancelToken: cancellation, backgroundSync: true);
  });

  test('background registration 401 does not initiate refresh or logout',
      () async {
    final transport = DioService();
    addTearDown(() => transport.dio.close());
    locator.registerSingleton<DioService>(transport);
    final api = ApiService();
    transport.dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            response: Response(requestOptions: options, statusCode: 401),
          ),
          true,
        );
      }),
    );
    await expectLater(
      api.registerDevice({'device_token': 'token', 'platform': 'android'},
          backgroundSync: true),
      throwsA(isA<DioException>()
          .having((error) => error.response?.statusCode, 'status', 401)),
    );
    expect(
        (locator<AuthenticationService>() as RegistrationTestAuth)
            .refreshUserReads,
        0);
  });

  test('cancelled registration never reaches transport', () async {
    final transport = DioService();
    addTearDown(() => transport.dio.close());
    locator.registerSingleton<DioService>(transport);
    final api = ApiService();
    final cancellation = CancelToken()..cancel('Signed out');
    var transportReached = false;
    transport.dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        transportReached = true;
        handler.resolve(Response(requestOptions: options, statusCode: 201));
      }),
    );
    await expectLater(
      api.registerDevice({'device_token': 'token', 'platform': 'android'},
          cancelToken: cancellation, backgroundSync: true),
      throwsA(isA<DioException>()
          .having((error) => error.type, 'type', DioExceptionType.cancel)),
    );
    expect(transportReached, isFalse);
  });
}
