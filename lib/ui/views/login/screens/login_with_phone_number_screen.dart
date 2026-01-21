import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/login/login_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/option_text_divider.dart';
import 'package:yimaru_app/ui/widgets/register_for_account.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/phone_number_prefix.dart';
import '../login_view.form.dart';

class LoginWithPhoneNumberScreen extends ViewModelWidget<LoginViewModel> {
  final TextEditingController phoneNumberController;

  const LoginWithPhoneNumberScreen(
      {super.key, required this.phoneNumberController});

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(LoginViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(LoginViewModel viewModel) =>
      [_buildColumnScroller(viewModel), _buildLowerColumn(viewModel)];

  Widget _buildColumnScroller(LoginViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildUpperColumn(viewModel),
      );

  Widget _buildUpperColumn(LoginViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(LoginViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        _buildSubTitleWrapper(viewModel),
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

  Widget _buildTitle() => const Text(
        'Welcome Back',
        style: TextStyle(
          fontSize: 25,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildSubTitleWrapper(LoginViewModel viewModel) => RegisterForAccount(
        onTap: () async => await viewModel.navigateToRegister(),
      );

  Widget _buildSubtitle() => const Text(
        'Enter your phone number. We will send you a confirmation code there',
        style: TextStyle(color: kcMediumGrey),
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
        style: const TextStyle(
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.w700,
        ),
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
            ? () => viewModel.goTo(2)
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
}
