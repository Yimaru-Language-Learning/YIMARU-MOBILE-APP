import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/login_account.dart';
import 'package:yimaru_app/ui/widgets/option_text_divider.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/large_app_bar.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../../../widgets/phone_number_prefix.dart';
import '../register_view.form.dart';
import '../register_viewmodel.dart';

class RegisterWithPhoneNumberScreen extends ViewModelWidget<RegisterViewModel> {
  final TextEditingController phoneNumberController;

  const RegisterWithPhoneNumberScreen(
      {super.key, required this.phoneNumberController});

  Future<void> _addUserData(RegisterViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      "role": "STUDENT",
      "otp_medium": "sms",
      'phone_number': '251${phoneNumberController.text}',
    };
    viewModel.clearUserData();
    viewModel.addUserData(data);
    await viewModel.registerWithEmail(SignUpMethod.phone);

    //viewModel.goTo(page: 3, type: RegistrationType.phone);
  }

  Widget getPadding(context) {
    double half = screenHeight(context) / 2;
    return SizedBox(height: half + 170 - half);
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
          _buildRegisterWithPhoneState(viewModel)
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
        verticalSpaceMedium,
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
        LocaleKeys.create_account.tr(),
        style: style25DG600,
      );

  Widget _buildSubtitleWrapper(RegisterViewModel viewModel) => LoginAccount(
        onTap: () async => await viewModel.replaceToLogin(),
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.enter_phone_number.tr(),
        style: style14MG400,
      );

  Widget _buildPhoneNumberWrapper(RegisterViewModel viewModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildPhoneNumberChildren(viewModel),
      );

  List<Widget> _buildPhoneNumberChildren(RegisterViewModel viewModel) => [
        _buildPhoneNumberPrefix(viewModel),
        horizontalSpaceSmall,
        _buildPhoneNumberFormFieldWrapper(viewModel),
      ];

  Widget _buildPhoneNumberPrefix(RegisterViewModel viewModel) =>
      PhoneNumberPrefix(selected: viewModel.focusPhoneNumber);

  Widget _buildPhoneNumberFormFieldWrapper(RegisterViewModel viewModel) =>
      Expanded(child: _buildPhoneNumberFormField(viewModel));

  Widget _buildPhoneNumberFormField(RegisterViewModel viewModel) =>
      TextFormField(
        maxLength: 9,
        keyboardType: TextInputType.phone,
        controller: phoneNumberController,
        onTap: viewModel.setPhoneNumberFocus,
        decoration: inputDecoration(
            focus: viewModel.focusPhoneNumber,
            filled: phoneNumberController.text.isNotEmpty),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      );

  Widget _buildPhoneNumberValidatorWrapper(RegisterViewModel viewModel) =>
      viewModel.hasPhoneNumberValidationMessage
          ? _buildPhoneNumberValidator(viewModel)
          : Container();

  Widget _buildPhoneNumberValidator(RegisterViewModel viewModel) => Text(
        viewModel.phoneNumberValidationMessage!,
        style: style12R700,
      );

  Widget _buildLowerColumn(RegisterViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildLowerColumnChildren(viewModel),
      );

  List<Widget> _buildLowerColumnChildren(RegisterViewModel viewModel) => [
        _buildContinueButton(viewModel),
        _buildOptionTextDivider(),
        _buildRegisterWitPhoneNumberButton(viewModel),
        verticalSpaceMedium
      ];

  Widget _buildOptionTextDivider() => const OptionTextDivider();

  Widget _buildContinueButton(RegisterViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: LocaleKeys.cont.tr(),
        onTap: phoneNumberController.text.isNotEmpty
            ? () async => await _addUserData(viewModel)
            : null,
        backgroundColor: phoneNumberController.text.isNotEmpty
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
      );

  Widget _buildRegisterWitPhoneNumberButton(RegisterViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        backgroundColor: kcWhite,
        leadingIcon: Icons.email,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        onTap: () => viewModel.goTo(page: 0),
        text: LocaleKeys.register_with_email.tr(),
      );

  Widget _buildRegisterWithPhoneState(RegisterViewModel viewModel) =>
      viewModel.busy(StateObjects.register)
          ? const PageLoadingIndicator()
          : Container();
}
