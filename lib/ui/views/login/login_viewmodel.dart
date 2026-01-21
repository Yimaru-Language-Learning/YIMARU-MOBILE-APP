import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/user_model.dart';

import '../../../services/api_service.dart';
import '../../../services/authentication_service.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../home/home_view.dart';

class LoginViewModel extends FormViewModel {
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

  // Add user data
  void addUserData(Map<String, dynamic> data) {
    _userData.addAll(data);
  }

  void clearUserData() {
    _userData.clear();
  }

  // Remote api calls
  Future<void> login() async {
    Map<String, dynamic> response =
        await runBusyFuture<Map<String, dynamic>>(_login());

    if (response['status'] == ResponseStatus.success) {
      await replaceWithHome();
    }
  }

  Future<Map<String, dynamic>> _login() async {
    Map<String, dynamic> response = await _apiService.login(_userData);
    if (response['status'] == ResponseStatus.success) {
      UserModel user = response['data'] as UserModel;
      Map<String, dynamic> data = {
        'userId': user.userId,
        'accessToken': user.accessToken,
        'refreshToken': user.refreshToken
      };

      await _authenticationService.saveUserData(data);
      showSuccessToast(response['message']);
    } else {
      showErrorToast(response['message']);
    }

    return response;
  }

  // Navigation
  void goTo(int page) {
    _currentIndex = page;
    rebuildUi();
  }

  void goBack() {
    if (_currentIndex == 1) {
      _currentIndex = 0;
      rebuildUi();
    } else if (_currentIndex == 2) {
      _currentIndex = 1;
      rebuildUi();
    } else {
      _navigationService.back();
    }
  }

  Future<void> navigateToRegister() async =>
      await _navigationService.navigateToRegisterView();

  Future<void> replaceWithHome() async =>
      await _navigationService.clearStackAndShowView(const HomeView());
}
