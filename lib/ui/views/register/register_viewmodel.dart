import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/home/home_view.dart';

import '../../../app/app.locator.dart';
import '../../../models/user_model.dart';

class RegisterViewModel extends FormViewModel {
  final _apiService = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  // Navigation
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  // Email
  bool _focusEmail = false;

  bool get focusEmail => _focusEmail;

  // Password
  bool _length = false;

  bool get length => _length;

  bool _number = false;

  bool get number => _number;

  bool _specialChar = false;

  bool get specialChar => _specialChar;

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
  RegistrationType? _registrationType;

  RegistrationType? get registrationType => _registrationType;

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

    if (RegExp(r'\d').hasMatch(password)) {
      _number = true;
    } else {
      _number = false;
    }

    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      _specialChar = true;
    } else {
      _specialChar = false;
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
    if (_number) completed++;
    if (_specialChar) completed++;
    if (_passwordMatch) completed++;

    return completed / 4; // returns 0.0 → 1.0
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

  // Remote api calls
  Future<void> register() async {
    Map<String, dynamic> response = await runBusyFuture<Map<String, dynamic>>(
        _apiService.register(_userData));

    if (response['status'] == ResponseStatus.success) {
      goTo(page: 3);
      showSuccessToast(response['message']);
    } else {
      showErrorToast(response['message']);
    }
  }

  Future<void> verifyOtp() async {
    Map<String, dynamic> response =
        await runBusyFuture<Map<String, dynamic>>(_verifyOtp());

    if (response['status'] == ResponseStatus.success) {
      await replaceWithHome();
    }
  }

  Future<Map<String, dynamic>> _verifyOtp() async {
    Map<String, dynamic> response = await _apiService.verifyOtp(_userData);
    if (response['status'] == ResponseStatus.success) {
      UserModel user = response['data'] as UserModel;
      Map<String, dynamic> data = {
        'userId': user.userId,
        'accessToken': user.accessToken,
        'refreshToken': user.refreshToken
      };

      //     {
      //       'userId': 10,
      //   'accessToken': 'accessToken',
      //   'refreshToken': 'refreshToken'
      // }

      await _authenticationService.saveBasicUserData(data);
      showSuccessToast(response['message']);
    } else {
      showErrorToast(response['message']);
    }

    return response;
  }

  Future<void> resendOtp() async {
    resetButton();

    Map<String, dynamic> response = await runBusyFuture<Map<String, dynamic>>(
        _apiService.resendOtp(_userData));

    if (response['status'] == ResponseStatus.success) {
      showSuccessToast(response['message']);
    } else {
      showErrorToast(response['message']);
    }
  }

  // Navigation
  void goTo({required int page, RegistrationType? type}) {
    _currentIndex = page;
    if (type != null) {
      _registrationType = type;
    }
    rebuildUi();
  }

  void goBack() {
    if (_currentIndex == 1) {
      _currentIndex = 0;
      rebuildUi();
    } else if (_currentIndex == 2) {
      _currentIndex = 0;
      rebuildUi();
    } else if (_currentIndex == 3) {
      if (_registrationType == RegistrationType.phone) {
        _currentIndex = 1;
      } else {
        _currentIndex = 2;
      }

      rebuildUi();
    } else {
      _navigationService.back();
    }
  }

  Future<void> navigateToTermsAndConditions() async =>
      await _navigationService.navigateToTermsAndConditionsView();

  Future<void> navigateToPrivacyPolicy() async =>
      await _navigationService.navigateToPrivacyPolicyView();

  Future<void> replaceToLogin() async =>
      await _navigationService.replaceWithLoginView();

  Future<void> replaceWithHome() async =>
      await _navigationService.clearStackAndShowView(const HomeView());
}
