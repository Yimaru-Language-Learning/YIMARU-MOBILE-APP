import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/dio_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

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

  for (final kind in ['LESSON', 'MODULE', 'COURSE', 'UNIT', 'CATALOG_COURSE']) {
    test('completion sends the $kind context as a JSON body', () async {
      final data = {'parent_kind': kind, 'parent_id': 61};
      transport.dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          expect(options.method, 'POST');
          expect(options.uri.path, '/api/v1/progress/practices/52/complete');
          expect(options.data, data);
          expect(options.queryParameters, isEmpty);
          handler.resolve(Response(requestOptions: options, statusCode: 200));
        },
      ));
      expect((await api.completePractice(id: 52, data: data))['status'],
          ResponseStatus.success);
    });
  }

  for (final status in [400, 403, 500, 503, null]) {
    test('HTTP $status or timeout is not reported as completion success',
        () async {
      transport.dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) => handler.reject(DioException(
          requestOptions: options,
          type: status == null
              ? DioExceptionType.receiveTimeout
              : DioExceptionType.badResponse,
          response: status == null
              ? null
              : Response(requestOptions: options, statusCode: status),
        )),
      ));
      expect(
          (await api.completePractice(
              id: 52,
              data: {'parent_kind': 'LESSON', 'parent_id': 61}))['status'],
          ResponseStatus.failure);
    });
  }
}
