import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/dio_service.dart';

class _Transport implements DioService {
  @override
  final dio = Dio();
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _Transport transport;
  late ApiService api;
  setUp(() {
    transport = _Transport();
    locator.registerSingleton<DioService>(transport);
    api = ApiService();
  });
  tearDown(() async {
    transport.dio.close();
    await locator.reset();
  });
  test(
      'activity and preference requests use private logging and authenticated me routes',
      () async {
    final seen = <RequestOptions>[];
    transport.dio.interceptors
        .add(InterceptorsWrapper(onRequest: (request, handler) {
      seen.add(request);
      expect(request.extra[DioService.privateReminderRequest], isTrue);
      handler.resolve(Response(
          requestOptions: request,
          statusCode: request.method == 'POST' ? 204 : 200,
          data: {
            'data': {'enabled': false}
          }));
    }));
    await api.recordReminderActivity(CancelToken());
    expect(await api.getReminderPreference(), isFalse);
    expect(await api.setReminderPreference(false), isFalse);
    expect(seen.map((request) => request.method), ['POST', 'GET', 'PUT']);
    expect(seen[0].path, endsWith('/users/me/activity'));
    expect(seen[0].extra[DioService.backgroundReminderActivity], isTrue);
    expect(seen[1].extra[DioService.backgroundReminderActivity], isNull);
    expect(seen[2].extra[DioService.backgroundReminderActivity], isNull);
    expect(seen[1].path, endsWith('/users/me/reminder-preferences'));
    expect(seen[2].data, {'enabled': false});
  });
  test('failed preference saves propagate rather than pretending success',
      () async {
    transport.dio.interceptors.add(InterceptorsWrapper(
        onRequest: (request, handler) => handler.reject(DioException(
            requestOptions: request,
            type: DioExceptionType.badResponse,
            response: Response(requestOptions: request, statusCode: 503)))));
    await expectLater(
        api.setReminderPreference(false), throwsA(isA<DioException>()));
  });
  test('invalid preference responses fail safely', () async {
    transport.dio.interceptors.add(InterceptorsWrapper(
        onRequest: (request, handler) => handler.resolve(
                Response(requestOptions: request, statusCode: 200, data: {
              'data': {'enabled': 'false'}
            }))));
    await expectLater(api.getReminderPreference(), throwsStateError);
  });
}
