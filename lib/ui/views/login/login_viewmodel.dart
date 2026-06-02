import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/user.dart';

import '../../../services/api_service.dart';
import '../../../services/apple_auth_service.dart';
import '../../../services/authentication_service.dart';
import '../../../services/google_auth_service.dart';
import '../../../services/localization_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';

class LoginViewModel extends ReactiveViewModel
    with FormStateHelper
    implements FormViewModel {
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _googleAuthService = locator<GoogleAuthService>();

  final _appleAuthService = locator<AppleAuthService>();

  final _localizationService = locator<LocalizationService>();

  final _authenticationService = locator<AuthenticationService>();

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

  // In-app navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  // Email
  bool _focusEmail = false;

  bool get focusEmail => _focusEmail;

  // Password
  bool _focusPassword = false;

  bool get focusPassword => _focusPassword;

  bool _obscurePassword = true;

  bool get obscurePassword => _obscurePassword;

  // Phone number
  bool _focusPhoneNumber = false;

  bool get focusPhoneNumber => _focusPhoneNumber;

  // Focus otp
  bool _focusOtp = false;

  bool get focusOtp => _focusOtp;

  // Focus node
  final FocusNode _focusNode = FocusNode();

  FocusNode get focusNode => _focusNode;

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

  void setObscurePassword() {
    _obscurePassword = !_obscurePassword;
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

  // Validate otp
  Future<void> validateOtp(String otp) async {}

  void setResendButton() {
    _buttonActive = true;
    rebuildUi();
  }

  void resetButton() {
    _buttonActive = false;

    _resendTime = DateTime.now().add(const Duration(minutes: 3, seconds: 0));
  }

  // User data
  void clearUserData() {
    _userData.clear();
  }

  void addUserData(Map<String, dynamic> data) {
    _userData.addAll(data);
  }

  // In app navigation
  void goBack() {
    if (_currentPage == 1) {
      _currentPage = 0;
      rebuildUi();
    } else if (_currentPage == 2) {
      _currentPage = 1;
      rebuildUi();
    } else {
      _navigationService.back();
    }
  }

  void goTo(int page) {
    _currentPage = page;
    rebuildUi();
  }

  // Navigation

  Future<void> navigateToRegister() async =>
      await _navigationService.navigateToRegisterView();

  Future<void> navigateToLanguage() async =>
      await _navigationService.navigateToLanguageView();

  Future<void> navigateToForgetPassword() async =>
      await _navigationService.navigateToForgetPasswordView();

  Future<void> replaceWithStartUp() async =>
      await _navigationService.clearStackAndShow(Routes.startupView);

  // Remote api calls

  // Login with email
  Future<void> loginWithEmail() async => await runBusyFuture(_loginWithEmail(),
      busyObject: StateObjects.loginWithEmail);

  Future<void> _loginWithEmail() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response = await _apiService.login(_userData);
      if (response['status'] == ResponseStatus.success) {
        User user = response['data'] as User;
        Map<String, dynamic> data = {
          'userId': user.userId,
          'accessToken': user.accessToken,
          'refreshToken': user.refreshToken
        };

        await _authenticationService.saveUserCredential(data);
        clearUserData();
        await replaceWithStartUp();
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }

  // Sign-in with google
  Future<void> _googleAuth() async {
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
        clearUserData();
        await replaceWithStartUp();
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }

  Future<void> signInWithGoogle() async => await runBusyFuture(_googleAuth(),
      busyObject: StateObjects.loginWithGoogle);

  // Sign-in with Apple
  Future<void> _appleAuth() async {
    if (await _statusChecker.checkConnection()) {
      await _appleAuthService.appleAuth();

      final credential = _appleAuthService.appleCredential;
      final identityToken = credential?.identityToken;

      if (identityToken == null || identityToken.isEmpty) {
        showErrorToast('Apple login failed. Please try again.');
        return;
      }

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
        await _authenticationService.saveUserCredential(data);
        clearUserData();
        await replaceWithStartUp();
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }

  Future<void> signInWithApple() async => await runBusyFuture(_appleAuth(),
      busyObject: StateObjects.loginWithApple);

  // Login with phone
  Future<void> loginWithPhoneNumber() async =>
      await runBusyFuture(_loginWithPhoneNumber(),
          busyObject: StateObjects.loginWithPhoneNumber);

  Future<void> _loginWithPhoneNumber() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response = await _apiService.resendOtp(_userData);
      if (response['status'] == ResponseStatus.success) {
        goTo(2);
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }

  // Verify otp
  Future<void> _verifyOtp() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response = await _apiService.verifyOtp(_userData);
      if (response['status'] == ResponseStatus.success) {
        User user = response['data'] as User;
        Map<String, dynamic> data = {
          'userId': user.userId,
          'accessToken': user.accessToken,
          'refreshToken': user.refreshToken
        };

        await _authenticationService.saveUserCredential(data);
        await replaceWithStartUp();
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }

  Future<void> verifyOtp() async =>
      await runBusyFuture(_verifyOtp(), busyObject: StateObjects.verifyOtp);

  // Resend otp
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

  Future<void> resendOtp() async =>
      await runBusyFuture(_resendOtp(), busyObject: StateObjects.resendOtp);
}
