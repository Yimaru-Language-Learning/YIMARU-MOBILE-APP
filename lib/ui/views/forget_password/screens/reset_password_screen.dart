import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/translations/locale_keys.g.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_form_label.dart';
import '../../../widgets/custom_linear_progress_indicator.dart';
import '../../../widgets/large_app_bar.dart';
import '../../../widgets/obscure_password.dart';
import '../../../widgets/page_loading_indicator.dart';
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

  void _inAppPop(ForgetPasswordViewModel viewModel) {
    _clearDataOnNavigation(viewModel);
    viewModel.goBack();
  }

  void _clearDataOnNavigation(ForgetPasswordViewModel viewModel) {
    passwordController.clear();
    resetCodeController.clear();
    confirmPasswordController.clear();
    viewModel.resetResetPasswordScreen();
  }

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
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required ForgetPasswordViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldContainer(
          {required BuildContext context,
          required ForgetPasswordViewModel viewModel}) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffoldStack(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldStack(
          {required BuildContext context,
          required ForgetPasswordViewModel viewModel}) =>
      Stack(
        children: [
          _buildScaffold(viewModel),
          _buildResetPasswordState(viewModel),
        ],
      );

  Widget _buildScaffold(ForgetPasswordViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(ForgetPasswordViewModel viewModel) => [
        _buildAppBar(viewModel),
        verticalSpaceMedium,
        _buildExpandedBody(viewModel)
      ];

  Widget _buildAppBar(ForgetPasswordViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        showLanguageSelection: true,
        onPop: () => _inAppPop(viewModel),
        language: viewModel.selectedLanguage['code'],
        onLanguage: () async => await viewModel.navigateToLanguage(),
      );

  Widget _buildExpandedBody(ForgetPasswordViewModel viewModel) =>
      Expanded(child: _buildColumnScroller(viewModel));

  Widget _buildColumnScroller(ForgetPasswordViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildBodyWrapper(viewModel),
      );

  Widget _buildBodyWrapper(ForgetPasswordViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(ForgetPasswordViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(ForgetPasswordViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildFormLabel(LocaleKeys.reset_code.tr()),
        verticalSpaceSmall,
        _buildResetCodeFormField(viewModel),
        if (viewModel.hasResetCodeValidationMessage && viewModel.focusResetCode)
          verticalSpaceTiny,
        if (viewModel.hasResetCodeValidationMessage && viewModel.focusResetCode)
          _buildResetCodeValidationWrapper(viewModel),
        verticalSpaceMedium,
        _buildFormLabel(LocaleKeys.new_password.tr()),
        verticalSpaceSmall,
        _buildPasswordFormField(viewModel),
        if (viewModel.hasPasswordValidationMessage && viewModel.focusPassword)
          verticalSpaceTiny,
        if (viewModel.hasPasswordValidationMessage && viewModel.focusPassword)
          _buildPasswordValidationWrapper(viewModel),
        verticalSpaceMedium,
        _buildFormLabel(LocaleKeys.confirm_password.tr()),
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
        verticalSpaceSmall,
        _buildSignUpButton(viewModel),
        verticalSpaceMedium
      ];

  Widget _buildTitle() => Text(
        LocaleKeys.reset_password.tr(),
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
            hint: LocaleKeys.reset_code.tr(),
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
            hint: LocaleKeys.password.tr(),
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
            hint: LocaleKeys.confirm_password.tr(),
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
        label: LocaleKeys.eight_character_minimum.tr(),
        backgroundColor: viewModel.length ? kcPrimaryColor : kcLightGrey,
      );

  Widget _buildPasswordMatchValidator(ForgetPasswordViewModel viewModel) =>
      ValidatorListTile(
        label: LocaleKeys.password_match.tr(),
        backgroundColor: viewModel.passwordMatch ? kcPrimaryColor : kcLightGrey,
      );

  Widget _buildSignUpButton(ForgetPasswordViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: LocaleKeys.cont.tr(),
        onTap: passwordController.text.isNotEmpty &&
                confirmPasswordController.text.isNotEmpty &&
                resetCodeController.text.isNotEmpty &&
                viewModel.length &&
                viewModel.passwordMatch
            ? () async => await _reset(viewModel)
            : null,
        backgroundColor: passwordController.text.isNotEmpty &&
                confirmPasswordController.text.isNotEmpty &&
                resetCodeController.text.isNotEmpty &&
                viewModel.length &&
                viewModel.passwordMatch
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
      );

  Widget _buildResetPasswordState(ForgetPasswordViewModel viewModel) =>
      viewModel.busy(StateObjects.resetPassword)
          ? const PageLoadingIndicator()
          : Container();
}
