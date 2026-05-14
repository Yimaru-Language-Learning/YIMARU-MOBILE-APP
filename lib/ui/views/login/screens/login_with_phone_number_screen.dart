import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/login/login_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/option_text_divider.dart';
import 'package:yimaru_app/ui/widgets/register_for_account.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/large_app_bar.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../../../widgets/phone_number_prefix.dart';
import '../login_view.form.dart';

class LoginWithPhoneNumberScreen extends ViewModelWidget<LoginViewModel> {
  final TextEditingController phoneNumberController;

  const LoginWithPhoneNumberScreen(
      {super.key, required this.phoneNumberController});

  Future<void> _login(LoginViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'phone_number': '251${phoneNumberController.text}',
    };
    viewModel.addUserData(data);

    await viewModel.loginWithPhoneNumber();
  }

  Widget getPadding(context) {
    double half = screenHeight(context) / 2;
    return SizedBox(
      height: half + 175 - half,
    );
  }

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldStack(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldStack(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      Stack(children: [
        _buildScaffold(context: context, viewModel: viewModel),
        _buildLoginWithPhoneNumber(viewModel),
      ]);

  Widget _buildScaffold(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            _buildScaffoldChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildScaffoldChildren(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      [
        _buildAppBar(viewModel),
        verticalSpaceMedium,
        _buildExpandedBody(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBar(LoginViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        showLanguageSelection: true,
        onPop: () => viewModel.goTo(0),
    language: viewModel.selectedLanguage['code'],

    onLanguage: ()async => await viewModel.navigateToLanguage(),

  );

  Widget _buildExpandedBody(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      Expanded(
          child: _buildColumnScroller(context: context, viewModel: viewModel));

  Widget _buildColumnScroller(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildBodyWrapper(context: context, viewModel: viewModel),
      );

  Widget _buildBodyWrapper(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(context: context, viewModel: viewModel),
      );

  Widget _buildBody(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBodyChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyChildren(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      [
        _buildUpperColumn(viewModel),
        getPadding(context),
        _buildLowerColumn(viewModel)
      ];

  Widget _buildUpperColumn(LoginViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(LoginViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        _buildSubtitleWrapper(viewModel),
        verticalSpaceMedium,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildPhoneNumberWrapper(viewModel),
        if (viewModel.hasPhoneNumberValidationMessage &&
            viewModel.focusPhoneNumber)
          verticalSpaceTiny,
        if (viewModel.hasPhoneNumberValidationMessage &&
            viewModel.focusPhoneNumber)
          _buildPhoneNumberValidatorWrapper(viewModel),
      ];

  Widget _buildTitle() => Text(
        'Welcome Back',
        style: style25DG600,
      );

  Widget _buildSubtitleWrapper(LoginViewModel viewModel) => RegisterForAccount(
        onTap: () async => await viewModel.navigateToRegister(),
      );

  Widget _buildSubtitle() => Text(
        'Enter your phone number. We will send you a confirmation code there',
        style: style14MG400,
      );

  Widget _buildPhoneNumberWrapper(LoginViewModel viewModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildPhoneNumberChildren(viewModel),
      );

  List<Widget> _buildPhoneNumberChildren(LoginViewModel viewModel) => [
        _buildPhoneNumberPrefix(viewModel),
        horizontalSpaceSmall,
        _buildPhoneNumberFormFieldWrapper(viewModel),
      ];

  Widget _buildPhoneNumberPrefix(LoginViewModel viewModel) =>
      PhoneNumberPrefix(selected: viewModel.focusPhoneNumber);

  Widget _buildPhoneNumberFormFieldWrapper(LoginViewModel viewModel) =>
      Expanded(child: _buildPhoneNumberFormField(viewModel));

  Widget _buildPhoneNumberFormField(LoginViewModel viewModel) => TextFormField(
        maxLength: 9,
        keyboardType: TextInputType.phone,
        controller: phoneNumberController,
        onTap: viewModel.setPhoneNumberFocus,
        decoration: inputDecoration(
            focus: viewModel.focusPhoneNumber,
            filled: phoneNumberController.text.isNotEmpty),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      );

  Widget _buildPhoneNumberValidatorWrapper(LoginViewModel viewModel) =>
      viewModel.hasPhoneNumberValidationMessage
          ? _buildPhoneNumberValidator(viewModel)
          : Container();

  Widget _buildPhoneNumberValidator(LoginViewModel viewModel) => Text(
        viewModel.phoneNumberValidationMessage!,
        style: style12R700,
      );

  Widget _buildLowerColumn(LoginViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildLowerColumnChildren(viewModel),
      );

  List<Widget> _buildLowerColumnChildren(LoginViewModel viewModel) => [
        _buildContinueButton(viewModel),
        _buildOptionTextDivider(),
        _buildLoginWitPhoneNumberButton(viewModel),
        verticalSpaceMedium
      ];

  Widget _buildOptionTextDivider() => const OptionTextDivider();

  Widget _buildContinueButton(LoginViewModel viewModel) => CustomElevatedButton(
        height: 55,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: phoneNumberController.text.isNotEmpty
            ? () async => await _login(viewModel)
            : null,
        backgroundColor: phoneNumberController.text.isNotEmpty
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
      );

  Widget _buildLoginWitPhoneNumberButton(LoginViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Login with Email',
        backgroundColor: kcWhite,
        leadingIcon: Icons.email,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        onTap: () => viewModel.goTo(0),
      );

  Widget _buildLoginWithPhoneNumber(LoginViewModel viewModel) =>
      viewModel.busy(StateObjects.loginWithPhoneNumber)
          ? const PageLoadingIndicator()
          : Container();
}
