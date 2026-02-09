import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/forget_password/forget_password_view.form.dart';
import 'package:yimaru_app/ui/views/forget_password/screens/request_reset_code_screen.dart';
import 'package:yimaru_app/ui/views/forget_password/screens/reset_password_screen.dart';

import '../../common/app_colors.dart';
import '../../common/validators/form_validator.dart';
import '../../widgets/large_app_bar.dart';
import '../../widgets/page_loading_indicator.dart';
import 'forget_password_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'email', validator: FormValidator.validateEmail),
  FormTextField(name: 'resetCode', validator: FormValidator.validateForm),
  FormTextField(name: 'password', validator: FormValidator.validateForm),
  FormTextField(name: 'confirmPassword', validator: FormValidator.validateForm)
])
class ForgetPasswordView extends StackedView<ForgetPasswordViewModel>
    with $ForgetPasswordView {
  const ForgetPasswordView({Key? key}) : super(key: key);

  void _initClearData() {
    emailController.clear();
    passwordController.clear();
    resetCodeController.clear();
    confirmPasswordController.clear();
  }

  void _inAppPop(ForgetPasswordViewModel viewModel) {
    _clearDataOnNavigation(viewModel);
    viewModel.goBack();
  }

  void _clearDataOnNavigation(ForgetPasswordViewModel viewModel) {
    if (viewModel.currentPage == 0) {
      emailController.clear();
      viewModel.resetRequestResetCodeScreen();
    } else {
      passwordController.clear();
      resetCodeController.clear();
      confirmPasswordController.clear();
      viewModel.resetResetPasswordScreen();
    }
  }

  void _pop({required bool value, required ForgetPasswordViewModel viewModel}) {
    {
      if (!value) return;
      _clearDataOnNavigation(viewModel);
      WidgetsBinding.instance.addPostFrameCallback((_) => viewModel.goBack());
    }
  }

  @override
  void onViewModelReady(ForgetPasswordViewModel viewModel) {
    _initClearData();
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  ForgetPasswordViewModel viewModelBuilder(BuildContext context) =>
      ForgetPasswordViewModel();

  @override
  Widget builder(
    BuildContext context,
    ForgetPasswordViewModel viewModel,
    Widget? child,
  ) =>
      _buildLoginScreensWrapper(viewModel);

  Widget _buildLoginScreensWrapper(ForgetPasswordViewModel viewModel) =>
      PopScope(
          canPop: true,
          onPopInvokedWithResult: (value, data) =>
              _pop(value: value, viewModel: viewModel),
          child: _buildScaffoldWrapper(viewModel));

  Widget _buildScaffoldWrapper(ForgetPasswordViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldStack(viewModel),
      );

  Widget _buildScaffoldStack(ForgetPasswordViewModel viewModel) =>
      Stack(children: [
        _buildScaffold(viewModel),
        _buildRequestResetCodeState(viewModel),
        _buildResetPasswordState(viewModel)
      ]);

  Widget _buildScaffold(ForgetPasswordViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(ForgetPasswordViewModel viewModel) =>
      [_buildAppBar(viewModel), _buildExpandedBody(viewModel)];

  Widget _buildAppBar(ForgetPasswordViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        showLanguageSelection: true,
        onPop: () => _inAppPop(viewModel),
      );

  Widget _buildExpandedBody(ForgetPasswordViewModel viewModel) =>
      Expanded(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(ForgetPasswordViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(ForgetPasswordViewModel viewModel) =>
      IndexedStack(index: viewModel.currentPage, children: _buildScreens());

  List<Widget> _buildScreens() => [
        _buildRequestCodeScreen(),
        _buildResetPasswordScreen(),
      ];

  Widget _buildRequestCodeScreen() =>
      RequestCodeScreen(emailController: emailController);

  Widget _buildResetPasswordScreen() => ResetPasswordScreen(
      passwordController: passwordController,
      resetCodeController: resetCodeController,
      confirmPasswordController: confirmPasswordController);

  Widget _buildRequestResetCodeState(ForgetPasswordViewModel viewModel) =>
      viewModel.busy(StateObjects.requestResetCode)
          ? const PageLoadingIndicator()
          : Container();

  Widget _buildResetPasswordState(ForgetPasswordViewModel viewModel) =>
      viewModel.busy(StateObjects.resetPassword)
          ? const PageLoadingIndicator()
          : Container();
}
