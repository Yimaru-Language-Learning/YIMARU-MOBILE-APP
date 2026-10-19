import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/google_auth_service.dart';
import 'package:yimaru_app/services/localization_service.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';
import 'package:yimaru_app/services/push_notification_service.dart';

class _Storage extends Mock implements SecureStorageService {
  final values = <String, Object>{};
  Completer<void>? tokenWrite, clearGate, userRead;
  bool writing = false, clearing = false, reading = false;
  @override
  Future<void> setString(String key, String value) async {
    if (key == 'accessToken' && tokenWrite != null) {
      writing = true;
      await tokenWrite!.future;
    }
    values[key] = value;
  }

  @override
  Future<String?> getString(String key) async {
    if (key == 'region' && userRead != null) {
      reading = true;
      await userRead!.future;
    }
    return values[key] as String?;
  }

  @override
  Future<void> setInt(String key, int value) async {
    values[key] = value;
  }

  @override
  Future<int?> getInt(String key) async => values[key] as int?;
  @override
  Future<bool?> getBool(String key) async => values[key] as bool?;
  @override
  Future<void> setBool(String key, bool value) async {
    values[key] = value;
  }

  @override
  Future<void> clear() async {
    clearing = true;
    if (clearGate != null) await clearGate!.future;
    values.clear();
  }
}

class _Google extends Mock implements GoogleAuthService {
  @override
  Future<void> logout() async {}
}

class _Push extends Mock implements PushNotificationService {
  final Future<void> Function(String?) cleanup;
  _Push(this.cleanup);
  @override
  Future<void> prepareForLogout({String? accessToken}) => cleanup(accessToken);
}

