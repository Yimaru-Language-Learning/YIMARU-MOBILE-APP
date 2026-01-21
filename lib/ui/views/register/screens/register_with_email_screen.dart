import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/widgets/login_account.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/option_text_divider.dart';
import '../register_viewmodel.dart';
import '../register_view.form.dart';

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
    viewModel.addUserData(data);
    viewModel.goTo(page: 2, type: RegistrationType.email);
  }

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
        verticalSpaceLarge,
        _buildEmailFormField(viewModel),
        if (viewModel.hasEmailValidationMessage && viewModel.focusEmail)
          verticalSpaceTiny,
        if (viewModel.hasEmailValidationMessage && viewModel.focusEmail)
          _buildEmailValidatorWrapper(viewModel),
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

  Widget _buildEmailFormField(RegisterViewModel viewModel) => TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        onTap: viewModel.setEmailFocus,
        decoration: inputDecoration(
            hint: 'Email',
            focus: viewModel.focusEmail,
            filled: emailController.text.isNotEmpty),
      );

  Widget _buildEmailValidatorWrapper(RegisterViewModel viewModel) =>
      viewModel.hasEmailValidationMessage
          ? _buildEmailValidator(viewModel)
          : Container();

  Widget _buildEmailValidator(RegisterViewModel viewModel) => Text(
        viewModel.emailValidationMessage!,
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
        _buildRegisterWithEmailButton(viewModel),
        verticalSpaceMedium
      ];

  Widget _buildContinueButton(RegisterViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: emailController.text.isNotEmpty &&
                !viewModel.hasEmailValidationMessage
            ? () => _addUserData(viewModel)
            : null,
        backgroundColor: emailController.text.isNotEmpty &&
                !viewModel.hasEmailValidationMessage
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
      );

  Widget _buildOptionTextDivider() => const OptionTextDivider();

  Widget _buildRegisterWithEmailButton(RegisterViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        backgroundColor: kcWhite,
        leadingIcon: Icons.phone,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        text: 'Register with Phone Number',
        onTap: () => viewModel.goTo(page: 1),
      );
}
