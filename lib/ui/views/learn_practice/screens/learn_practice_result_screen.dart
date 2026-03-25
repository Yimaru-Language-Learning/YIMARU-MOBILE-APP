import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_tip_section.dart';
import 'package:yimaru_app/ui/widgets/practice_results_wrapper.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/small_app_bar.dart';

class LearnPracticeResultScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeResultScreen({super.key});

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnPracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnPracticeViewModel viewModel) =>
      SafeArea(child: _buildBodyColumnWrapper(viewModel));

  Widget _buildBodyColumnWrapper(LearnPracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(viewModel) => Column(
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(LearnPracticeViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBar(viewModel),
        verticalSpaceMedium,
        _buildBodyWrapper(viewModel)
      ];

  Widget _buildAppBar(LearnPracticeViewModel viewModel) => SmallAppBar(
        title: 'Result',
        showBackButton: true,
        onTap: viewModel.goBack,
      );

  Widget _buildBodyWrapper(LearnPracticeViewModel viewMode) => Expanded(
        child: _buildBodyScroller(viewMode),
      );

  Widget _buildBodyScroller(LearnPracticeViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildBody(viewModel),
      );

  Widget _buildBody(LearnPracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(LearnPracticeViewModel viewModel) => [
        _buildResultsSection(viewModel),
        verticalSpaceMedium,
        _buildLearnPracticeTipSection(),
        verticalSpaceLarge,
        _buildLowerButtonsSection(viewModel)
      ];

  Widget _buildResultsSection(LearnPracticeViewModel viewModel) =>
      PracticeResultsWrapper(data: viewModel.practiceResults);

  Widget _buildLearnPracticeTipSection() => const LearnPracticeTipSection();

  Widget _buildLowerButtonsSection(LearnPracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildLowerButtonsSectionChildren(viewModel),
      );

  List<Widget> _buildLowerButtonsSectionChildren(
          LearnPracticeViewModel viewModel) =>
      [
        _buildContinueButton(viewModel),
        verticalSpaceSmall,
        _buildPracticeAgainButton(viewModel),
        verticalSpaceMedium,
      ];

  Widget _buildContinueButton(LearnPracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: () => viewModel.goTo(6),
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildPracticeAgainButton(LearnPracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Retry',
        borderRadius: 12,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        onTap: () => viewModel.goTo(1),
        foregroundColor: kcPrimaryColor,
      );
}
