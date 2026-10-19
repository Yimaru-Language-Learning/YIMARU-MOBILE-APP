import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/dio_service.dart';
import 'package:yimaru_app/services/read_request_failure.dart';

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

  final reads = <String, Future<List<dynamic>> Function(ApiService)>{
    'programs': (api) => api.getLearnPrograms(),
    'courses': (api) => api.getLearnCourses(1),
    'modules': (api) => api.getLearnModules(1),
    'catalogues': (api) => api.getCourseCatalogs(),
    'units': (api) => api.getCourseUnits(1),
    'exam modules': (api) => api.getCourseModules(1),
    'progress': (api) => api.getProgressSummary(),
    'notifications': (api) => api.getAllNotifications(),
    'my subscriptions': (api) => api.getMySubscriptions(),
    'plans': (api) => api.getSubscriptions('LEARN_ENGLISH'),
    'faqs': (api) => api.getFaqs(),
  };

  for (final read in reads.entries) {
    for (final status in [500, 503, 504]) {
      test('${read.key}: HTTP $status propagates instead of becoming empty',
          () async {
        transport.dio.interceptors.add(InterceptorsWrapper(
          onRequest: (options, handler) => handler.reject(DioException(
              requestOptions: options,
              type: DioExceptionType.badResponse,
              response: Response(requestOptions: options, statusCode: status))),
        ));
        await expectLater(read.value(api), throwsA(isA<DioException>()));
      });
    }
    test('${read.key}: connection failures propagate', () async {
      transport.dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) => handler.reject(DioException(
            requestOptions: options, type: DioExceptionType.connectionError)),
      ));
      await expectLater(read.value(api), throwsA(isA<DioException>()));
    });
    test('${read.key}: a successful empty response is still empty', () async {
      final data = read.key == 'plans' || read.key == 'my subscriptions'
          ? <dynamic>[]
          : <String, dynamic>{
              'programs': [],
              'courses': [],
              'modules': [],
              'catalog_courses': [],
              'units': [],
              'faqs': [],
            };
      transport.dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) => handler.resolve(Response(
          requestOptions: options,
          statusCode: 200,
          data: {'data': data, 'notifications': []},
        )),
      ));
      expect(await read.value(api), isEmpty);
    });
  }

  test('only transient server/connection failures are retryable', () {
    for (final status in [400, 401, 403, 404, 422, 500, 503]) {
      final request = RequestOptions(path: '/test');
      expect(
          isRetryableReadFailure(DioException(
              requestOptions: request,
              type: DioExceptionType.badResponse,
              response: Response(requestOptions: request, statusCode: status))),
          status >= 500);
    }
    for (final type in DioExceptionType.values) {
      expect(
          isRetryableReadFailure(DioException(
              requestOptions: RequestOptions(path: '/test'), type: type)),
          [
            DioExceptionType.connectionError,
            DioExceptionType.connectionTimeout,
            DioExceptionType.sendTimeout,
            DioExceptionType.receiveTimeout
          ].contains(type));
    }
    expect(
        isRetryableReadFailure(StateError('not a network failure')), isFalse);
  });
}
