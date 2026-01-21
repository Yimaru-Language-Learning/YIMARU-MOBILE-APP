import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/ui/views/login/screens/login_otp_screen.dart';
import 'package:yimaru_app/ui/views/login/screens/login_with_email_screen.dart';
import 'package:yimaru_app/ui/views/login/screens/login_with_phone_number_screen.dart';

import '../../common/app_colors.dart';
import '../../common/validators/form_validator.dart';
import '../../widgets/large_app_bar.dart';
import '../../widgets/page_loading_indicator.dart';
import 'login_viewmodel.dart';

import 'login_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'otp', validator: FormValidator.validateForm),
  FormTextField(name: 'email', validator: FormValidator.validateEmail),
  FormTextField(name: 'password', validator: FormValidator.validateForm),
  FormTextField(name: 'phoneNumber', validator: FormValidator.validateForm)
])
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  const LoginView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(LoginViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
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
      canPop: true,
      onPopInvokedWithResult: (value, data) {
        if (!value) return;
        WidgetsBinding.instance.addPostFrameCallback((_) => viewModel.goBack());
      },
      child: _buildScaffoldWrapper(viewModel));

  Widget _buildScaffoldWrapper(LoginViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldStack(viewModel),
      );

  Widget _buildScaffoldStack(LoginViewModel viewModel) =>
      Stack(children: [_buildScaffold(viewModel), _buildBusyLogin(viewModel)]);

  Widget _buildScaffold(LoginViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(LoginViewModel viewModel) =>
      [_buildAppBar(viewModel), _buildExpandedBody(viewModel)];

  Widget _buildAppBar(LoginViewModel viewModel) => const LargeAppBar(
        showBackButton: false,
        showLanguageSelection: true,
      );
  Widget _buildExpandedBody(LoginViewModel viewModel) =>
      Expanded(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(LoginViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(LoginViewModel viewModel) =>
      IndexedStack(index: viewModel.currentIndex, children: _buildScreens());

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

  Widget _buildBusyLogin(LoginViewModel viewModel) =>
      viewModel.isBusy ? const PageLoadingIndicator() : Container();
}
