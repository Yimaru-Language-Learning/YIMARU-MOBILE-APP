import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_large_radio_button.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

class LearningGoalFormScreen extends ViewModelWidget<OnboardingViewModel> {
  const LearningGoalFormScreen({super.key});

  IconData getIcon(int icon) {
    switch (icon) {
      case 0:
        return Iconsax.book;
      case 1:
        return Iconsax.microphone;
      case 2:
        return Iconsax.bag;
    }
    return Icons.book;
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'learning_goal': viewModel.selectedLearningGoal,
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
        verticalSpaceMedium,
        _buildTitle(viewModel),
        verticalSpaceMedium,
        _buildLearningGoals(viewModel)
      ];

  Widget _buildAppBar(OnboardingViewModel viewModel) => LargeAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
        showLanguageSelection: true,
        onLanguage: () async => await viewModel.navigateToLanguage(),
      );

  Widget _buildTitle(OnboardingViewModel viewModel) => Text(
        'Hi ${viewModel.userData['first_name']}, Choose your learning goal.',
        style: const TextStyle(
          fontSize: 25,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildLearningGoals(OnboardingViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.learningGoals.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildLearningGoal(
          title: viewModel.learningGoals[index]['title'],
          icon: getIcon(viewModel.learningGoals[index]['icon']),
          subtitle: viewModel.learningGoals[index]['subtitle'],
          selected: viewModel
              .isSelectedLearningGoal(viewModel.learningGoals[index]['title']),
          onTap: () => viewModel
              .setSelectedLearningGoal(viewModel.learningGoals[index]['title']),
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
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: viewModel.selectedLearningGoal != null
            ? () => _next(viewModel)
            : null,
        backgroundColor: viewModel.selectedLearningGoal != null
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
      );
}
