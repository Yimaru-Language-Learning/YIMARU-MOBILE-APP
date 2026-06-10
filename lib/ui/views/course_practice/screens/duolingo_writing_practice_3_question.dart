import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/duolingo/duolingo_view.form.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/duolingo_practice_question_card.dart';
import '../course_practice_viewmodel.dart';

class DuolingoWritingPractice3Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  final TextEditingController practiceController;

  const DuolingoWritingPractice3Question(
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
        verticalSpaceMedium,
        _buildQuestion(),
        verticalSpaceMedium,
        _buildAssessmentFormField(viewModel),
        if (viewModel.hasAssessmentValidationMessage &&
            viewModel.focusPractice)
          verticalSpaceTiny,
        if (viewModel.hasAssessmentValidationMessage &&
            viewModel.focusPractice)
          _buildAssessmentWrapper(viewModel),
      ];

  Widget _buildTitle() => Text(
        'Write about the topic below for 5 minutes',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion() => const DuolingoPracticeQuestionCard(
        title: '1. Can you tell me about your favorite type of music?',
      );

  Widget _buildAssessmentFormField(CoursePracticeViewModel viewModel) =>
      TextFormField(
        maxLines: 5,
        maxLength: 250,
        controller: practiceController,
        onTap: viewModel.setPracticeFocus,
        decoration: inputDecoration(
            focus: true,
            hint: 'Start writing here...',
            filled: practiceController.text.isNotEmpty),
      );

  Widget _buildAssessmentWrapper(CoursePracticeViewModel viewModel) =>
      viewModel.hasAssessmentValidationMessage
          ? _buildAssessmentValidator(viewModel)
          : Container();

  Widget _buildAssessmentValidator(CoursePracticeViewModel viewModel) => Text(
        viewModel.assessmentValidationMessage!,
        style: style12R700,
      );

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
        onTap: () => viewModel.goTo(4),
        backgroundColor: kcPrimaryColor,
      );
}
