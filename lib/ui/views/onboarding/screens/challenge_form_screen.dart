import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_view.form.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_small_radio_button.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

class ChallengeFormScreen extends ViewModelWidget<OnboardingViewModel> {
  final TextEditingController challengeController;

  const ChallengeFormScreen({super.key, required this.challengeController});

  void _pop(OnboardingViewModel viewModel) {
    challengeController.clear();
    viewModel.resetChallengeFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'language_challange':
          viewModel.selectedChallenge ?? challengeController.text,
    };
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

  List<Widget> _buildScaffoldChildren(OnboardingViewModel viewModel) => [
        _buildAppBar(viewModel),
        verticalSpaceMedium,
        _buildExpandedBody(viewModel)
      ];

  Widget _buildExpandedBody(OnboardingViewModel viewModel) =>
      Expanded(child: _buildBodyScroller(viewModel));

  Widget _buildBodyScroller(OnboardingViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildBodyWrapper(viewModel),
      );

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
      [_buildUpperColumn(viewModel), _buildContinueButtonWrapper(viewModel)];

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
        verticalSpaceMedium,
        _buildChallenges(viewModel),
        if (viewModel.showChallengeTextBox) _buildChallengeFormField(viewModel),
        if (viewModel.showChallengeTextBox &&
            viewModel.hasChallengeValidationMessage &&
            viewModel.focusChallenge)
          verticalSpaceTiny,
        if (viewModel.showChallengeTextBox &&
            viewModel.hasChallengeValidationMessage &&
            viewModel.focusChallenge)
          _buildChallengeValidatorWrapper(viewModel),
        verticalSpaceMedium,
      ];

  Widget _buildAppBar(OnboardingViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        showLanguageSelection: true,
        onPop: () => _pop(viewModel),
        onLanguage: () async => await viewModel.navigateToLanguage(),
      );

  Widget _buildTitle() => Text(
        'What challenge do you face most with English?',
        style: style25DG600,
      );

  Widget _buildSubtitle() => Text(
        'Everyone has struggles, let’s start fixing yours 😊',
        style: style14MG400,
      );

  Widget _buildChallenges(OnboardingViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: viewModel.challenges.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildChallenge(
          title: viewModel.challenges[index],
          onTap: () =>
              viewModel.setSelectedChallenge(viewModel.challenges[index]),
          selected: viewModel.isSelectedChallenge(viewModel.challenges[index]),
        ),
      );

  Widget _buildChallenge(
          {required String title,
          required bool selected,
          required GestureTapCallback onTap}) =>
      CustomSmallRadioButton(
        title: title,
        onTap: onTap,
        selected: selected,
      );

  Widget _buildChallengeFormField(OnboardingViewModel viewModel) =>
      TextFormField(
        maxLines: 3,
        controller: challengeController,
        onTap: viewModel.setChallengesFocus,
        decoration: inputDecoration(
            focus: true,
            hint: 'Write your challenge…',
            filled: challengeController.text.isNotEmpty),
      );

  Widget _buildChallengeValidatorWrapper(OnboardingViewModel viewModel) =>
      viewModel.hasChallengeValidationMessage
          ? _buildChallengeValidator(viewModel)
          : Container();

  Widget _buildChallengeValidator(OnboardingViewModel viewModel) => Text(
        viewModel.challengeValidationMessage!,
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
          onTap: viewModel.selectedChallenge != null
              ? viewModel.selectedChallenge?.toLowerCase() == 'other'
                  ? challengeController.text.isNotEmpty
                      ? () => _next(viewModel)
                      : null
                  : () => _next(viewModel)
              : null,
          backgroundColor: viewModel.selectedChallenge != null
              ? viewModel.selectedChallenge?.toLowerCase() == 'other'
                  ? challengeController.text.isNotEmpty
                      ? kcPrimaryColor
                      : kcPrimaryColor.withOpacity(0.1)
                  : kcPrimaryColor
              : kcPrimaryColor.withOpacity(0.1));
}
