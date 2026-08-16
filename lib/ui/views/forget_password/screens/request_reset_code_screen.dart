import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/forget_password/forget_password_viewmodel.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/large_app_bar.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../forget_password_view.form.dart';

class RequestCodeScreen extends ViewModelWidget<ForgetPasswordViewModel> {
  final TextEditingController emailController;

  const RequestCodeScreen({
    super.key,
    required this.emailController,
  });

  Widget getPadding(context) {
    double half = screenHeight(context) / 2;
    return SizedBox(height: half + 375 - half);
  }

  void _inAppPop(ForgetPasswordViewModel viewModel) {
    _clearDataOnNavigation(viewModel);
    viewModel.goBack();
  }

  void _clearDataOnNavigation(ForgetPasswordViewModel viewModel) {
    emailController.clear();
    viewModel.resetRequestResetCodeScreen();
  }

  Future<void> _addUserData(ForgetPasswordViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'email': emailController.text,
    };
    viewModel.addUserData(data);

    await viewModel.requestResetCode();
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
          _buildScaffold(context: context, viewModel: viewModel),
          _buildRequestResetCodeState(viewModel),
        ],
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required ForgetPasswordViewModel viewModel}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            _buildScaffoldChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildScaffoldChildren(
          {required BuildContext context,
          required ForgetPasswordViewModel viewModel}) =>
      [
        _buildAppBar(viewModel),
        _buildExpandedBody(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBar(ForgetPasswordViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        showLanguageSelection: true,
        onPop: () => _inAppPop(viewModel),
        onLanguage: () async => await viewModel.navigateToLanguage(),
        language: viewModel.selectedLanguage['code'] == 'am'
            ? 'አማ'
            : viewModel.selectedLanguage['code'],
      );

  Widget _buildExpandedBody(
          {required BuildContext context,
          required ForgetPasswordViewModel viewModel}) =>
      Expanded(
          child: _buildColumnScroller(context: context, viewModel: viewModel));

  Widget _buildColumnScroller(
          {required BuildContext context,
          required ForgetPasswordViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildBodyWrapper(context: context, viewModel: viewModel),
      );

  Widget _buildBodyWrapper(
          {required BuildContext context,
          required ForgetPasswordViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(context: context, viewModel: viewModel),
      );

  Widget _buildBody(
          {required BuildContext context,
          required ForgetPasswordViewModel viewModel}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyChildren(
          {required BuildContext context,
          required ForgetPasswordViewModel viewModel}) =>
      [
        _buildUpperColumn(viewModel),
        getPadding(context),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildUpperColumn(ForgetPasswordViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(ForgetPasswordViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceLarge,
        _buildEmailFormField(viewModel),
        if (viewModel.hasEmailValidationMessage && viewModel.focusEmail)
          verticalSpaceTiny,
        if (viewModel.hasEmailValidationMessage && viewModel.focusEmail)
          _buildEmailValidatorWrapper(viewModel),
      ];

  Widget _buildTitle() => Text(
        'Reset password',
        style: style25DG600,
      );

  Widget _buildSubtitle() => Text(
        'Enter your email, we will send you a reset code.',
        style: style14DG400,
      );

  Widget _buildEmailFormField(ForgetPasswordViewModel viewModel) =>
      TextFormField(
        controller: emailController,
        onTap: viewModel.setEmailFocus,
        keyboardType: TextInputType.emailAddress,
        decoration: inputDecoration(
            hint: 'Email',
            focus: viewModel.focusEmail,
            filled: emailController.text.isNotEmpty),
      );

  Widget _buildEmailValidatorWrapper(ForgetPasswordViewModel viewModel) =>
      viewModel.hasEmailValidationMessage
          ? _buildEmailValidator(viewModel)
          : Container();

  Widget _buildEmailValidator(ForgetPasswordViewModel viewModel) => Text(
        viewModel.emailValidationMessage!,
        style: style12R700,
      );

  Widget _buildContinueButtonWrapper(ForgetPasswordViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(ForgetPasswordViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: LocaleKeys.cont.tr(),
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: emailController.text.isNotEmpty &&
                !viewModel.hasEmailValidationMessage
            ? () => _addUserData(viewModel)
            : null,
        backgroundColor: emailController.text.isNotEmpty &&
                !viewModel.hasEmailValidationMessage
            ? kcPrimaryColor
            : kcPrimaryColor.withValues(alpha: 0.1),
      );

  Widget _buildRequestResetCodeState(ForgetPasswordViewModel viewModel) =>
      viewModel.busy(StateObjects.requestResetCode)
          ? const PageLoadingIndicator()
          : Container();
}
