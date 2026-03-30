import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/ui/views/login/screens/login_otp_screen.dart';
import 'package:yimaru_app/ui/views/login/screens/login_with_email_screen.dart';
import 'package:yimaru_app/ui/views/login/screens/login_with_phone_number_screen.dart';

import '../../common/validators/form_validator.dart';
import 'login_view.form.dart';
import 'login_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'otp', validator: FormValidator.validateForm),
  FormTextField(name: 'email', validator: FormValidator.validateEmailForm),
  FormTextField(name: 'password', validator: FormValidator.validateForm),
  FormTextField(name: 'phoneNumber', validator: FormValidator.validateForm)
])
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  const LoginView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(LoginViewModel viewModel) {
    _clearData();
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  void _clearData() {
    otpController.clear();
    emailController.clear();
    passwordController.clear();
    phoneNumberController.clear();
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) =>
      _buildLoginScreensWrapper(viewModel);

  Widget _buildLoginScreensWrapper(LoginViewModel viewModel) => PopScope(
      canPop: viewModel.currentPage == 0 ? true : false,
      onPopInvokedWithResult: (value, data) => WidgetsBinding.instance
          .addPostFrameCallback((_) => viewModel.goBack()),
      child: _buildBody(viewModel));

  Widget _buildBody(LoginViewModel viewModel) =>
      IndexedStack(index: viewModel.currentPage, children: _buildScreens());

  List<Widget> _buildScreens() => [
        _buildLoginWithEmailScreen(),
        _buildLoginWithPhoneScreen(),
        _buildLoginOtpScreen()
      ];

  Widget _buildLoginWithEmailScreen() => LoginWithEmailScreen(
      emailController: emailController, passwordController: passwordController);

  Widget _buildLoginWithPhoneScreen() =>
      LoginWithPhoneNumberScreen(phoneNumberController: phoneNumberController);

  Widget _buildLoginOtpScreen() => LoginOtpScreen(
      otpController: otpController,
      phoneNumberController: phoneNumberController);
}
