import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/apple_auth_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/google_auth_service.dart';
import 'package:yimaru_app/services/localization_service.dart';
import 'package:yimaru_app/services/push_notification_service.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/register/register_view.form.dart';
import 'package:yimaru_app/ui/views/register/register_viewmodel.dart';

class _FakeApiService implements ApiService {
  final requestStarted = Completer<void>();
  final response = Completer<Map<String, dynamic>>();
  Map<String, dynamic>? requestData;

  @override
  Future<Map<String, dynamic>> appleAuth(Map<String, dynamic> data) {
    requestData = Map<String, dynamic>.from(data);
    requestStarted.complete();
    return response.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeAppleAuthService implements AppleAuthService {
  _FakeAppleAuthService({required this.credential, required this.displayEmail});

  final AuthorizationCredentialAppleID? credential;
  final String? displayEmail;
  final List<VoidCallback> _listeners = [];
  Object? authorizationError;

  @override
  AuthorizationCredentialAppleID? get appleCredential => credential;

  @override
  String? get emailForDisplay => displayEmail;

  @override
  bool get isSupported => true;

  @override
  Future<void> appleAuth() async {
    final error = authorizationError;
    if (error != null) throw error;
  }

  @override
  void addListener(VoidCallback listener) => _listeners.add(listener);

  @override
  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeStatusCheckerService implements StatusCheckerService {
  @override
  Future<bool> checkConnection() async => true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeLocalizationService implements LocalizationService {
  final List<VoidCallback> _listeners = [];

  @override
  Map<String, dynamic> get selectedLanguage => {
        'code': 'en',
        'language': 'English',
      };

  @override
  void addListener(VoidCallback listener) => _listeners.add(listener);

  @override
  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeNavigationService implements NavigationService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeGoogleAuthService implements GoogleAuthService {
  final List<VoidCallback> _listeners = [];

  @override
  void addListener(VoidCallback listener) => _listeners.add(listener);

  @override
  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeAuthenticationService implements AuthenticationService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakePushNotificationService implements PushNotificationService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const _credential = AuthorizationCredentialAppleID(
  userIdentifier: 'apple-user-id',
  givenName: 'Test',
  familyName: 'User',
  authorizationCode: 'authorization-code',
  email: 'apple@example.com',
  identityToken: 'signed.identity.token',
  state: null,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RegisterViewModel Tests -', () {
    late _FakeApiService apiService;
    late _FakeAppleAuthService appleAuthService;

    setUp(() {
      apiService = _FakeApiService();
      appleAuthService = _FakeAppleAuthService(
        credential: _credential,
        displayEmail: 'apple@example.com',
      );

      locator.registerSingleton<ApiService>(apiService);
      locator.registerSingleton<StatusCheckerService>(
        _FakeStatusCheckerService(),
      );
      locator.registerSingleton<NavigationService>(_FakeNavigationService());
      locator.registerSingleton<GoogleAuthService>(_FakeGoogleAuthService());
      locator.registerSingleton<AppleAuthService>(appleAuthService);
      locator.registerSingleton<LocalizationService>(
        _FakeLocalizationService(),
      );
      locator.registerSingleton<AuthenticationService>(
        _FakeAuthenticationService(),
      );
      locator.registerSingleton<PushNotificationService>(
        _FakePushNotificationService(),
      );
    });

    tearDown(() async => locator.reset());

    test('prefills and locks Apple email while backend authentication runs',
        () async {
      final viewModel = RegisterViewModel(
        appleSuccessNotifier: (_) {},
        appleErrorNotifier: (_) {},
      )..emailValue = 'manual@example.com';

      final registration = viewModel.registerWithApple();
      await apiService.requestStarted.future;

      expect(viewModel.emailValue, 'apple@example.com');
      expect(viewModel.isAppleEmailLocked, isTrue);
      expect(viewModel.busy(StateObjects.registerWithApple), isTrue);
      expect(apiService.requestData, {
        'id_token': 'signed.identity.token',
        'email': 'apple@example.com',
        'first_name': 'Test',
        'last_name': 'User',
      });

      apiService.response.complete({
        'status': ResponseStatus.failure,
        'message': 'Apple login failed',
      });
      await registration;

      expect(viewModel.emailValue, 'manual@example.com');
      expect(viewModel.isAppleEmailLocked, isFalse);
      expect(viewModel.busy(StateObjects.registerWithApple), isFalse);
    });

    test('does not start backend authentication when Apple is cancelled',
        () async {
      appleAuthService.authorizationError =
          const SignInWithAppleAuthorizationException(
        code: AuthorizationErrorCode.canceled,
        message: 'Cancelled by user',
      );
      final viewModel = RegisterViewModel(
        appleSuccessNotifier: (_) {},
        appleErrorNotifier: (_) {},
      )..emailValue = 'manual@example.com';

      await viewModel.registerWithApple();

      expect(apiService.requestData, isNull);
      expect(viewModel.emailValue, 'manual@example.com');
      expect(viewModel.isAppleEmailLocked, isFalse);
    });
  });
}
