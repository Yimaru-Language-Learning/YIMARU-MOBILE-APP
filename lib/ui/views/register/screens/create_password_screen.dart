import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/register/register_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_form_label.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';
import 'package:yimaru_app/ui/widgets/validator_list_tile.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/translations/locale_keys.g.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/large_app_bar.dart';
import '../../../widgets/obscure_password.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../../../widgets/referral_code_input.dart';
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
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(RegisterViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildScaffoldStack(viewModel),
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

  List<Widget> _buildScaffoldChildren(RegisterViewModel viewModel) =>
      [_buildAppBar(viewModel), _buildExpandedBody(viewModel)];

  Widget _buildAppBar(RegisterViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        onPop: viewModel.goBack,
        showLanguageSelection: true,
        onLanguage: () async => await viewModel.navigateToLanguage(),
        language: viewModel.selectedLanguage['code'] == 'am'
            ? 'አማ'
            : viewModel.selectedLanguage['code'],
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
        verticalSpaceLarge,
        _buildTitle(),
        verticalSpaceMedium,
        _buildPasswordLabel(LocaleKeys.password.tr()),
        verticalSpaceSmall,
        _buildPasswordFormField(viewModel),
        if (viewModel.hasPasswordValidationMessage && viewModel.focusPassword)
          verticalSpaceTiny,
        if (viewModel.hasPasswordValidationMessage && viewModel.focusPassword)
          _buildPasswordValidationWrapper(viewModel),
        verticalSpaceMedium,
        _buildPasswordLabel(LocaleKeys.confirm_password.tr()),
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
        _buildReferralCodeSection(viewModel),
        verticalSpaceSmall,
        _buildSignUpButton(viewModel),
        verticalSpaceMedium
      ];

  Widget _buildTitle() => Text(
        LocaleKeys.create_password.tr(),
        style: style25DG600,
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
            hint: LocaleKeys.password.tr(),
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
        style: style12R700,
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
            focus: viewModel.focusConfirmPassword,
            hint: LocaleKeys.confirm_password.tr(),
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
        label: LocaleKeys.eight_character_minimum.tr(),
        backgroundColor: viewModel.length ? kcPrimaryColor : kcLightGrey,
      );

  Widget _buildPasswordMatchValidator(RegisterViewModel viewModel) =>
      ValidatorListTile(
        label: LocaleKeys.password_match.tr(),
        backgroundColor: viewModel.passwordMatch ? kcPrimaryColor : kcLightGrey,
      );

  Widget _buildCheckBox(RegisterViewModel viewMode) => CheckboxListTile(
      value: viewMode.agree,
      activeColor: kcPrimaryColor,
      title: _buildCheckBoxTitle(viewMode),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (value) => viewMode.setAgreement(value ?? false));

  Widget _buildCheckBoxTitle(RegisterViewModel viewMode) => Text.rich(
        TextSpan(
            text: LocaleKeys.sign_up_agreement.tr(),
            style: style14DG400,
            children: [
              TextSpan(
                  text: ' ${LocaleKeys.terms_of_services.tr()}',
                  style: style14P600,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => viewMode.navigateToTermsAndConditions()),
              TextSpan(text: ' ${LocaleKeys.and.tr()} ', style: style14DG400),
              TextSpan(
                  style: style14P600,
                  text: LocaleKeys.privacy_policy.tr(),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => viewMode.navigateToPrivacyPolicy()),
            ]),
      );

  Widget _buildSignUpButton(RegisterViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: LocaleKeys.register.tr(),
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
            : kcPrimaryColor.withValues(alpha: 0.1),
      );

  Widget _buildRegistrationState(RegisterViewModel viewModel) =>
      viewModel.busy(StateObjects.register)
          ? const PageLoadingIndicator()
          : Container();

  Widget _buildReferralCodeSection(RegisterViewModel viewModel) =>
      ReferralCodeInputWidget(
        controller: viewModel.referralCodeController,
        isVerifying: viewModel.isVerifyingReferral,
        isValid: viewModel.isReferralValid,
        influencerName: viewModel.verifiedInfluencerName,
        errorMessage: viewModel.referralErrorMessage,
        onCodeChanged: viewModel.onReferralCodeChanged,
        onClear: viewModel.clearReferral,
      );
}
