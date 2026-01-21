import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/register/register_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_form_label.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';
import 'package:yimaru_app/ui/widgets/validator_list_tile.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/obscure_password.dart';
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

    await viewModel.register();
  }

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) =>
      _buildBodyChildren(viewModel);

  Widget _buildBodyChildren(RegisterViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(RegisterViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
        _buildNumberValidator(viewModel),
        _buildSymbolValidator(viewModel),
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
        style: const TextStyle(
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.w700,
        ),
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

  Widget _buildNumberValidator(RegisterViewModel viewModel) =>
      ValidatorListTile(
          backgroundColor: viewModel.number ? kcPrimaryColor : kcLightGrey,
          label: 'a number');

  Widget _buildSymbolValidator(RegisterViewModel viewModel) =>
      ValidatorListTile(
          backgroundColor: viewModel.specialChar ? kcPrimaryColor : kcLightGrey,
          label: 'one symbol minimum');

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
                viewModel.number &&
                viewModel.length &&
                viewModel.specialChar &&
                viewModel.specialChar &&
                viewModel.passwordMatch &&
                viewModel.agree
            ? () async => await _signUp(viewModel)
            : null,
        backgroundColor: passwordController.text.isNotEmpty &&
                confirmPasswordController.text.isNotEmpty &&
                viewModel.number &&
                viewModel.length &&
                viewModel.specialChar &&
                viewModel.specialChar &&
                viewModel.passwordMatch &&
                viewModel.agree
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
      );
}
