import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
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

  @override
  void onViewModelReady(RegisterViewModel viewModel) {
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
      onPopInvokedWithResult: (value, data) {
        if (value) return;
        WidgetsBinding.instance.addPostFrameCallback((_) => viewModel.goBack());
      },
      child: _buildScaffoldWrapper(viewModel));

  Widget _buildScaffoldWrapper(RegisterViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldStack(viewModel),
      );

  Widget _buildScaffoldStack(RegisterViewModel viewModel) => Stack(
      children: [_buildScaffold(viewModel), _buildBusyRegistration(viewModel)]);

  Widget _buildScaffold(RegisterViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(RegisterViewModel viewModel) =>
      [_buildAppBar(viewModel), _buildExpandedBody(viewModel)];

  Widget _buildAppBar(RegisterViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        onPop: viewModel.goBack,
        showLanguageSelection: true,
      );

  Widget _buildExpandedBody(RegisterViewModel viewModel) =>
      Expanded(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(RegisterViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(RegisterViewModel viewModel) =>
      IndexedStack(index: viewModel.currentIndex, children: _buildScreens());

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

  Widget _buildBusyRegistration(RegisterViewModel viewModel) =>
      viewModel.isBusy ? const PageLoadingIndicator() : Container();
}
