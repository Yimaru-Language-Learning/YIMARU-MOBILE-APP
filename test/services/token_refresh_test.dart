import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
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
  String? access = 'old-access';
  String? refresh = 'old-refresh';
  int account = 7;
  int generation = 0;
  int saves = 0;
  int logouts = 0;
  @override
  int get sessionGeneration => generation;
  @override
  Future<String?> getAccessToken() async => access;
  @override
  Future<User?> getUser() async =>
      User(userId: account, accessToken: access, refreshToken: refresh);
  @override
  Future<void> saveTokens(
      {required String access,
      required String refresh,
      int? expectedSessionGeneration}) async {
    if (expectedSessionGeneration != generation) return;
    this.access = access;
    this.refresh = refresh;
    saves++;
  }

  @override
  Future<void> logout() async {
    generation++;
    logouts++;
    access = null;
    refresh = null;
  }

  void switchAccount() {
    generation++;
    account = 8;
    access = 'account-b-access';
    refresh = 'account-b-refresh';
  }
}

class _Navigation extends Mock implements NavigationService {
  int replacements = 0;
  @override
  Future<T?>? replaceWith<T>(String routeName,
      {dynamic arguments,
      int? id,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    replacements++;
    return null;
  }
}

class _Adapter implements HttpClientAdapter {
  _Adapter(this.respond);
  final Future<ResponseBody> Function(RequestOptions) respond;
  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<Uint8List>? stream,
          Future<void>? cancelFuture) =>
      respond(options);
  @override
  void close({bool force = false}) {}
}

ResponseBody _body(int status, [Object? data]) =>
    ResponseBody.fromString(jsonEncode(data ?? {'message': 'response'}), status,
        headers: {
          'content-type': ['application/json']
        });

