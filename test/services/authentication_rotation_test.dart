import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/google_auth_service.dart';
import 'package:yimaru_app/services/localization_service.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';

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
}
