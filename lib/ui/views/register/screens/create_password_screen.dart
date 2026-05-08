import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/register/register_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_form_label.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';
import 'package:yimaru_app/ui/widgets/validator_list_tile.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/large_app_bar.dart';
import '../../../widgets/obscure_password.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../register_view.form.dart';

class CreatePasswordScreen extends ViewModelWidget<RegisterViewModel> {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const CreatePasswordScreen(
      {super.key,
      required this.passwordController,
      required this.confirmPasswordController});

  Future<void> _signUp(RegisterViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'role': 'STUDENT',
      'otp_medium': 'email',
      'password': passwordController.text,
    };
    viewModel.addUserData(data);

    await viewModel.registerWithEmail(SignUpMethod.email);
  }

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(RegisterViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldStack(viewModel),
      );

  Widget _buildScaffoldStack(RegisterViewModel viewModel) => Stack(
        children: [
          _buildScaffold(viewModel),
          _buildRegistrationState(viewModel),
        ],
      );

  Widget _buildScaffold(RegisterViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(RegisterViewModel viewModel) => [
        _buildAppBar(viewModel),
        verticalSpaceMedium,
        _buildExpandedBody(viewModel)
      ];

  Widget _buildAppBar(RegisterViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        onPop: viewModel.goBack,
        showLanguageSelection: true,
      );

  Widget _buildExpandedBody(RegisterViewModel viewModel) =>
      Expanded(child: _buildColumnScroller(viewModel));

  Widget _buildColumnScroller(RegisterViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildBodyWrapper(viewModel),
      );

  Widget _buildBodyWrapper(RegisterViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(RegisterViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(RegisterViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildPasswordLabel('Password'),
        verticalSpaceSmall,
        _buildPasswordFormField(viewModel),
        if (viewModel.hasPasswordValidationMessage && viewModel.focusPassword)
          verticalSpaceTiny,
        if (viewModel.hasPasswordValidationMessage && viewModel.focusPassword)
          _buildPasswordValidationWrapper(viewModel),
        verticalSpaceMedium,
        _buildPasswordLabel('Confirm Password'),
        verticalSpaceSmall,
        _buildConfirmPasswordFormField(viewModel),
        if (viewModel.hasConfirmPasswordValidationMessage &&
            viewModel.focusConfirmPassword)
          verticalSpaceTiny,
        if (viewModel.hasConfirmPasswordValidationMessage &&
            viewModel.focusConfirmPassword)
          _buildConfirmPasswordValidationWrapper(viewModel),
        verticalSpaceMedium,
        _buildLinearProgressIndicator(viewModel),
        verticalSpaceSmall,
        _buildCharLengthValidator(viewModel),
        _buildPasswordMatchValidator(viewModel),
        _buildCheckBox(viewModel),
        verticalSpaceSmall,
        _buildSignUpButton(viewModel),
        verticalSpaceMedium
      ];

  Widget _buildTitle() => const Text(
        'Create Password',
        style: TextStyle(
          fontSize: 25,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildPasswordLabel(String label) => CustomFormLabel(
        label: label,
        style: style14DG400,
      );

  Widget _buildPasswordFormField(RegisterViewModel viewModel) => TextFormField(
        controller: passwordController,
        onTap: viewModel.setPasswordFocus,
        obscureText: viewModel.obscurePassword,
        decoration: inputDecoration(
            hint: 'Password',
            focus: viewModel.focusPassword,
            suffix: _buildObscurePassword(viewModel),
            filled: passwordController.text.isNotEmpty),
        onChanged: (value) => viewModel.validatePassword(
            password: passwordController.text,
            confirmPassword: confirmPasswordController.text),
      );

  Widget _buildObscurePassword(RegisterViewModel viewModel) => ObscurePassword(
        focus: viewModel.focusPassword,
        obscure: viewModel.obscurePassword,
        onTap: viewModel.setObscurePassword,
      );

  Widget _buildPasswordValidationWrapper(RegisterViewModel viewModel) =>
      viewModel.hasPasswordValidationMessage
          ? _buildPasswordValidator(viewModel)
          : Container();

  Widget _buildPasswordValidator(RegisterViewModel viewModel) => Text(
        viewModel.passwordValidationMessage!,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _buildConfirmPasswordFormField(RegisterViewModel viewModel) =>
      TextFormField(
        controller: confirmPasswordController,
        onTap: viewModel.setConfirmPasswordFocus,
        obscureText: viewModel.obscureConfirmPassword,
        onChanged: (value) => viewModel.validatePassword(
            password: passwordController.text,
            confirmPassword: confirmPasswordController.text),
        decoration: inputDecoration(
            hint: 'Confirm Password',
            focus: viewModel.focusConfirmPassword,
            suffix: _buildObscureConfirmPassword(viewModel),
            filled: confirmPasswordController.text.isNotEmpty),
      );

  Widget _buildObscureConfirmPassword(RegisterViewModel viewModel) =>
      ObscurePassword(
        focus: viewModel.focusConfirmPassword,
        obscure: viewModel.obscureConfirmPassword,
        onTap: viewModel.setObscureConfirmPassword,
      );

  Widget _buildConfirmPasswordValidationWrapper(RegisterViewModel viewModel) =>
      viewModel.hasConfirmPasswordValidationMessage
          ? _buildConfirmPasswordValidator(viewModel)
          : Container();

  Widget _buildConfirmPasswordValidator(RegisterViewModel viewModel) => Text(
        viewModel.confirmPasswordValidationMessage!,
        style: style12R700,
      );

  Widget _buildLinearProgressIndicator(RegisterViewModel viewModel) =>
      CustomLinearProgressIndicator(
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
        progress: viewModel.validationProgress(),
      );

  Widget _buildCharLengthValidator(RegisterViewModel viewModel) =>
      ValidatorListTile(
          backgroundColor: viewModel.length ? kcPrimaryColor : kcLightGrey,
          label: '8 characters minimum');

  Widget _buildPasswordMatchValidator(RegisterViewModel viewModel) =>
      ValidatorListTile(
          backgroundColor:
              viewModel.passwordMatch ? kcPrimaryColor : kcLightGrey,
          label: 'password match');

  Widget _buildCheckBox(RegisterViewModel viewMode) => CheckboxListTile(
      value: viewMode.agree,
      activeColor: kcPrimaryColor,
      title: _buildCheckBoxTitle(viewMode),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (value) => viewMode.setAgreement(value ?? false));

  Widget _buildCheckBoxTitle(RegisterViewModel viewMode) => Text.rich(
        TextSpan(
            text: 'By clicking "Sign Up", you agree to our',
            style: style14DG400,
            children: [
              TextSpan(
                  text: ' Terms of Service',
                  style: style14P600,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => viewMode.navigateToTermsAndConditions()),
              TextSpan(text: ' and ', style: style14DG400),
              TextSpan(
                  text: 'Privacy Policy',
                  style: style14P600,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => viewMode.navigateToPrivacyPolicy()),
            ]),
      );

  Widget _buildSignUpButton(RegisterViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Sign Up',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: passwordController.text.isNotEmpty &&
                confirmPasswordController.text.isNotEmpty &&
                viewModel.length &&
                viewModel.passwordMatch &&
                viewModel.agree
            ? () async => await _signUp(viewModel)
            : null,
        backgroundColor: passwordController.text.isNotEmpty &&
                confirmPasswordController.text.isNotEmpty &&
                viewModel.length &&
                viewModel.passwordMatch &&
                viewModel.agree
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
      );

  Widget _buildRegistrationState(RegisterViewModel viewModel) =>
      viewModel.busy(StateObjects.register)
          ? const PageLoadingIndicator()
          : Container();
}