void main() {
  late _Auth auth;
  late _Navigation navigation;
  late DioService service;
  late Dio refreshClient;
  late Future<ResponseBody> Function(RequestOptions) protected;
  late Future<ResponseBody> Function(RequestOptions) refresh;
  int refreshCalls = 0;
  int protectedCalls = 0;
  int metadataReads = 0;
  final refreshBodies = <Map<String, dynamic>>[];
  setUp(() {
    auth = _Auth();
    navigation = _Navigation();
    refreshCalls = protectedCalls = 0;
    metadataReads = 0;
    refreshBodies.clear();
    locator.registerSingleton<AuthenticationService>(auth);
    locator.registerSingleton<NavigationService>(navigation);
    final client = Dio()
      ..httpClientAdapter = _Adapter((options) {
        expect(options.headers['X-App-Version'], '1.5.2');
        expect(options.headers['X-App-Build'], '83');
        expect(options.headers['X-App-Platform'], 'ios');
        protectedCalls++;
        return protected(options);
      });
    refreshClient = Dio()
      ..httpClientAdapter = _Adapter((options) {
        expect(options.headers['X-App-Version'], '1.5.2');
        expect(options.headers['X-App-Build'], '83');
        expect(options.headers['X-App-Platform'], 'ios');
        refreshCalls++;
        refreshBodies.add(Map<String, dynamic>.from(options.data));
        return refresh(options);
      });
    service = DioService(
      client: client,
      refreshClient: refreshClient,
      appMetadata: AppRequestMetadata(
        platform: 'ios',
        loadPackageInfo: () async {
          metadataReads++;
          return PackageInfo(
            appName: 'Yimaru',
            packageName: 'test.yimaru',
            version: '1.5.2',
            buildNumber: '83',
          );
        },
      ),
    );
    protected = (options) async => _body(
        options.headers['Authorization'] == 'Bearer old-access' ? 401 : 200);
    refresh = (_) async => _body(200, {
          'data': {
            'access_token': 'new-access-$refreshCalls',
            'refresh_token': 'new-refresh-$refreshCalls',
          }
        });
  });
  tearDown(() async {
    service.dio.close(force: true);
    refreshClient.close(force: true);
    await locator.reset();
  });
  Future<Response<dynamic>> request([String path = '/profile']) =>
      service.dio.get(path).timeout(const Duration(seconds: 3));
  Future<DioException> rejected(Future<Response<dynamic>> future) async {
    try {
      await future;
      fail('Expected request failure');
    } on DioException catch (error) {
      return error;
    }
  }

  Future<void> until(bool Function() condition) async {
    for (var i = 0; i < 100 && !condition(); i++) {
      await Future<void>.delayed(const Duration(milliseconds: 1));
    }
    expect(condition(), isTrue);
  }

  test('login and restored-session requests carry the same cached build',
      () async {
    auth.access = null;
    protected = (_) async => _body(200);
    await service.dio
        .post('/auth/login', data: {'email': 'tester@example.com'});
    auth.access = 'restored-access';
    await request();
    expect(protectedCalls, 2);
    expect(metadataReads, 1);
  });

  test('two expired-access cycles save and use the rotated token', () async {
    expect((await request()).statusCode, 200);
    expect(auth.saves, 1);
    final firstAccess = auth.access;
    protected = (options) async => _body(
        options.headers['Authorization'] == 'Bearer $firstAccess' ? 401 : 200);
    expect((await request()).statusCode, 200);
    expect(refreshBodies.map((b) => b['refresh_token']),
        ['old-refresh', 'new-refresh-1']);
    expect(auth.refresh, 'new-refresh-2');
    expect(auth.logouts, 0);
  });

  test('concurrent 401s share one refresh and all retry', () async {
    final gate = Completer<void>();
    refresh = (_) async {
      await gate.future;
      return _body(200, {
        'data': {'access_token': 'new-access', 'refresh_token': 'new-refresh'}
      });
    };
    final pending = Future.wait([request('/a'), request('/b'), request('/c')]);
    await until(() => refreshCalls == 1 && protectedCalls == 3);
    gate.complete();
    expect((await pending).map((r) => r.statusCode), [200, 200, 200]);
    expect(refreshCalls, 1);
  });

  test('late old-token 401 reuses fresh access without another rotation',
      () async {
    final gate = Completer<void>();
    protected = (options) async {
      if (options.headers['Authorization'] != 'Bearer old-access') {
        return _body(200);
      }
      if (options.path == '/late') await gate.future;
      return _body(401);
    };
    final late = request('/late');
    await until(() => protectedCalls == 1);
    await request('/first');
    gate.complete();
    expect((await late).statusCode, 200);
    expect(refreshCalls, 1);
  });

  test('a repeated 401 after refresh fails once instead of looping', () async {
    protected = (_) async => _body(401);
    expect((await rejected(request())).response?.statusCode, 401);
    expect(refreshCalls, 1);
    expect(protectedCalls, 2);
    expect(auth.logouts, 0);
  });

  test('one retry failure does not strand other waiters', () async {
    final gate = Completer<void>();
    refresh = (_) async {
      await gate.future;
      return _body(200, {
        'data': {'access_token': 'new-access', 'refresh_token': 'new-refresh'}
      });
    };
    protected = (options) async =>
        _body(options.headers['Authorization'] == 'Bearer old-access'
            ? 401
            : options.path == '/bad'
                ? 500
                : 200);
    final bad = rejected(request('/bad'));
    final good = request('/good');
    await until(() => refreshCalls == 1 && protectedCalls == 2);
    gate.complete();
    expect((await bad).response?.statusCode, 500);
    expect((await good).statusCode, 200);
    expect(refreshCalls, 1);
  });

  for (final status in [429, 500, 503]) {
    test('refresh HTTP $status completes all waiters and preserves login',
        () async {
      final gate = Completer<void>();
      refresh = (_) async {
        await gate.future;
        return _body(status);
      };
      final pending =
          Future.wait([rejected(request('/a')), rejected(request('/b'))]);
      await until(() => refreshCalls == 1 && protectedCalls == 2);
      gate.complete();
      expect(
          (await pending).map((e) => e.response?.statusCode), [status, status]);
      expect(auth.logouts, 0);
      expect(auth.refresh, 'old-refresh');
      refresh = (_) async => _body(200, {
            'data': {
              'access_token': 'recovered-access',
              'refresh_token': 'recovered-refresh'
            }
          });
      expect((await request()).statusCode, 200);
    });
  }
  for (final type in [
    DioExceptionType.connectionError,
    DioExceptionType.connectionTimeout,
    DioExceptionType.receiveTimeout
  ]) {
    test('refresh $type preserves credentials and permits recovery', () async {
      refresh = (options) async =>
          throw DioException(requestOptions: options, type: type);
      expect((await rejected(request())).type, type);
      expect(auth.logouts, 0);
      refresh = (_) async => _body(200, {
            'data': {
              'access_token': 'recovered-access',
              'refresh_token': 'recovered-refresh'
            }
          });
      expect((await request()).statusCode, 200);
    });
  }
  for (final status in [401, 403]) {
    test('definitive refresh HTTP $status logs out once for all waiters',
        () async {
      final gate = Completer<void>();
      refresh = (_) async {
        await gate.future;
        return _body(status);
      };
      final pending =
          Future.wait([rejected(request('/a')), rejected(request('/b'))]);
      await until(() => refreshCalls == 1 && protectedCalls == 2);
      gate.complete();
      await pending;
      expect(auth.logouts, 1);
      expect(navigation.replacements, 1);
    });
  }
  for (final body in [
    null,
    {'data': {}},
    {
      'data': {'access_token': 1, 'refresh_token': 'new'}
    },
    {
      'data': {'access_token': 'new', 'refresh_token': 'old-refresh'}
    }
  ]) {
    test('malformed or unrotated response $body does not clear the session',
        () async {
      refresh = (_) async => _body(200, body);
      await rejected(request());
      expect(auth.logouts, 0);
      expect(auth.saves, 0);
    });
  }
  for (final status in [200, 401]) {
    test(
        'late refresh HTTP $status cannot overwrite or log out another account',
        () async {
      final gate = Completer<void>();
      refresh = (_) async {
        await gate.future;
        return _body(status, {
          'data': {
            'access_token': 'late-access',
            'refresh_token': 'late-refresh'
          }
        });
      };
      final pending = rejected(request());
      await until(() => refreshCalls == 1);
      auth.switchAccount();
      gate.complete();
      await pending;
      expect(auth.access, 'account-b-access');
      expect(auth.saves, 0);
      expect(auth.logouts, 0);
      expect(navigation.replacements, 0);
      expect(protectedCalls, 1);
      expect((await request()).statusCode, 200);
    });
  }
  test('an old refresh cannot clear a new session\'s in-flight refresh',
      () async {
    final oldGate = Completer<void>();
    final newGate = Completer<void>();
    protected = (options) async =>
        _body(options.headers['Authorization'] == 'Bearer fresh-b' ? 200 : 401);
    refresh = (options) async {
      final old = options.data['refresh_token'] == 'old-refresh';
      await (old ? oldGate : newGate).future;
      return _body(200, {
        'data': {
          'access_token': old ? 'late-a' : 'fresh-b',
          'refresh_token': old ? 'late-ar' : 'fresh-br',
        }
      });
    };
    final old = rejected(request('/old'));
    await until(() => refreshCalls == 1);
    auth.switchAccount();
    final first = request('/b1');
    await until(() => refreshCalls == 2);
    oldGate.complete();
    await old;
    final second = request('/b2');
    await until(() => protectedCalls == 3);
    newGate.complete();
    expect((await Future.wait([first, second])).map((r) => r.statusCode),
        [200, 200]);
    expect(refreshCalls, 2);
    expect(auth.access, 'fresh-b');
  });
  test('a lost committed rotation is not an immediate logout or replay loop',
      () async {
    refresh = (options) async => throw DioException(
        requestOptions: options, type: DioExceptionType.receiveTimeout);
    await rejected(request());
    expect(auth.logouts, 0);
    // The server may have committed before its response was lost. Once it
    // definitively rejects the old token, signing in again is unavoidable.
    refresh = (_) async => _body(401);
    await rejected(request());
    expect(auth.logouts, 1);
    expect(navigation.replacements, 1);
    expect(refreshCalls, 2);
  });
  test('a late protected 401 from the previous account is not replayed',
      () async {
    final gate = Completer<void>();
    protected = (_) async {
      await gate.future;
      return _body(401);
    };
    final pending = rejected(request());
    await until(() => protectedCalls == 1);
    auth.switchAccount();
    gate.complete();
    await pending;
    expect(refreshCalls, 0);
    expect(auth.logouts, 0);
  });
  test('cancelling one waiter does not cancel the shared refresh', () async {
    final gate = Completer<void>();
    refresh = (_) async {
      await gate.future;
      return _body(200, {
        'data': {'access_token': 'new-access', 'refresh_token': 'new-refresh'}
      });
    };
    final token = CancelToken();
    final cancelled = rejected(service.dio.get('/cancel', cancelToken: token));
    final good = request('/good');
    await until(() => refreshCalls == 1 && protectedCalls == 2);
    token.cancel();
    expect((await cancelled).type, DioExceptionType.cancel);
    gate.complete();
    expect((await good).statusCode, 200);
    expect(refreshCalls, 1);
  });
  test('refresh has bounded timeouts and logs no credential values', () async {
    final messages = <String>[];
    final previous = debugPrint;
    debugPrint = (message, {wrapWidth}) {
      if (message != null) messages.add(message);
    };
    addTearDown(() => debugPrint = previous);
    expect(refreshClient.options.connectTimeout, const Duration(seconds: 10));
    expect(refreshClient.options.receiveTimeout, const Duration(seconds: 15));
    await request('/profile?token=secret-query');
    final logs = messages.join('\n');
    for (final value in [
      'old-access',
      'old-refresh',
      'new-access-1',
      'new-refresh-1',
      'secret-query'
    ]) {
      expect(logs, isNot(contains(value)));
    }
  });
}
