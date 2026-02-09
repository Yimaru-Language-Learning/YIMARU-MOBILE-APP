import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_form_label.dart';
import '../../../widgets/custom_linear_progress_indicator.dart';
import '../../../widgets/obscure_password.dart';
import '../../../widgets/validator_list_tile.dart';
import '../forget_password_viewmodel.dart';
import '../forget_password_view.form.dart';

class ResetPasswordScreen extends ViewModelWidget<ForgetPasswordViewModel> {
  final TextEditingController resetCodeController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const ResetPasswordScreen(
      {super.key,
      required this.resetCodeController,
      required this.passwordController,
      required this.confirmPasswordController});

  Future<void> _reset(ForgetPasswordViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'otp': resetCodeController.text,
      'password': passwordController.text,
    };
    viewModel.addUserData(data);

    await viewModel.resetPassword();
  }

  @override
  Widget build(BuildContext context, ForgetPasswordViewModel viewModel) =>
      _buildBodyChildren(viewModel);

  Widget _buildBodyChildren(ForgetPasswordViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(ForgetPasswordViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(ForgetPasswordViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildFormLabel('Reset code'),
        verticalSpaceSmall,
        _buildResetCodeFormField(viewModel),
        if (viewModel.hasResetCodeValidationMessage && viewModel.focusResetCode)
          verticalSpaceTiny,
        if (viewModel.hasResetCodeValidationMessage && viewModel.focusResetCode)
          _buildResetCodeValidationWrapper(viewModel),
        verticalSpaceMedium,
        _buildFormLabel('New Password'),
        verticalSpaceSmall,
        _buildPasswordFormField(viewModel),
        if (viewModel.hasPasswordValidationMessage && viewModel.focusPassword)
          verticalSpaceTiny,
        if (viewModel.hasPasswordValidationMessage && viewModel.focusPassword)
          _buildPasswordValidationWrapper(viewModel),
        verticalSpaceMedium,
        _buildFormLabel('Confirm Password'),
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
        verticalSpaceSmall,
        _buildSignUpButton(viewModel),
        verticalSpaceMedium
      ];

  Widget _buildTitle() => Text(
        'Reset password',
        style: style25DG600,
      );

  Widget _buildFormLabel(String label) => CustomFormLabel(
        label: label,
        style: style14DG400,
      );

  Widget _buildResetCodeFormField(ForgetPasswordViewModel viewModel) =>
      TextFormField(
        controller: resetCodeController,
        onTap: viewModel.setResetCodeFocus,
        decoration: inputDecoration(
            hint: 'Reset code',
            focus: viewModel.focusResetCode,
            filled: passwordController.text.isNotEmpty),
      );

  Widget _buildResetCodeValidationWrapper(ForgetPasswordViewModel viewModel) =>
      viewModel.hasResetCodeValidationMessage
          ? _buildResetCodeValidator(viewModel)
          : Container();

  Widget _buildResetCodeValidator(ForgetPasswordViewModel viewModel) => Text(
        viewModel.resetCodeValidationMessage!,
        style: style12R700,
      );

  Widget _buildPasswordFormField(ForgetPasswordViewModel viewModel) =>
      TextFormField(
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

  Widget _buildObscurePassword(ForgetPasswordViewModel viewModel) =>
      ObscurePassword(
        focus: viewModel.focusPassword,
        obscure: viewModel.obscurePassword,
        onTap: viewModel.setObscurePassword,
      );

  Widget _buildPasswordValidationWrapper(ForgetPasswordViewModel viewModel) =>
      viewModel.hasPasswordValidationMessage
          ? _buildPasswordValidator(viewModel)
          : Container();

  Widget _buildPasswordValidator(ForgetPasswordViewModel viewModel) => Text(
        viewModel.passwordValidationMessage!,
        style: style12R700,
      );

  Widget _buildConfirmPasswordFormField(ForgetPasswordViewModel viewModel) =>
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

  Widget _buildObscureConfirmPassword(ForgetPasswordViewModel viewModel) =>
      ObscurePassword(
        focus: viewModel.focusConfirmPassword,
        obscure: viewModel.obscureConfirmPassword,
        onTap: viewModel.setObscureConfirmPassword,
      );

  Widget _buildConfirmPasswordValidationWrapper(
          ForgetPasswordViewModel viewModel) =>
      viewModel.hasConfirmPasswordValidationMessage
          ? _buildConfirmPasswordValidator(viewModel)
          : Container();

  Widget _buildConfirmPasswordValidator(ForgetPasswordViewModel viewModel) =>
      Text(
        viewModel.confirmPasswordValidationMessage!,
        style: style12R700,
      );

  Widget _buildLinearProgressIndicator(ForgetPasswordViewModel viewModel) =>
      CustomLinearProgressIndicator(
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
        progress: viewModel.validationProgress(),
      );

  Widget _buildCharLengthValidator(ForgetPasswordViewModel viewModel) =>
      ValidatorListTile(
          backgroundColor: viewModel.length ? kcPrimaryColor : kcLightGrey,
          label: '8 characters minimum');

  Widget _buildNumberValidator(ForgetPasswordViewModel viewModel) =>
      ValidatorListTile(
          backgroundColor: viewModel.number ? kcPrimaryColor : kcLightGrey,
          label: 'a number');

  Widget _buildSymbolValidator(ForgetPasswordViewModel viewModel) =>
      ValidatorListTile(
          backgroundColor: viewModel.specialChar ? kcPrimaryColor : kcLightGrey,
          label: 'one symbol minimum');

  Widget _buildPasswordMatchValidator(ForgetPasswordViewModel viewModel) =>
      ValidatorListTile(
          backgroundColor:
              viewModel.passwordMatch ? kcPrimaryColor : kcLightGrey,
          label: 'password match');

  Widget _buildSignUpButton(ForgetPasswordViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: passwordController.text.isNotEmpty &&
                confirmPasswordController.text.isNotEmpty &&
                resetCodeController.text.isNotEmpty &&
                viewModel.number &&
                viewModel.length &&
                viewModel.specialChar &&
                viewModel.specialChar &&
                viewModel.passwordMatch
            ? () async => await _reset(viewModel)
            : null,
        backgroundColor: passwordController.text.isNotEmpty &&
                confirmPasswordController.text.isNotEmpty &&
                resetCodeController.text.isNotEmpty &&
                viewModel.number &&
                viewModel.length &&
                viewModel.specialChar &&
                viewModel.specialChar &&
                viewModel.passwordMatch
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
      );
}
