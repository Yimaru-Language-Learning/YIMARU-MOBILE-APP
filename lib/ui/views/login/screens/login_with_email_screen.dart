import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/login/login_view.form.dart';
import 'package:yimaru_app/ui/widgets/obscure_password.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/option_text_divider.dart';
import '../../../widgets/register_for_account.dart';
import '../login_viewmodel.dart';

class LoginWithEmailScreen extends ViewModelWidget<LoginViewModel> {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginWithEmailScreen(
      {super.key,
      required this.emailController,
      required this.passwordController});

  Future<void> _login(LoginViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'email': emailController.text,
      'password': passwordController.text,
    };
    viewModel.addUserData(data);

    await viewModel.emailLogin();
  }

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(LoginViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(LoginViewModel viewModel) =>
      [_buildColumnScroller(viewModel), _buildLowerColumn(viewModel)];

  Widget _buildColumnScroller(LoginViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildUpperColumn(viewModel),
      );

  Widget _buildUpperColumn(LoginViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(LoginViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        _buildSubtitleWrapper(viewModel),
        verticalSpaceLarge,
        _buildEmailFormField(viewModel),
        if (viewModel.hasEmailValidationMessage && viewModel.focusEmail)
          verticalSpaceTiny,
        if (viewModel.hasEmailValidationMessage && viewModel.focusEmail)
          _buildEmailValidatorWrapper(viewModel),
        verticalSpaceMedium,
        _buildPasswordFormField(viewModel),
        if (viewModel.hasPasswordValidationMessage && viewModel.focusPassword)
          verticalSpaceTiny,
        if (viewModel.hasPasswordValidationMessage && viewModel.focusPassword)
          _buildPasswordValidationWrapper(viewModel),
        _buildForgetPasswordTextButtonWrapper(viewModel),
      ];

  Widget _buildTitle() => Text(
        'Welcome Back',
        style: style25DG600,
      );

  Widget _buildSubtitleWrapper(LoginViewModel viewModel) => RegisterForAccount(
        onTap: () async => await viewModel.navigateToRegister(),
      );

  Widget _buildEmailFormField(LoginViewModel viewModel) => TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        onTap: viewModel.setEmailFocus,
        decoration: inputDecoration(
            hint: 'Email',
            focus: viewModel.focusEmail,
            filled: emailController.text.isNotEmpty),
      );

  Widget _buildEmailValidatorWrapper(LoginViewModel viewModel) =>
      viewModel.hasEmailValidationMessage
          ? _buildEmailValidator(viewModel)
          : Container();

  Widget _buildEmailValidator(LoginViewModel viewModel) => Text(
        viewModel.emailValidationMessage!,
        style: style12R700,
      );

  Widget _buildPasswordFormField(LoginViewModel viewModel) => TextFormField(
        controller: passwordController,
        onTap: viewModel.setPasswordFocus,
        obscureText: viewModel.obscurePassword,
        decoration: inputDecoration(
            hint: 'Password',
            focus: viewModel.focusPassword,
            suffix: _buildObscureButton(viewModel),
            filled: passwordController.text.isNotEmpty),
      );

  Widget _buildObscureButton(LoginViewModel viewModel) => ObscurePassword(
        focus: viewModel.focusPassword,
        obscure: viewModel.obscurePassword,
        onTap: viewModel.setObscurePassword,
      );

  Widget _buildPasswordValidationWrapper(LoginViewModel viewModel) =>
      viewModel.hasPasswordValidationMessage
          ? _buildPasswordValidator(viewModel)
          : Container();

  Widget _buildPasswordValidator(LoginViewModel viewModel) => Text(
        viewModel.passwordValidationMessage!,
        style: style12R700,
      );

  Widget _buildForgetPasswordTextButtonWrapper(LoginViewModel viewModel) =>
      Align(
        alignment: Alignment.centerRight,
        child: _buildForgetPasswordTextButton(viewModel),
      );

  Widget _buildForgetPasswordTextButton(LoginViewModel viewModel) => TextButton(
        onPressed: () async => await viewModel.navigateToForgetPassword(),
        child: _buildForgetPasswordText(),
      );

  Widget _buildForgetPasswordText() => Text(
        'Forget Password?',
        style: style14P400,
      );

  Widget _buildLowerColumn(LoginViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildLowerColumnChildren(viewModel),
      );

  List<Widget> _buildLowerColumnChildren(LoginViewModel viewModel) => [
        _buildContinueButton(viewModel),
        _buildLoginWithGoogleButton(viewModel),
        _buildOptionTextDivider(),
        _buildLoginWithPhoneButton(viewModel),
        verticalSpaceMedium
      ];

  Widget _buildContinueButton(LoginViewModel viewModel) => CustomElevatedButton(
        height: 55,
        safe: false,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: emailController.text.isNotEmpty &&
                passwordController.text.isNotEmpty
            ? () async => await _login(viewModel)
            : null,
        backgroundColor: emailController.text.isNotEmpty &&
                passwordController.text.isNotEmpty
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
      );

  Widget _buildLoginWithGoogleButton(LoginViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        backgroundColor: kcWhite,
        text: 'Login with Google',
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        leadingImage: 'assets/icons/google.png',
        onTap: () async => await viewModel.googleLogin(),
      );

  Widget _buildOptionTextDivider() => const OptionTextDivider();

  Widget _buildLoginWithPhoneButton(LoginViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        backgroundColor: kcWhite,
        leadingIcon: Icons.phone,
        borderColor: kcPrimaryColor,
        onTap: () => viewModel.goTo(1),
        foregroundColor: kcPrimaryColor,
        text: 'Login with Phone Number',
      );
}
