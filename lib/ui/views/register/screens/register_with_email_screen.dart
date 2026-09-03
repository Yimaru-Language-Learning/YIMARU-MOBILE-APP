import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/widgets/login_account.dart';

import '../../../common/app_colors.dart';
import '../../../common/translations/locale_keys.g.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/large_app_bar.dart';
import '../../../widgets/option_text_divider.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../register_view.form.dart';
import '../register_viewmodel.dart';

class RegisterWithEmailScreen extends ViewModelWidget<RegisterViewModel> {
  final TextEditingController emailController;

  const RegisterWithEmailScreen({
    super.key,
    required this.emailController,
  });

  void _addUserData(RegisterViewModel viewModel) {
    FocusManager.instance.primaryFocus?.unfocus();
    Map<String, dynamic> data = {
      'email': emailController.text,
    };
    viewModel.clearUserData();
    viewModel.addUserData(data);
    viewModel.goTo(page: 2, type: SignUpMethod.email);
  }

  Widget getPadding(context) {
    double half = screenHeight(context) / 2;
    return SizedBox(
      height: half + 155 - half,
    );
  }

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      Scaffold(
        
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldContainer(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffoldStack(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldStack(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      Stack(
        children: [
          _buildScaffold(context: context, viewModel: viewModel),
          _buildRegisterWithEmailState(viewModel),
          _buildRegisterWithGoogleState(viewModel),
          _buildRegisterWithAppleState(viewModel)
        ],
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            _buildScaffoldChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildScaffoldChildren(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      [
        _buildAppBar(viewModel),
        _buildExpandedBody(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBar(RegisterViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        onPop: viewModel.goBack,
        showLanguageSelection: true,
        onLanguage: () async => await viewModel.navigateToLanguage(),
        language: viewModel.selectedLanguage['code'] == 'am'
            ? 'አማ'
            : viewModel.selectedLanguage['code'],
      );

  Widget _buildExpandedBody(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      Expanded(
          child: _buildColumnScroller(context: context, viewModel: viewModel));

  Widget _buildColumnScroller(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildBodyWrapper(context: context, viewModel: viewModel),
      );

  Widget _buildBodyWrapper(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(context: context, viewModel: viewModel),
      );

  Widget _buildBody(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyChildren(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildUpperColumn(viewModel),
        getPadding(context),
        _buildLowerColumn(viewModel)
      ];

  Widget _buildUpperColumn(RegisterViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(RegisterViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        _buildSubtitleWrapper(viewModel),
        verticalSpaceLarge,
        _buildEmailFormField(viewModel),
        if (viewModel.hasEmailValidationMessage && viewModel.focusEmail)
          verticalSpaceTiny,
        if (viewModel.hasEmailValidationMessage && viewModel.focusEmail)
          _buildEmailValidatorWrapper(viewModel),
      ];

  Widget _buildTitle() => Text(
        LocaleKeys.create_account.tr(),
        style: style25DG600,
      );

  Widget _buildSubtitleWrapper(RegisterViewModel viewModel) => LoginAccount(
        onTap: () async => await viewModel.replaceToLogin(),
      );

  Widget _buildEmailFormField(RegisterViewModel viewModel) => TextFormField(
        controller: emailController,
        onTap: viewModel.setEmailFocus,
        keyboardType: TextInputType.emailAddress,
        decoration: inputDecoration(
            hint: LocaleKeys.email.tr(),
            focus: viewModel.focusEmail,
            filled: emailController.text.isNotEmpty),
      );

  Widget _buildEmailValidatorWrapper(RegisterViewModel viewModel) =>
      viewModel.hasEmailValidationMessage
          ? _buildEmailValidator(viewModel)
          : Container();

  Widget _buildEmailValidator(RegisterViewModel viewModel) => Text(
        viewModel.emailValidationMessage!,
        style: style12R700,
      );

  Widget _buildLowerColumn(RegisterViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildLowerColumnChildren(viewModel),
      );

  List<Widget> _buildLowerColumnChildren(RegisterViewModel viewModel) => [
        _buildContinueButton(viewModel),
        _buildRegisterWithGoogleButton(viewModel),
        if (viewModel.isAppleSignInAvailable)
          _buildRegisterWithAppleButton(viewModel),
        verticalSpaceMedium,
        _buildOptionTextDivider(),
        verticalSpaceMedium,
        _buildRegisterWithEmailButton(viewModel),
        verticalSpaceMedium
      ];

  Widget _buildContinueButton(RegisterViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        bottom: false,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: LocaleKeys.cont.tr(),
        onTap: emailController.text.isNotEmpty &&
                !viewModel.hasEmailValidationMessage
            ? () => _addUserData(viewModel)
            : null,
        backgroundColor: emailController.text.isNotEmpty &&
                !viewModel.hasEmailValidationMessage
            ? kcPrimaryColor
            : kcPrimaryColor.withValues(alpha: 0.1),
      );

  Widget _buildRegisterWithGoogleButton(RegisterViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        bottom: false,
        borderRadius: 12,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        text: LocaleKeys.register_with_google.tr(),
        leadingImage: 'assets/icons/google.png',
        onTap: () async => await viewModel.registerWithGoogle(),
      );

  Widget _buildRegisterWithAppleButton(RegisterViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        text: LocaleKeys.register_with_apple.tr(),
        leadingIcon: Icons.apple,
        onTap: () async => await viewModel.registerWithApple(),
      );

  Widget _buildOptionTextDivider() => const OptionTextDivider();

  Widget _buildRegisterWithEmailButton(RegisterViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        top: false,
        bottom: false,
        borderRadius: 12,
        backgroundColor: kcWhite,
        leadingIcon: Icons.phone,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        onTap: () => viewModel.goTo(page: 1),
        text: LocaleKeys.register_with_phone.tr(),
      );

  Widget _buildRegisterWithEmailState(RegisterViewModel viewModel) =>
      viewModel.busy(StateObjects.register)
          ? const PageLoadingIndicator()
          : Container();

  Widget _buildRegisterWithGoogleState(RegisterViewModel viewModel) =>
      viewModel.busy(StateObjects.registerWithGoogle)
          ? const PageLoadingIndicator()
          : Container();

  Widget _buildRegisterWithAppleState(RegisterViewModel viewModel) =>
      viewModel.busy(StateObjects.registerWithApple)
          ? const PageLoadingIndicator()
          : Container();
}
