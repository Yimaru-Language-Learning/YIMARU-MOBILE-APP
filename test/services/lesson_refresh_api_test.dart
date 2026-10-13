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

  for (final examPrep in [false, true]) {
    test('fetches all pages for ${examPrep ? 'exam prep' : 'LMS'}', () async {
      final offsets = <int>[];
      transport.dio.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) {
        expect(
            options.uri.path,
            examPrep
                ? '/api/v1/exam-prep/modules/45/lessons'
                : '/api/v1/modules/45/lessons');
        expect(options.queryParameters['limit'], 200);
        final offset = options.queryParameters['offset'] as int;
        offsets.add(offset);
        handler
            .resolve(Response(requestOptions: options, statusCode: 200, data: {
          'data': {
            'total_count': 205,
            'lessons': List.generate(
                offset == 0 ? 200 : 5,
                (i) => {
                      'id': offset + i + 1,
                      'title': 'Lesson ${offset + i + 1}',
                      'has_practice': true
                    })
          }
        }));
      }));
      if (examPrep) {
        final rows = await api.getCourseLessons(45);
        expect(rows.length, 205);
        expect(rows.last.id, 205);
      } else {
        final rows = await api.getLearnLessons(45);
        expect(rows.length, 205);
        expect(rows.last.id, 205);
        expect(rows.last.hasPractice, isTrue);
      }
      expect(offsets, [0, 200]);
    });
  }

  test('a later page failure propagates instead of applying a partial list',
      () async {
    transport.dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) {
      if (options.queryParameters['offset'] == 0) {
        handler
            .resolve(Response(requestOptions: options, statusCode: 200, data: {
          'data': {
            'total_count': 201,
            'lessons': List.generate(200, (i) => {'id': i + 1})
          }
        }));
      } else {
        handler.reject(DioException(
            requestOptions: options, type: DioExceptionType.connectionError));
      }
    }));
    await expectLater(api.getLearnLessons(45), throwsA(isA<DioException>()));
  });

  for (final status in [403, 404, 500]) {
    test(
        'handles HTTP $status as ${status == 500 ? 'failure' : 'unavailable content'}',
        () async {
      transport.dio.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) {
        handler.reject(DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            response: Response(requestOptions: options, statusCode: status)));
      }));
      if (status == 500) {
        await expectLater(
            api.getCourseLessons(45), throwsA(isA<DioException>()));
      } else {
        expect(await api.getCourseLessons(45), isEmpty);
      }
    });
  }
}
