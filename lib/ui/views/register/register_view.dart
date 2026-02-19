import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/register/screens/create_password_screen.dart';
import 'package:yimaru_app/ui/views/register/screens/register_with_email_screen.dart';
import 'package:yimaru_app/ui/views/register/screens/register_with_phone_number_screen.dart';
import 'package:yimaru_app/ui/views/register/screens/registration_otp_screen.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';

import '../../common/app_colors.dart';
import '../../common/validators/form_validator.dart';
import 'register_viewmodel.dart';

import 'register_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'otp', validator: FormValidator.validateForm),
  FormTextField(name: 'email', validator: FormValidator.validateEmail),
  FormTextField(name: 'password', validator: FormValidator.validateForm),
  FormTextField(name: 'phoneNumber', validator: FormValidator.validateForm),
  FormTextField(name: 'confirmPassword', validator: FormValidator.validateForm),
])
class RegisterView extends StackedView<RegisterViewModel> with $RegisterView {
  const RegisterView({Key? key}) : super(key: key);

  void _initClearData() {
    otpController.clear();
    emailController.clear();
    passwordController.clear();
    phoneNumberController.clear();
    confirmPasswordController.clear();
  }

  void _inAppPop(RegisterViewModel viewModel) {
    print('OnPop');
    print(viewModel.currentPage);
    _clearDataOnNavigation(viewModel);
    viewModel.goBack();
  }

  void _clearDataOnNavigation(RegisterViewModel viewModel) {
    if (viewModel.currentPage == 0) {
      emailController.clear();
      viewModel.resetRegisterWithEmailScreen();
    } else if (viewModel.currentPage == 2) {
      passwordController.clear();
      confirmPasswordController.clear();
      viewModel.resetCreatePasswordScreen();
    } else if (viewModel.currentPage == 3) {
      otpController.clear();
      viewModel.resetRegistrationOtpScreen();
    }
  }

  void _pop({required bool value, required RegisterViewModel viewModel}) {
    {
      if (!value) return;
      _clearDataOnNavigation(viewModel);
      WidgetsBinding.instance.addPostFrameCallback((_) => viewModel.goBack());
    }
  }

  @override
  void onViewModelReady(RegisterViewModel viewModel) {
    _initClearData();
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  RegisterViewModel viewModelBuilder(BuildContext context) =>
      RegisterViewModel();

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
    Widget? child,
  ) =>
      _buildRegisterScreensWrapper(viewModel);

  Widget _buildRegisterScreensWrapper(RegisterViewModel viewModel) => PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, data) =>
          _pop(value: value, viewModel: viewModel),
      child: _buildBody(viewModel));

  Widget _buildBody(RegisterViewModel viewModel) =>
      IndexedStack(index: viewModel.currentPage, children: _buildScreens());

  List<Widget> _buildScreens() => [
        _buildRegisterWithEmailScreen(),
        _buildRegisterWithPhoneScreen(),
        _buildCreatePasswordScreen(),
        _buildRegistrationOtpScreen(),
      ];

  Widget _buildRegisterWithEmailScreen() =>
      RegisterWithEmailScreen(emailController: emailController);

  Widget _buildRegisterWithPhoneScreen() => RegisterWithPhoneNumberScreen(
      phoneNumberController: phoneNumberController);

  Widget _buildRegistrationOtpScreen() => RegistrationOtpScreen(
        otpController: otpController,
        emailController: emailController,
        phoneNumberController: phoneNumberController,
      );

  Widget _buildCreatePasswordScreen() => CreatePasswordScreen(
      passwordController: passwordController,
      confirmPasswordController: confirmPasswordController);
}
