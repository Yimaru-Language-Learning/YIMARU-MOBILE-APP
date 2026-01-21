import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/login_account.dart';
import 'package:yimaru_app/ui/widgets/option_text_divider.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/phone_number_prefix.dart';
import '../register_viewmodel.dart';
import '../register_view.form.dart';

class RegisterWithPhoneNumberScreen extends ViewModelWidget<RegisterViewModel> {
  final TextEditingController phoneNumberController;
  const RegisterWithPhoneNumberScreen(
      {super.key, required this.phoneNumberController});

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(RegisterViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(RegisterViewModel viewModel) =>
      [_buildColumnScroller(viewModel), _buildLowerColumn(viewModel)];

  Widget _buildColumnScroller(RegisterViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildUpperColumn(viewModel),
      );

  Widget _buildUpperColumn(RegisterViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(RegisterViewModel viewModel) => [
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
        'Create an Account',
        style: TextStyle(
          fontSize: 25,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildSubTitleWrapper(RegisterViewModel viewModel) => LoginAccount(
        onTap: () async => await viewModel.replaceToLogin(),
      );

  Widget _buildSubtitle() => const Text(
        'Enter your phone number. We will send you a confirmation code there',
        style: TextStyle(color: kcMediumGrey),
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
        style: const TextStyle(
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.w700,
        ),
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
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: phoneNumberController.text.isNotEmpty
            ? () => viewModel.goTo(page: 3, type: RegistrationType.phone)
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
        text: 'Register with Email',
        foregroundColor: kcPrimaryColor,
        onTap: () => viewModel.goTo(page: 0),
      );
}
