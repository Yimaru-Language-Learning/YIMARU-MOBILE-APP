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

  for (final channel in ['sms', 'email']) {
    test('HTTP 200 $channel delivery is recognized', () async {
      transport.dio.interceptors
          .add(InterceptorsWrapper(onRequest: (request, handler) {
        expect(request.path, endsWith('/subscriptions/request-checkout-link'));
        expect(request.data, {'category': 'LEARN_ENGLISH'});
        handler
            .resolve(Response(requestOptions: request, statusCode: 200, data: {
          'data': {'channel': channel}
        }));
      }));
      final result = await api.iosCheckout({'category': 'LEARN_ENGLISH'});
      expect(result['status'], ResponseStatus.success);
      expect(result['channel'], channel);
    });
  }
  for (final status in [400, 409, 429, 500, 503]) {
    test('HTTP $status is recoverable and never automatically resends',
        () async {
      var sends = 0;
      transport.dio.interceptors
          .add(InterceptorsWrapper(onRequest: (request, handler) {
        sends++;
        handler.reject(DioException(
            requestOptions: request,
            response: Response(
                requestOptions: request,
                statusCode: status,
                data: {'message': 'private server details'})));
      }));
      final result = await api.iosCheckout({'category': 'IELTS'});
      expect(result, {'status': ResponseStatus.failure, 'statusCode': status});
      expect(sends, 1);
    });
  }
  for (final body in [
    null,
    'invalid',
    {'data': 'bad'},
    {
      'data': {'channel': 'unknown'}
    }
  ]) {
    test('malformed delivery response $body does not claim success', () async {
      transport.dio.interceptors
          .add(InterceptorsWrapper(onRequest: (request, handler) {
        handler.resolve(
            Response(requestOptions: request, statusCode: 200, data: body));
      }));
      expect((await api.iosCheckout({'category': 'DUOLINGO'}))['status'],
          ResponseStatus.failure);
    });
  }
  test(
      'phone save sends only the phone, not a complete profile or verification',
      () async {
    transport.dio.interceptors
        .add(InterceptorsWrapper(onRequest: (request, handler) {
      expect(request.method, 'PATCH');
      expect(request.path, endsWith('/user/contact-phone'));
      expect(request.data, {'phone_number': '251912345678'});
      handler.resolve(Response(requestOptions: request, statusCode: 200, data: {
        'data': {'phone_number': '251912345678'}
      }));
    }));
    expect(await api.addContactPhone('251912345678'), '251912345678');
  });

  test('superseded delivery is cancellable and never retried', () async {
    var sends = 0;
    transport.dio.interceptors
        .add(InterceptorsWrapper(onRequest: (request, handler) {
      sends++;
      handler.resolve(Response(requestOptions: request, statusCode: 200));
    }));
    final cancellation = CancelToken()..cancel('account changed');
    expect(
        (await api.iosCheckout({'category': 'IELTS'},
            cancelToken: cancellation))['status'],
        ResponseStatus.failure);
    expect(sends, 0);
  });

  for (final status in [400, 409, 500]) {
    test('phone save preserves HTTP $status for caller-controlled recovery',
        () async {
      var requests = 0;
      transport.dio.interceptors.add(InterceptorsWrapper(
          onRequest: (request, handler) {
        requests++;
        handler.reject(DioException(requestOptions: request,
            response: Response(requestOptions: request, statusCode: status)));
      }));
      await expectLater(api.addContactPhone('251912345678'),
          throwsA(isA<DioException>().having(
              (error) => error.response?.statusCode, 'status', status)));
      expect(requests, 1);
    });
  }
}
