import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

import '../onboarding_view.form.dart';

class OccupationFormScreen extends ViewModelWidget<OnboardingViewModel> {
  final TextEditingController occupationController;

  const OccupationFormScreen({super.key, required this.occupationController});

  void _pop(OnboardingViewModel viewModel) {
    occupationController.clear();
    viewModel.resetOccupationFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {'occupation': occupationController.text};
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
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubtitle(),
        verticalSpaceLarge,
        _buildOccupationFormField(viewModel),
        if (viewModel.hasOccupationValidationMessage &&
            viewModel.focusOccupation)
          verticalSpaceTiny,
        if (viewModel.hasOccupationValidationMessage &&
            viewModel.focusOccupation)
          _buildOccupationValidatorWrapper(viewModel)
      ];

  Widget _buildAppBar(OnboardingViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        showLanguageSelection: true,
        onPop: () => _pop(viewModel),
        onLanguage: () async => await viewModel.navigateToLanguage(),
      );

  Widget _buildTitle() => Text(
        'What’s your occupation?',
        style: style25DG600,
      );

  Widget _buildSubtitle() => Text(
        'We’ll personalize your learning experience based on your occupation.',
        style: style14MG400,
      );

  Widget _buildOccupationFormField(OnboardingViewModel viewModel) =>
      TextFormField(
        controller: occupationController,
        onTap: viewModel.setOccupationFocus,
        decoration: inputDecoration(
            hint: 'Enter Your Occupation',
            focus: viewModel.focusOccupation,
            filled: occupationController.text.isNotEmpty),
      );

  Widget _buildOccupationValidatorWrapper(OnboardingViewModel viewModel) =>
      viewModel.hasOccupationValidationMessage
          ? _buildOccupationValidator(viewModel)
          : Container();

  Widget _buildOccupationValidator(OnboardingViewModel viewModel) => Text(
        viewModel.occupationValidationMessage!,
        style: style12R700,
      );

  Widget _buildContinueButtonWrapper(OnboardingViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(OnboardingViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: occupationController.text.isNotEmpty
            ? () => _next(viewModel)
            : null,
        backgroundColor: occupationController.text.isNotEmpty
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
      );
}
