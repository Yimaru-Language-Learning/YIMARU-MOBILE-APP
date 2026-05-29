import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_large_radio_button.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

class LearningGoalFormScreen extends ViewModelWidget<OnboardingViewModel> {
  const LearningGoalFormScreen({super.key});

  IconData getIcon(int index) {
    switch (index) {
      case 0:
        return Iconsax.book;
      case 1:
        return Iconsax.microphone;
      case 2:
        return Iconsax.bag;
    }
    return Icons.book;
  }

  String getTitles(int index) {
    switch (index) {
      case 0:
        return 'Learn to Speak English';
      case 1:
        return 'Practice Speaking English';
      case 2:
        return 'Skill-based Courses';
    }
    return '';
  }

  String getSubtitle(int index) {
    switch (index) {
      case 0:
        return 'I know some English, but i want to learn to speak it';
      case 1:
        return 'I already speak English, but I want more practice.';
      case 2:
        return 'I want courses for IELTS, TOEFL, Duolingo, or work';
    }
    return '';
  }

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
        _buildTitle(viewModel),
        verticalSpaceMedium,
        _buildLearningGoals(viewModel)
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

  Widget _buildTitle(OnboardingViewModel viewModel) => Text.rich(
        TextSpan(
            text:
                '${LocaleKeys.hello.tr()} ${viewModel.userData['first_name']},',
            style: style18P600.copyWith(fontSize: 22),
            children: [
              TextSpan(
                text: ' ${LocaleKeys.learning_goal.tr()}',
                style: style16DG600.copyWith(fontSize: 22),
              )
            ]),
      );

  Widget _buildLearningGoals(OnboardingViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: 3, // viewModel.learningGoals.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildLearningGoal(
          icon: getIcon(index),
          title: getTitles(index),
          subtitle: getSubtitle(index),
          selected:
              viewModel.isSelectedLearningGoal(viewModel.learningGoals[index]),
          onTap: () =>
              viewModel.setSelectedLearningGoal(viewModel.learningGoals[index]),
        ),
      );

  Widget _buildLearningGoal(
          {required String title,
          required bool selected,
          required IconData icon,
          required String subtitle,
          required GestureTapCallback onTap}) =>
      CustomLargeRadioButton(
        icon: icon,
        title: title,
        onTap: onTap,
        subtitle: subtitle,
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
            : kcPrimaryColor.withOpacity(0.1),
      );
}
