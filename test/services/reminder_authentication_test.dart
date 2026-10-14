import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/dio_service.dart';

class _Auth extends Mock implements AuthenticationService {
  @override
  int get sessionGeneration => 0;
  int refreshReads = 0;
  int logouts = 0;
  @override
  Future<String?> getAccessToken() async => 'expired-test-token';
  @override
  Future<User?> getUser() async {
    refreshReads++;
    return null;
  }

  @override
  Future<void> logout() async {
    logouts++;
  }
}

class _Navigation extends Mock implements NavigationService {}

void main() {
  late _Auth auth;
  late DioService transport;
  setUp(() {
    auth = _Auth();
    locator.registerSingleton<AuthenticationService>(auth);
    locator.registerSingleton<NavigationService>(_Navigation());
    transport = DioService();
    locator.registerSingleton<DioService>(transport);
  });
  tearDown(() async {
    transport.dio.close(force: true);
    await locator.reset();
  });

  for (final status in [401, 403, 500, 503]) {
    test('heartbeat HTTP $status does not refresh credentials or log out',
        () async {
      transport.dio.interceptors
          .add(InterceptorsWrapper(onRequest: (request, handler) {
        expect(request.extra[DioService.backgroundReminderActivity], isTrue);
        expect(request.headers['Authorization'], 'Bearer expired-test-token');
        handler.reject(
            DioException(
                requestOptions: request,
                type: DioExceptionType.badResponse,
                response:
                    Response(requestOptions: request, statusCode: status)),
            true);
      }));
      await expectLater(ApiService().recordReminderActivity(CancelToken()),
          throwsA(isA<DioException>()));
      expect(auth.refreshReads, 0);
      expect(auth.logouts, 0);
    });
  }

  test(
      'interactive preference requests still use ordinary authentication recovery',
      () async {
    transport.dio.interceptors
        .add(InterceptorsWrapper(onRequest: (request, handler) {
      expect(request.extra[DioService.privateReminderRequest], isTrue);
      expect(request.extra[DioService.backgroundReminderActivity], isNull);
      handler.reject(
          DioException(
              requestOptions: request,
              type: DioExceptionType.badResponse,
              response: Response(requestOptions: request, statusCode: 401)),
          true);
    }));
    await expectLater(
        ApiService().getReminderPreference(), throwsA(isA<DioException>()));
    expect(auth.refreshReads, 1);
  });

  test('cancelled activity cannot reach transport', () async {
    var reached = false;
    transport.dio.interceptors
        .add(InterceptorsWrapper(onRequest: (request, handler) {
      reached = true;
      handler.resolve(Response(requestOptions: request, statusCode: 204));
    }));
    final cancellation = CancelToken()..cancel('session ended');
    await expectLater(
        ApiService().recordReminderActivity(cancellation),
        throwsA(isA<DioException>()
            .having((error) => error.type, 'type', DioExceptionType.cancel)));
    expect(reached, isFalse);
    expect(auth.logouts, 0);
  });
}
