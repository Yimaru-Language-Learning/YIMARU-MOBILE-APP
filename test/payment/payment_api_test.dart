import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/dio_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

class TestDioService extends Mock implements DioService {
  TestDioService(this.client);
  final Dio client;
  @override
  Dio get dio => client;
}

void main() {
  late Dio client;
  late ApiService api;
  setUp(() {
    client = Dio();
    locator.registerSingleton<DioService>(TestDioService(client));
    api = ApiService();
  });
  tearDown(() async {
    client.close();
    await locator.reset();
  });

  for (final direct in [false, true]) {
    for (final status in [400, 401, 409, 408, 500, 503, null]) {
      test('${direct ? 'direct' : 'checkout'} initiation HTTP $status',
          () async {
        client.interceptors
            .add(InterceptorsWrapper(onRequest: (options, handler) {
          handler.reject(DioException(
            requestOptions: options,
            type: status == null
                ? DioExceptionType.receiveTimeout
                : DioExceptionType.badResponse,
            response: status == null
                ? null
                : Response(
                    requestOptions: options,
                    statusCode: status,
                    data: {'message': 'Could not initiate'}),
          ));
        }));
        final response = direct
            ? await api.createDirectPaymentRequest({'plan_id': 2})
            : await api.createSubscriptionRequest({'plan_id': 2});
        expect(response['status'], ResponseStatus.failure);
        expect(response['payment_outcome_unknown'],
            status == null || status >= 500 || status == 408);
      });
    }
  }

  test('verification preserves authoritative status without model conversion',
      () async {
    client.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      expect(options.uri.path, '/api/v1/payments/verify/session-123');
      handler.resolve(Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          'data': {'status': 'cancelled'}
        },
      ));
    }));
    expect(await api.getCheckoutPaymentStatus('session-123'), 'CANCELLED');
  });

  test('verification network error is uncertain, not failed', () async {
    client.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      handler.reject(DioException(
          requestOptions: options, type: DioExceptionType.receiveTimeout));
    }));
    expect(await api.getCheckoutPaymentStatus('session-123'), isNull);
  });

  test('unreadable successful initiation response is uncertain', () async {
    client.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      handler.resolve(
          Response(requestOptions: options, statusCode: 200, data: {}));
    }));
    final response = await api.createSubscriptionRequest({'plan_id': 2});
    expect(response['status'], ResponseStatus.failure);
    expect(response['payment_outcome_unknown'], isTrue);
  });
}
