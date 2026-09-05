import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../../../app/app.locator.dart';
import '../../../models/user.dart';
import '../../../services/apple_auth_service.dart';
import '../../../services/google_auth_service.dart';
import '../../../services/localization_service.dart';
import '../../../services/push_notification_service.dart';
import '../../../services/status_checker_service.dart';
import 'register_view.form.dart';

class RegisterViewModel extends ReactiveViewModel
    with FormStateHelper
    implements FormViewModel {
  RegisterViewModel({
    void Function(String)? appleSuccessNotifier,
    void Function(String)? appleErrorNotifier,
  })  : _appleSuccessNotifier = appleSuccessNotifier ?? showSuccessToast,
        _appleErrorNotifier = appleErrorNotifier ?? showErrorToast;

  final void Function(String) _appleSuccessNotifier;

  final void Function(String) _appleErrorNotifier;

  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _googleAuthService = locator<GoogleAuthService>();

  final _appleAuthService = locator<AppleAuthService>();

  final _localizationService = locator<LocalizationService>();

  final _authenticationService = locator<AuthenticationService>();

  final _pushNotificationService = locator<PushNotificationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_googleAuthService, _appleAuthService, _localizationService];

  // Google user
  GoogleSignInAccount? get _googleUser => _googleAuthService.googleUser;

  GoogleSignInAccount? get googleUser => _googleUser;

  bool get isAppleSignInAvailable => _appleAuthService.isSupported;

  // Languages
  Map<String, dynamic> get _selectedLanguage =>
      _localizationService.selectedLanguage;

  Map<String, dynamic> get selectedLanguage => _selectedLanguage;

  // Navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  // Email
  bool _focusEmail = false;

  bool get focusEmail => _focusEmail;

  bool _isAppleEmailLocked = false;

  bool get isAppleEmailLocked => _isAppleEmailLocked;

  String? _emailBeforeApple;

  // Password
  bool _length = false;

  bool get length => _length;

  bool _focusPassword = false;

  bool get focusPassword => _focusPassword;

  bool _obscurePassword = true;

  bool get obscurePassword => _obscurePassword;

  bool _passwordMatch = false;

  bool get passwordMatch => _passwordMatch;

  // Confirm password
  bool _focusConfirmPassword = false;

  bool get focusConfirmPassword => _focusConfirmPassword;

  bool _obscureConfirmPassword = true;

  bool get obscureConfirmPassword => _obscureConfirmPassword;

  // Phone number
  bool _focusPhoneNumber = false;

  bool get focusPhoneNumber => _focusPhoneNumber;

  // Terms and conditions
  bool _agree = false;

  bool get agree => _agree;

  // Focus otp
  bool _focusOtp = false;

  bool get focusOtp => _focusOtp;

  // Focus node
  final FocusNode _focusNode = FocusNode();

  FocusNode get focusNode => _focusNode;

  // Registration type
  SignUpMethod? _signUpMethod;

  SignUpMethod? get signUpMethod => _signUpMethod;

  // Resend button state
  bool _buttonActive = false;

  bool get buttonActive => _buttonActive;

  DateTime _resendTime =
      DateTime.now().add(const Duration(minutes: 3, seconds: 0));

  DateTime get resendTime => _resendTime;

  // User data
  final Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData => _userData;

  // Email
  void setEmailFocus() {
    _focusEmail = true;
    rebuildUi();
  }

  // Password
  void setPasswordFocus() {
    _focusPassword = true;
    rebuildUi();
  }

  void validatePassword(
      {required String password, required String confirmPassword}) {
    if (password.length > 8) {
      _length = true;
    } else {
      _length = false;
    }

    if (password == confirmPassword) {
      _passwordMatch = true;
    } else {
      _passwordMatch = false;
    }
    rebuildUi();
  }

  double validationProgress() {
    int completed = 0;
    if (_length) completed++;
    if (_passwordMatch) completed++;
    return completed / 2; // returns 0.0 → 1.0
  }

  void setObscurePassword() {
    _obscurePassword = !_obscurePassword;
    rebuildUi();
  }

  // Confirm password
  void setConfirmPasswordFocus() {
    _focusConfirmPassword = true;
    rebuildUi();
  }

  void setObscureConfirmPassword() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    rebuildUi();
  }

  // Phone number
  void setPhoneNumberFocus() {
    _focusPhoneNumber = true;
    rebuildUi();
  }

  // Otp
  void setOtpFocus() {
    _focusOtp = true;
    rebuildUi();
  }

  // Terms and  Conditions
  void setAgreement(bool value) {
    _agree = value;
    rebuildUi();
  }

  void setResendButton() {
    _buttonActive = true;
    rebuildUi();
  }

  void resetButton() {
    _buttonActive = false;

    _resendTime = DateTime.now().add(const Duration(minutes: 3, seconds: 0));
  }

  // Validate otp
  Future<void> validateOtp(String otp) async {}

  // Add user data
  void addUserData(Map<String, dynamic> data) {
    _userData.addAll(data);
  }

  void clearUserData() {
    _userData.clear();
  }

  // Form reset

  // Reset register with email screen
  void resetRegisterWithEmailScreen() {
    _focusEmail = false;
    _isAppleEmailLocked = false;
    _emailBeforeApple = null;
    rebuildUi();
  }

  void _lockAppleEmail(String? email) {
    _emailBeforeApple = emailValue;
    final normalizedEmail = email?.trim();
    if (normalizedEmail != null && normalizedEmail.isNotEmpty) {
      emailValue = normalizedEmail;
    }
    _focusEmail = false;
    _isAppleEmailLocked = true;
    FocusManager.instance.primaryFocus?.unfocus();
    rebuildUi();
  }

  void _restoreEmailAfterAppleFailure() {
    if (!_isAppleEmailLocked) return;

    final previousEmail = _emailBeforeApple;
    _emailBeforeApple = null;
    _isAppleEmailLocked = false;
    emailValue = previousEmail ?? '';
    rebuildUi();
  }

  // Reset create password screen
  void resetCreatePasswordScreen() {
    _agree = false;
    _length = false;
    _passwordMatch = false;
    _focusPassword = false;
    _focusConfirmPassword = false;
    rebuildUi();
  }

  // Reset registration otp screen
  void resetRegistrationOtpScreen() {
    _focusOtp = false;
    rebuildUi();
  }

  // In-app navigation
  void goTo({required int page, SignUpMethod? type}) {
    _currentPage = page;
    if (type != null) {
      _signUpMethod = type;
    }
    rebuildUi();
  }

  void goBack() {
    if (_currentPage == 1) {
      _currentPage = 0;
      rebuildUi();
    } else if (_currentPage == 2) {
      _currentPage = 0;
      rebuildUi();
    } else if (_currentPage == 3) {
      if (_signUpMethod == SignUpMethod.phone) {
        _currentPage = 1;
      } else {
        _currentPage = 2;
      }

      rebuildUi();
    } else {
      _navigationService.back();
    }
  }

  // Navigation

  void pop() => _navigationService.back();

  Future<void> replaceToLogin() async =>
      await _navigationService.replaceWithLoginView();

  Future<void> navigateToLanguage() async =>
      await _navigationService.navigateToLanguageView();

  Future<void> navigateToPrivacyPolicy() async =>
      await _navigationService.navigateToPrivacyPolicyView();

  Future<void> navigateToTermsAndConditions() async =>
      await _navigationService.navigateToTermsAndConditionsView();

  Future<void> replaceWithStartUp() async =>
      await _navigationService.clearStackAndShow(Routes.startupView);

  // Remote api calls

  // Register
  Future<void> registerWithEmail(SignUpMethod type) async =>
      await runBusyFuture(_register(type), busyObject: StateObjects.register);

  Future<void> _register(SignUpMethod type) async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response =
          await _apiService.registerWithEmail(_userData);

      if (response['status'] == ResponseStatus.success) {
        goTo(page: 3, type: type);
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }

  // Register with google

  Future<void> registerWithGoogle() async => await runBusyFuture(_googleLogin(),
      busyObject: StateObjects.registerWithGoogle);

  Future<void> _googleLogin() async {
    if (await _statusChecker.checkConnection()) {
      await _googleAuthService.googleAuth();

      Map<String, dynamic> data = {
        'id_token': _googleUser?.authentication.idToken ?? '',
      };

      Map<String, dynamic> response = await _apiService.googleAuth(data);

      if (response['status'] == ResponseStatus.success) {
        User user = response['data'] as User;
        Map<String, dynamic> data = {
          'userId': user.userId,
          'accessToken': user.accessToken,
          'refreshToken': user.refreshToken
        };
        await _authenticationService.saveUserCredential(data);
        await _registerDevice();
        clearUserData();
        await replaceWithStartUp();
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }

  // Register with Apple
  Future<void> registerWithApple() async => await runBusyFuture(_appleLogin(),
      busyObject: StateObjects.registerWithApple);

  Future<void> _appleLogin() async {
    var completed = false;

    try {
      if (!await _statusChecker.checkConnection()) return;

      await _appleAuthService.appleAuth();

      final credential = _appleAuthService.appleCredential;
      final identityToken = credential?.identityToken;

      if (identityToken == null || identityToken.isEmpty) {
        _appleErrorNotifier('Apple login failed. Please try again.');
        return;
      }

      _lockAppleEmail(_appleAuthService.emailForDisplay);

      final appleName = [credential?.givenName, credential?.familyName]
          .whereType<String>()
          .map((part) => part.trim())
          .where((part) => part.isNotEmpty)
          .join(' ');

      Map<String, dynamic> data = {
        'id_token': identityToken,
        'email': credential?.email,
        'first_name': credential?.givenName,
        'last_name': credential?.familyName,
      };

      data.removeWhere((_, value) => value == null || value == '');

      Map<String, dynamic> response = await _apiService.appleAuth(data);

      if (response['status'] == ResponseStatus.success) {
        User user = response['data'] as User;
        Map<String, dynamic> data = {
          'userId': user.userId,
          'accessToken': user.accessToken,
          'refreshToken': user.refreshToken
        };
        await _authenticationService.saveUserCredential(
          data,
          onboardingName: appleName,
        );
        clearUserData();
        await replaceWithStartUp();
        completed = true;
        _appleSuccessNotifier(response['message']);
      } else {
        _appleErrorNotifier(response['message']);
      }
    } on SignInWithAppleAuthorizationException catch (error) {
      if (error.code != AuthorizationErrorCode.canceled) {
        _appleErrorNotifier('Apple login failed. Please try again.');
      }
    } catch (_) {
      _appleErrorNotifier('Apple login failed. Please try again.');
    } finally {
      if (!completed) _restoreEmailAfterAppleFailure();
    }
  }

  Future<void> verifyOtp() async =>
      await runBusyFuture(_verifyOtp(), busyObject: StateObjects.verifyOtp);

  Future<void> _verifyOtp() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response = await _apiService.verifyOtp(_userData);
      if (response['status'] == ResponseStatus.success) {
        User user = response['data'] as User;
        Map<String, dynamic> userData = {
          'userId': user.userId,
          'accessToken': user.accessToken,
          'refreshToken': user.refreshToken
        };

        await _authenticationService.saveUserCredential(userData);
        await _registerDevice();
        await replaceWithStartUp();
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }

  // Register device
  Future<void> _registerDevice() async {
    String? token = await _pushNotificationService.getDeviceToken();

    if (token != null) {
      Map<String, dynamic> deviceData = {
        'device_token': token,
        'platform': Platform.isAndroid ? 'android':'ios',
      };
      await _apiService.registerDevice(deviceData);
    }
  }

  // Resend otp
  Future<void> resendOtp() async =>
      await runBusyFuture(_resendOtp(), busyObject: StateObjects.resendOtp);

  Future<void> _resendOtp() async {
    if (await _statusChecker.checkConnection()) {
      resetButton();

      Map<String, dynamic> response = await _apiService.resendOtp(_userData);

      if (response['status'] == ResponseStatus.success) {
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }
}
