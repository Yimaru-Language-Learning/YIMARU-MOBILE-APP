import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/login/login_view.form.dart';
import 'package:yimaru_app/ui/widgets/obscure_password.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/large_app_bar.dart';
import '../../../widgets/option_text_divider.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../../../widgets/register_for_account.dart';
import '../login_viewmodel.dart';

class LoginWithEmailScreen extends ViewModelWidget<LoginViewModel> {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginWithEmailScreen(
      {super.key,
      required this.emailController,
      required this.passwordController});


  Widget getPadding(context){
    double half = screenHeight(context)/2;
    return SizedBox(height: half + 25  - half,);
  }

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
      _buildScaffoldWrapper(context: context,viewModel: viewModel);

  Widget _buildScaffoldWrapper({required BuildContext context,required LoginViewModel viewModel}) => Scaffold(
    backgroundColor: kcBackgroundColor,
    body: _buildScaffoldStack(context: context,viewModel: viewModel),
  );

 Widget _buildScaffoldStack({required BuildContext context,required LoginViewModel viewModel}) => Stack(children: [
   _buildScaffold(context: context,viewModel: viewModel),
  _buildLoginWithEmailState(viewModel),
  _buildLoginWithGoogleState(viewModel)
  ]);

  Widget _buildScaffold({required BuildContext context,required LoginViewModel viewModel}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: _buildScaffoldChildren(context: context,viewModel: viewModel),
  );

  List<Widget> _buildScaffoldChildren({required BuildContext context,required LoginViewModel viewModel}) =>
      [_buildAppBar(viewModel), _buildExpandedBody(context: context,viewModel: viewModel)];

  Widget _buildAppBar(LoginViewModel viewModel) => const LargeAppBar(
    showBackButton: false,
    showLanguageSelection: true,
  );

  Widget _buildExpandedBody({required BuildContext context,required LoginViewModel viewModel}) =>
      Expanded(child: _buildColumnScroller(context: context,viewModel: viewModel));

  Widget _buildColumnScroller({required BuildContext context,required LoginViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildBodyWrapper(context: context,viewModel: viewModel),
      );

  Widget _buildBodyWrapper({required BuildContext context,required LoginViewModel viewModel}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: _buildBody(context: context,viewModel: viewModel),
  );

  Widget _buildBody({required BuildContext context,required LoginViewModel viewModel}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
    children: _buildBodyChildren(context: context,viewModel: viewModel),
      );




  List<Widget> _buildBodyChildren({required BuildContext context,required LoginViewModel viewModel}) =>
      [_buildUpperColumn(viewModel),getPadding(context), _buildLowerColumn(viewModel)];



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
        onTap: () async => await viewModel.signInWithGoogle(),
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


  Widget _buildLoginWithEmailState(LoginViewModel viewModel) =>
      viewModel.busy(StateObjects.loginWithEmail)
          ? const PageLoadingIndicator()
          : Container();

  Widget _buildLoginWithGoogleState(LoginViewModel viewModel) =>
      viewModel.busy(StateObjects.loginWithGoogle)
          ? const PageLoadingIndicator()
          : Container();
}
