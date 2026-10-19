import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/dio_service.dart';
import 'package:yimaru_app/services/google_auth_service.dart';
import 'package:yimaru_app/services/localization_service.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';

class _Google extends Mock implements GoogleAuthService {
  @override
  Future<void> logout() async {}
}

class _Navigation extends Mock implements NavigationService {
  int logins = 0;
  @override
  Future<T?>? replaceWith<T>(String routeName,
      {dynamic arguments,
      int? id,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    logins++;
    return null;
  }
}

// Opt-in: real HTTP + Go handlers + PostgreSQL. DioService,
// AuthenticationService and SecureStorageService are the production classes.
// Only native keychain calls, Google sign-out and navigation are substituted.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final base = Platform.environment['REFRESH_HTTP_TEST_BASE_URL'];
  group('Mobile ↔ Go ↔ PostgreSQL refresh', () {
    const storageChannel =
        MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
    final stored = <String, String>{};
    late String originalBase;
    late HttpOverrides? originalHttpOverrides;
    late Dio raw, refreshClient;
    late DioService transport;
    late AuthenticationService auth;
    late _Navigation navigation;
    late int userId;
    int refreshRequests = 0;

    setUpAll(() {
      final uri = Uri.parse(base!);
      if (uri.scheme != 'http' ||
          !['127.0.0.1', 'localhost', '::1'].contains(uri.host) ||
          uri.userInfo.isNotEmpty) {
        throw StateError('Live tests require a loopback-only test server');
      }
      originalBase = kBaseUrl;
      kBaseUrl = base;
      // Flutter's unit-test binding otherwise replaces every real HTTP request
      // with a synthetic 400. Opt in to real network only for this guarded,
      // loopback-only integration suite, and restore the binding afterwards.
      originalHttpOverrides = HttpOverrides.current;
      HttpOverrides.global = null;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(storageChannel, (call) async {
        final args = call.arguments as Map;
        switch (call.method) {
          case 'read':
            return stored[args['key']];
          case 'write':
            stored[args['key'] as String] = args['value'] as String;
            return null;
          case 'deleteAll':
            stored.clear();
            return null;
          default:
            throw StateError('Unexpected keychain call: ${call.method}');
        }
      });
    });
    tearDownAll(() {
      kBaseUrl = originalBase;
      HttpOverrides.global = originalHttpOverrides;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(storageChannel, null);
    });

    Future<void> control([Map<String, dynamic> values = const {}]) async {
      await raw.post('/__qa/control', data: values);
    }

    Future<int> login() async {
      final fixture = (await raw.post('/__qa/account')).data;
      final login = (await raw.post('/api/v1/auth/customer-login', data: {
        'email': fixture['email'],
        'password': fixture['password'],
      }))
          .data['data'];
      await auth.saveUserCredential({
        'userId': login['user_id'],
        'accessToken': login['access_token'],
        'refreshToken': login['refresh_token']
      });
      return login['user_id'] as int;
    }

    Future<void> expireAccess() async {
      final expired = (await raw.get('/__qa/expired-access/$userId'))
          .data['access_token'] as String;
      await auth.saveTokens(
          access: expired,
          refresh: (await auth.getRefreshToken())!,
          expectedSessionGeneration: auth.sessionGeneration);
    }

    Future<Response<dynamic>> protected() => transport.dio
        .get('/api/v1/auth/test',
            options: Options(headers: {'company_id': '1'}))
        .timeout(const Duration(seconds: 5));
    Future<DioException> rejected(Future<Response<dynamic>> pending) async {
      try {
        await pending;
        fail('Expected request failure');
      } on DioException catch (error) {
        return error;
      }
    }

    Future<Map<String, dynamic>> stats([int? id]) async =>
        Map<String, dynamic>.from(
            (await raw.get('/__qa/stats/${id ?? userId}')).data);
    Future<void> until(bool Function() condition) async {
      for (var i = 0; i < 200 && !condition(); i++) {
        await Future<void>.delayed(const Duration(milliseconds: 5));
      }
      expect(condition(), isTrue);
    }

    setUp(() async {
      stored.clear();
      refreshRequests = 0;
      raw = Dio(BaseOptions(
          baseUrl: base!,
          connectTimeout: const Duration(seconds: 2),
          receiveTimeout: const Duration(seconds: 5)));
      navigation = _Navigation();
      locator.registerSingleton<NavigationService>(navigation);
      locator.registerSingleton<SecureStorageService>(SecureStorageService());
      locator.registerSingleton<GoogleAuthService>(_Google());
      locator.registerSingleton<LocalizationService>(LocalizationService());
      auth = AuthenticationService();
      locator.registerSingleton<AuthenticationService>(auth);
      refreshClient = Dio()
        ..interceptors.add(InterceptorsWrapper(onRequest: (request, handler) {
          refreshRequests++;
          handler.next(request);
        }));
      transport = DioService(refreshClient: refreshClient);
      await control();
      userId = await login();
    });
    tearDown(() async {
      transport.dio.close(force: true);
      refreshClient.close(force: true);
      raw.close(force: true);
      await locator.reset();
    });

    test('real expiry, two rotations, persistence and restored session work',
        () async {
      final oldRefresh = await auth.getRefreshToken();
      for (var i = 0; i < 2; i++) {
        await expireAccess();
        expect((await protected()).statusCode, 200);
      }
      final persisted = (await stats());
      expect(persisted['active_tokens'], 1);
      expect(persisted['revoked_tokens'], 2);
      expect(refreshRequests, 2);
      expect(await auth.getRefreshToken(), isNot(oldRefresh));
      expect(auth.user?.refreshToken, await auth.getRefreshToken());
      await expectLater(
          raw.post('/api/v1/auth/refresh', data: {
            'access_token': await auth.getAccessToken(),
            'refresh_token': oldRefresh,
          }),
          throwsA(isA<DioException>()
              .having((e) => e.response?.statusCode, 'status', 401)));
      final restored = AuthenticationService();
      expect((await restored.getUser())?.refreshToken,
          await auth.getRefreshToken());
      expect(navigation.logins, 0);
    });

    test(
        'five simultaneous real 401s cause one refresh and five successful retries',
        () async {
      await expireAccess();
      await control({'before_ms': 200});
      final results = await Future.wait(List.generate(5, (_) => protected()));
      expect(results.map((r) => r.statusCode), everyElement(200));
      expect(refreshRequests, 1);
      expect((await stats())['refresh_requests'], 1);
      expect((await stats())['active_tokens'], 1);
      expect(navigation.logins, 0);
    });

    test('a real HTTP 503 before rotation preserves the session and recovers',
        () async {
      await expireAccess();
      final old = await auth.getRefreshToken();
      await control({'status': 503});
      expect((await rejected(protected())).response?.statusCode, 503);
      expect(await auth.getRefreshToken(), old);
      expect((await stats())['revoked_tokens'], 0);
      expect(navigation.logins, 0);
      await control();
      expect((await protected()).statusCode, 200);
    });

    test(
        'PostgreSQL insertion failure rolls back revocation and Mobile retries safely',
        () async {
      await expireAccess();
      final old = await auth.getRefreshToken();
      await control({'reject_insert': true});
      expect((await rejected(protected())).response?.statusCode, 500);
      expect((await stats())['active_tokens'], 1);
      expect((await stats())['revoked_tokens'], 0);
      expect(await auth.getRefreshToken(), old);
      expect(navigation.logins, 0);
      await control();
      expect((await protected()).statusCode, 200);
      expect((await stats())['revoked_tokens'], 1);
    });

    for (final kind in ['expired', 'revoked', 'locked']) {
      test('real $kind refresh rejects and Mobile clears the session once',
          () async {
        await expireAccess();
        await raw
            .post('/__qa/invalidate/$userId', queryParameters: {'kind': kind});
        await control({'before_ms': 150});
        await Future.wait([rejected(protected()), rejected(protected())]);
        expect(await auth.getAccessToken(), isNull);
        expect(await auth.getRefreshToken(), isNull);
        expect(await auth.getUserId(), isNull);
        expect(navigation.logins, 1);
        expect(refreshRequests, 1);
      });
    }

    test('a delayed real rotation cannot overwrite a new account', () async {
      await expireAccess();
      await control({'before_ms': 300});
      final oldAccount = userId;
      final pending = rejected(protected());
      await until(() => refreshRequests == 1);
      final next = await login();
      await pending;
      expect(await auth.getUserId(), next);
      expect(auth.user?.userId, next);
      expect((await stats(oldAccount))['revoked_tokens'], 1);
      expect(navigation.logins, 0);
      expect((await protected()).statusCode, 200);
    });

    test(
        'lost response after real commit preserves login until definitive rejection',
        () async {
      await expireAccess();
      await control({'after_ms': 300});
      refreshClient.options.receiveTimeout = const Duration(milliseconds: 75);
      expect(
          (await rejected(protected())).type, DioExceptionType.receiveTimeout);
      expect((await stats())['revoked_tokens'], 1);
      expect(navigation.logins, 0);
      expect(await auth.getRefreshToken(), isNotNull);
      await Future<void>.delayed(const Duration(milliseconds: 350));
      await control();
      refreshClient.options.receiveTimeout = const Duration(seconds: 2);
      expect((await rejected(protected())).response?.statusCode, 401);
      expect(navigation.logins, 1);
    });
  },
      skip: base == null
          ? 'Requires the opt-in Go/PostgreSQL HTTP fixture'
          : false);
}
