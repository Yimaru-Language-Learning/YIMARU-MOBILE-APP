import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/duolingo_practice_question_card.dart';
import '../course_practice_viewmodel.dart';

class DuolingoWritingPractice2Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  final TextEditingController practiceController;

  const DuolingoWritingPractice2Question(
      {super.key, required this.practiceController});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CoursePracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CoursePracticeViewModel viewModel) =>
      SafeArea(child: _buildBodyColumnWrapper(viewModel));

  Widget _buildBodyColumnWrapper(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(CoursePracticeViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(CoursePracticeViewModel viewModel) => [
        _buildAppBarWrapper(viewModel),
        _buildQuestionWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(CoursePracticeViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
        ],
      );

  Widget _buildAppBar(CoursePracticeViewModel viewModel) =>
      DuolingoPracticeAppBar(
        title: 'Writing Assessment',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(CoursePracticeViewModel viewModel) => [
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildQuestion(),
        verticalSpaceMedium,
      ];

  Widget _buildTitle() => Text(
        'Prepare to write about the topic below',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        'You will write for 5 minutes',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion() => const DuolingoPracticeQuestionCard(
      subtitle:
          'Describe a memorable experience from your school or work life and explain why it was meaningful to you.');

  Widget _buildContinueButtonWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Submit',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: () => viewModel.goTo(3),
        backgroundColor: kcPrimaryColor,
      );
}
