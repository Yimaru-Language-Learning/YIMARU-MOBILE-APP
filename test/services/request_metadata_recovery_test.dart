import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/app_request_metadata.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/dio_service.dart';

class _Auth extends Mock implements AuthenticationService {
  int generation = 0;
  String access = 'current-access';
  int refreshReads = 0;
  @override
  int get sessionGeneration => generation;
  @override
  Future<String?> getAccessToken() async => access;
  @override
  Future<User?> getUser() async {
    refreshReads++;
    return null;
  }
}

class _Navigation extends Mock implements NavigationService {}

PackageInfo _info() => PackageInfo(
      appName: 'Yimaru',
      packageName: 'test.yimaru',
      version: '1.5.2',
      buildNumber: '83',
    );

void main() {
  late _Auth auth;
  late DioService transport;
  setUp(() {
    auth = _Auth();
    locator.registerSingleton<AuthenticationService>(auth);
    locator.registerSingleton<NavigationService>(_Navigation());
  });
  tearDown(() async {
    transport.dio.close(force: true);
    await locator.reset();
  });

  test(
      'metadata recovery never stalls requests or changes background 401 policy',
      () async {
    var now = DateTime.utc(2026, 10, 19);
    var calls = 0;
    final pending = Completer<PackageInfo>();
    transport = DioService(
      appMetadata: AppRequestMetadata(
        platform: 'ios',
        now: () => now,
        loadPackageInfo: () async {
          if (++calls == 1) throw StateError('temporary plugin failure');
          return pending.future;
        },
      ),
    );
    final headers = <Map<String, dynamic>>[];
    transport.dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        headers.add(Map.of(options.headers));
        if (options.path == '/devices/register') {
          handler.reject(
            DioException(
              requestOptions: options,
              type: DioExceptionType.badResponse,
              response: Response(requestOptions: options, statusCode: 401),
            ),
            true,
          );
        } else {
          handler.resolve(Response(requestOptions: options, statusCode: 200));
        }
      },
    ));
    await transport.dio.get('/profile');
    expect(headers.last['X-App-Version'], isNull);
    now = now.add(const Duration(seconds: 31));
    await expectLater(
      transport.dio
          .post('/devices/register',
              options: Options(extra: {
                DioService.backgroundDeviceRegistration: true,
              }))
          .timeout(const Duration(milliseconds: 500)),
      throwsA(isA<DioException>()
          .having((error) => error.response?.statusCode, 'status', 401)),
    );
    await transport.dio
        .get('/profile')
        .timeout(const Duration(milliseconds: 500));
    expect(calls, 2);
    expect(auth.refreshReads, 0);
    expect(headers.last['Authorization'], 'Bearer current-access');
    expect(headers.last['X-App-Version'], isNull);
    pending.complete(_info());
    await Future<void>.delayed(Duration.zero);
    await transport.dio.get('/profile');
    expect(headers.last['X-App-Version'], '1.5.2');
    expect(headers.last['X-App-Build'], '83');
    expect(headers.last['X-App-Platform'], 'ios');
  });

  test('account switch during initial metadata lookup cancels old request',
      () async {
    final pending = Completer<PackageInfo>();
    final lookupStarted = Completer<void>();
    transport = DioService(
      appMetadata: AppRequestMetadata(
        platform: 'android',
        loadPackageInfo: () {
          lookupStarted.complete();
          return pending.future;
        },
      ),
    );
    var requests = 0;
    transport.dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        requests++;
        expect(options.headers['Authorization'], 'Bearer new-account-access');
        handler.resolve(Response(requestOptions: options, statusCode: 200));
      },
    ));
    final oldRequest = transport.dio.get('/old-account');
    await lookupStarted.future;
    auth.generation++;
    auth.access = 'new-account-access';
    pending.complete(_info());
    await expectLater(
      oldRequest,
      throwsA(isA<DioException>()
          .having((error) => error.type, 'type', DioExceptionType.cancel)),
    );
    expect(requests, 0);
    await transport.dio.get('/new-account');
    expect(requests, 1);
  });
}