void main() {
  late _Storage storage;
  late AuthenticationService auth;
  setUp(() async {
    storage = _Storage();
    locator.registerSingleton<SecureStorageService>(storage);
    locator.registerSingleton<GoogleAuthService>(_Google());
    locator.registerSingleton<LocalizationService>(LocalizationService());
    auth = AuthenticationService();
    await auth.saveUserCredential(
        {'userId': 7, 'accessToken': 'a', 'refreshToken': 'r'});
  });
  tearDown(() => locator.reset());
  Future<void> until(bool Function() condition) async {
    for (var i = 0; i < 100 && !condition(); i++) {
      await Future<void>.delayed(const Duration(milliseconds: 1));
    }
    expect(condition(), isTrue);
  }

  test('rotation updates secure storage and in-memory credentials', () async {
    await auth.saveTokens(
        access: 'new-a',
        refresh: 'new-r',
        expectedSessionGeneration: auth.sessionGeneration);
    expect(await auth.getAccessToken(), 'new-a');
    expect(auth.user?.refreshToken, 'new-r');
  });

  test(
      'logout cleans push using a credential snapshot before deleting credentials',
      () async {
    var calls = 0;
    locator.registerSingleton<PushNotificationService>(_Push((access) async {
      calls++;
      expect(access, 'a');
      expect(storage.values['userId'], 7);
    }));
    await auth.logout();
    expect(calls, 1);
    expect(await auth.getAccessToken(), isNull);
    expect(await auth.getUserId(), isNull);
  });

  test('push cleanup failure never prevents local logout', () async {
    locator.registerSingleton<PushNotificationService>(_Push((_) async {
      throw StateError('native plugin temporarily unavailable');
    }));
    await auth.logout();
    expect(await auth.getAccessToken(), isNull);
    expect(auth.user, isNull);
  });
  test('stale rotation after a new login cannot write either token', () async {
    final generation = auth.sessionGeneration;
    await auth.saveUserCredential(
        {'userId': 8, 'accessToken': 'b', 'refreshToken': 'br'});
    await auth.saveTokens(
        access: 'late-a',
        refresh: 'late-r',
        expectedSessionGeneration: generation);
    expect(await auth.getAccessToken(), 'b');
    expect(auth.user?.userId, 8);
    expect(auth.user?.refreshToken, 'br');
  });
  test('logout and login serialize behind an in-flight rotation', () async {
    storage.tokenWrite = Completer<void>();
    final rotation = auth.saveTokens(
        access: 'late-a',
        refresh: 'late-r',
        expectedSessionGeneration: auth.sessionGeneration);
    await until(() => storage.writing);
    final logout = auth.logout();
    final login = auth.saveUserCredential(
        {'userId': 8, 'accessToken': 'b', 'refreshToken': 'br'});
    final read = auth.getAccessToken();
    storage.tokenWrite!.complete();
    await Future.wait([rotation, logout, login]);
    expect(await read, 'b');
    expect(auth.user?.userId, 8);
    expect(await auth.getRefreshToken(), 'br');
  });
  test('new credentials are not deleted by a delayed logout clear', () async {
    storage.clearGate = Completer<void>();
    final logout = auth.logout();
    await until(() => storage.clearing);
    final login = auth.saveUserCredential(
        {'userId': 8, 'accessToken': 'b', 'refreshToken': 'br'});
    storage.clearGate!.complete();
    await Future.wait([logout, login]);
    expect(await auth.getAccessToken(), 'b');
    expect(await auth.getUserId(), 8);
  });
  test('late restored profile cannot overwrite the new account in memory',
      () async {
    storage.userRead = Completer<void>();
    final restored = auth.getUser();
    await until(() => storage.reading);
    await auth.saveUserCredential(
        {'userId': 8, 'accessToken': 'b', 'refreshToken': 'br'});
    storage.userRead!.complete();
    await restored;
    expect(auth.user?.userId, 8);
    expect(auth.user?.accessToken, 'b');
  });

  test('Apple onboarding name is trimmed and remains memory-only', () async {
    await auth.saveUserCredential(
      {'userId': 8, 'accessToken': 'b', 'refreshToken': 'br'},
      onboardingName: '  Apple User  ',
    );
    expect(auth.onboardingName, 'Apple User');
    expect(storage.values.containsKey('onboardingName'), isFalse);
    expect(auth.user?.userId, 8);
    await auth.saveTokens(
      access: 'rotated-b',
      refresh: 'rotated-br',
      expectedSessionGeneration: auth.sessionGeneration,
    );
    expect(auth.onboardingName, 'Apple User');
  });

  for (final name in [null, '', '   ']) {
    test('a new login with name $name clears the previous Apple prefill',
        () async {
      await auth.saveUserCredential(
        {'userId': 8, 'accessToken': 'b', 'refreshToken': 'br'},
        onboardingName: 'Previous User',
      );
      await auth.saveUserCredential(
        {'userId': 9, 'accessToken': 'c', 'refreshToken': 'cr'},
        onboardingName: name,
      );
      expect(auth.onboardingName, isNull);
      expect(auth.user?.userId, 9);
    });
  }

  test('logout clears Apple prefill before waiting for a token write',
      () async {
    await auth.saveUserCredential(
      {'userId': 8, 'accessToken': 'b', 'refreshToken': 'br'},
      onboardingName: 'Apple User',
    );
    storage.tokenWrite = Completer<void>();
    final rotation = auth.saveTokens(
      access: 'rotated-b',
      refresh: 'rotated-br',
      expectedSessionGeneration: auth.sessionGeneration,
    );
    await until(() => storage.writing);
    final logout = auth.logout();
    expect(auth.onboardingName, isNull);
    storage.tokenWrite!.complete();
    await Future.wait([rotation, logout]);
    expect(auth.onboardingName, isNull);
  });

  test('a delayed Apple login cannot restore its name after logout starts',
      () async {
    storage.tokenWrite = Completer<void>();
    storage.clearGate = Completer<void>();
    final login = auth.saveUserCredential(
      {'userId': 8, 'accessToken': 'b', 'refreshToken': 'br'},
      onboardingName: 'Old Apple User',
    );
    await until(() => storage.writing);
    final logout = auth.logout();
    storage.tokenWrite!.complete();
    await until(() => storage.clearing);
    expect(auth.onboardingName, isNull);
    storage.clearGate!.complete();
    await Future.wait([login, logout]);
    expect(auth.user, isNull);
    expect(auth.onboardingName, isNull);
  });

  test('queued logins retain only the last account onboarding name', () async {
    storage.tokenWrite = Completer<void>();
    final first = auth.saveUserCredential(
      {'userId': 8, 'accessToken': 'b', 'refreshToken': 'br'},
      onboardingName: 'Previous Apple User',
    );
    await until(() => storage.writing);
    final second = auth.saveUserCredential(
      {'userId': 9, 'accessToken': 'c', 'refreshToken': 'cr'},
      onboardingName: 'Current Apple User',
    );
    storage.tokenWrite!.complete();
    await Future.wait([first, second]);
    expect(auth.user?.userId, 9);
    expect(auth.onboardingName, 'Current Apple User');
  });
}
