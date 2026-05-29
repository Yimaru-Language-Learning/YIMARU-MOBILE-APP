import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/helper_functions.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

import '../onboarding_view.form.dart';

class FullNameFormScreen extends ViewModelWidget<OnboardingViewModel> {
  final TextEditingController fullNameController;

  const FullNameFormScreen({super.key, required this.fullNameController});

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = splitFullName(fullNameController.text);

    viewModel.addUserData(data);

    viewModel.next();
  }

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(OnboardingViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(OnboardingViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(OnboardingViewModel viewModel) =>
      [_buildAppBar(viewModel), _buildExpandedBody(viewModel)];

  Widget _buildExpandedBody(OnboardingViewModel viewModel) =>
      Expanded(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(OnboardingViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(OnboardingViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(OnboardingViewModel viewModel) =>
      [_buildColumnScroller(viewModel), _buildContinueButtonWrapper(viewModel)];

  Widget _buildColumnScroller(OnboardingViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildUpperColumn(viewModel),
      );

  Widget _buildUpperColumn(OnboardingViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(OnboardingViewModel viewModel) => [
        verticalSpaceLarge,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubtitle(),
        verticalSpaceLarge,
        _buildFullNameFormField(viewModel),
        if (viewModel.hasFullNameValidationMessage && viewModel.focusFullName)
          verticalSpaceTiny,
        if (viewModel.hasFullNameValidationMessage && viewModel.focusFullName)
          _buildFullNameValidatorWrapper(viewModel)
      ];

  Widget _buildAppBar(OnboardingViewModel viewModel) => LargeAppBar(
        showBackButton: false,
        showLanguageSelection: true,
        onLanguage: () async => await viewModel.navigateToLanguage(),
        language: viewModel.selectedLanguage['code'] == 'am'
            ? 'አማ'
            : viewModel.selectedLanguage['code'],
      );

  Widget _buildTitle() => Text(
        '${LocaleKeys.what_should_we_call_you.tr()} 😊',
        style: style25DG600,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.name_for_personalization.tr(),
        style: style14MG400,
      );

  Widget _buildFullNameFormField(OnboardingViewModel viewModel) =>
      TextFormField(
        controller: fullNameController,
        onTap: viewModel.setFullNameFocus,
        decoration: inputDecoration(
            focus: viewModel.focusFullName,
            hint: LocaleKeys.enter_full_name.tr(),
            filled: fullNameController.text.isNotEmpty),
      );

  Widget _buildFullNameValidatorWrapper(OnboardingViewModel viewModel) =>
      viewModel.hasFullNameValidationMessage
          ? _buildFullNameValidator(viewModel)
          : Container();

  Widget _buildFullNameValidator(OnboardingViewModel viewModel) => Text(
        viewModel.fullNameValidationMessage!,
        style: style12R700,
      );

  Widget _buildContinueButtonWrapper(OnboardingViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(OnboardingViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: LocaleKeys.cont.tr(),
        backgroundColor: fullNameController.text.isNotEmpty &&
                !viewModel.hasFullNameValidationMessage
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
        onTap: fullNameController.text.isNotEmpty &&
                !viewModel.hasFullNameValidationMessage
            ? () => _next(viewModel)
            : null,
      );
}
