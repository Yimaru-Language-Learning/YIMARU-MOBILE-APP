import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/api_service.dart';
import '../../../services/localization_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';

class ForgetPasswordViewModel extends ReactiveViewModel
    with FormStateHelper
    implements FormViewModel {
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _localizationService = locator<LocalizationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_localizationService];

  // Languages
  Map<String, dynamic> get _selectedLanguage =>
      _localizationService.selectedLanguage;

  Map<String, dynamic> get selectedLanguage => _selectedLanguage;

  // User data
  final Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData => _userData;

  // In-app navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  // Email
  bool _focusEmail = false;

  bool get focusEmail => _focusEmail;

  // Reset code
  bool _focusResetCode = false;

  bool get focusResetCode => _focusResetCode;

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

  // Email
  void setEmailFocus() {
    _focusEmail = true;
    rebuildUi();
  }

  // Reset code
  void setResetCodeFocus() {
    _focusResetCode = true;
    rebuildUi();
  }

  // User data
  void clearUserData() {
    _userData.clear();
  }

  void addUserData(Map<String, dynamic> data) {
    _userData.addAll(data);
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

  double validationProgress() {
    int completed = 0;

    if (_length) completed++;
    if (_passwordMatch) completed++;

    return completed / 2; // returns 0.0 → 1.0
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

  // Confirm password
  void setConfirmPasswordFocus() {
    _focusConfirmPassword = true;
    rebuildUi();
  }

  void setObscureConfirmPassword() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    rebuildUi();
  }

  // Form reset

  // Reset reset password screen
  void resetResetPasswordScreen() {
    _length = false;
    _passwordMatch = false;
    _focusPassword = false;
    _focusResetCode = false;
    _focusConfirmPassword = false;
    rebuildUi();
  }

  // Reset reset password screen
  void resetRequestResetCodeScreen() {
    _focusEmail = false;
    rebuildUi();
  }

  // In-app navigation
  void goBack() {
    if (_currentPage == 1) {
      _currentPage = 0;
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
  void pop() => _navigationService.back();

  Future<void> navigateToLanguage() async =>
      await _navigationService.navigateToLanguageView();

  Future<void> replaceWithLogin() async =>
      await _navigationService.clearStackAndShow(Routes.loginView);

  // Remote api calls

  // Request reset code
  Future<void> resetPassword() async => await runBusyFuture(_resetPassword(),
      busyObject: StateObjects.resetPassword);

  Future<void> _resetPassword() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response =
          await _apiService.resetPassword(_userData);
      if (response['status'] == ResponseStatus.success) {
        showSuccessToast(response['message']);
        await replaceWithLogin();
      } else {
        showErrorToast(response['message']);
      }
    }
  }

  // Request reset code
  Future<void> requestResetCode() async =>
      await runBusyFuture(_requestResetCode(),
          busyObject: StateObjects.requestResetCode);

  Future<void> _requestResetCode() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response =
          await _apiService.requestResetCode(_userData);
      if (response['status'] == ResponseStatus.success) {
        goTo(1);
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }
}
