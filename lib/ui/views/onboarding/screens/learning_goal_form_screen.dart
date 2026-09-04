import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_small_trailing_radio_button.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

class LearningGoalFormScreen extends ViewModelWidget<OnboardingViewModel> {
  const LearningGoalFormScreen({super.key});

  void _pop(OnboardingViewModel viewModel) {
    viewModel.resetLearningGoalFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'learning_goal': viewModel.selectedLearningGoal?.code,
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

  List<Widget> _buildScaffoldChildren(OnboardingViewModel viewModel) =>
      [_buildAppBar(viewModel), _buildExpandedBody(viewModel)];

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
        verticalSpaceLarge,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildGoals(viewModel),
        verticalSpaceMedium,
      ];

  Widget _buildAppBar(OnboardingViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        showLanguageSelection: true,
        onPop: () => _pop(viewModel),
        onLanguage: () async => await viewModel.navigateToLanguage(),
        language: viewModel.selectedLanguage['code'] == 'am'
            ? 'አማ'
            : viewModel.selectedLanguage['code'],
      );

  Widget _buildTitle() => Text(
        LocaleKeys.learning_goal.tr(),
        style: style25DG600,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.your_goal.tr(),
        style: style14MG400,
      );

  Widget _buildGoals(OnboardingViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: viewModel.learningGoals.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildLearningGoal(
          title: viewModel.learningGoals[index].label ?? '',
          selected:
              viewModel.isSelectedLearningGoal(viewModel.learningGoals[index]),
          onTap: () =>
              viewModel.setSelectedLearningGoal(viewModel.learningGoals[index]),
        ),
      );

  Widget _buildLearningGoal(
          {required String title,
          required bool selected,
          required GestureTapCallback onTap}) =>
      CustomSmallTrailingRadioButton(
        title: title,
        onTap: onTap,
        selected: selected,
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
          onTap: viewModel.selectedLearningGoal != null
              ? () => _next(viewModel)
              : null,
          backgroundColor: viewModel.selectedLearningGoal != null
              ? kcPrimaryColor
              : kcPrimaryColor.withValues(alpha: 0.1));
}
