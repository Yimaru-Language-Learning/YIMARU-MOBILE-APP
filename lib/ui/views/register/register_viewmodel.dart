import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../../../app/app.locator.dart';
import '../../../models/user.dart';
import '../../../services/google_auth_service.dart';
import '../../../services/localization_service.dart';
import '../../../services/status_checker_service.dart';

class RegisterViewModel extends ReactiveViewModel
    with FormStateHelper
    implements FormViewModel {
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _googleAuthService = locator<GoogleAuthService>();

  final _localizationService = locator<LocalizationService>();

  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_googleAuthService,_localizationService];

  // Google user
  GoogleSignInAccount? get _googleUser => _googleAuthService.googleUser;

  GoogleSignInAccount? get googleUser => _googleUser;

  // Languages
  Map<String, dynamic> get _selectedLanguage => _localizationService.selectedLanguage;

  Map<String, dynamic> get selectedLanguage => _selectedLanguage;


  // Navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  // Email
  bool _focusEmail = false;

  bool get focusEmail => _focusEmail;

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
    print('HERE');
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
        clearUserData();
        await replaceWithStartUp();
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }

  Future<void> verifyOtp() async =>
      await runBusyFuture(_verifyOtp(), busyObject: StateObjects.verifyOtp);

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
