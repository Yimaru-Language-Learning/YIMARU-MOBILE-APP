import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../common/app_colors.dart';
import '../common/enmus.dart';
import '../common/ui_helpers.dart';
import '../views/course_practice_question/course_practice_question_view.form.dart';
import '../views/course_practice_question/course_practice_question_viewmodel.dart';
import 'custom_circular_progress_indicator.dart';
import 'custom_elevated_button.dart';

class WritingCoursePracticeQuestion
    extends ViewModelWidget<CoursePracticeQuestionViewModel> {
  final int index;
  final TextEditingController answerController;

  const WritingCoursePracticeQuestion(
      {super.key, required this.index, required this.answerController});

  @override
  Widget build(
          BuildContext context, CoursePracticeQuestionViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(CoursePracticeQuestionViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(CoursePracticeQuestionViewModel viewModel) =>
      [_buildColumnScroller(viewModel), _buildContinueButtonWrapper(viewModel)];

  Widget _buildColumnScroller(CoursePracticeQuestionViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildUpperColumn(viewModel),
      );

  Widget _buildUpperColumn(CoursePracticeQuestionViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(
          CoursePracticeQuestionViewModel viewModel) =>
      [
        verticalSpaceMedium,
        _buildTitle(viewModel),
        verticalSpaceLarge,
        _buildQuestionFormField(viewModel),
        if (viewModel.hasAnswerValidationMessage && viewModel.focusAnswer)
          verticalSpaceTiny,
        if (viewModel.hasAnswerValidationMessage && viewModel.focusAnswer)
          _buildQuestionValidatorWrapper(viewModel),
      ];

  Widget _buildTitle(CoursePracticeQuestionViewModel viewModel) => Text(
        'Q${index + 1}. ${viewModel.coursePracticeQuestions[index].questionText} ',
        style: style16DG600,
      );

  Widget _buildQuestionFormField(CoursePracticeQuestionViewModel viewModel) =>
      TextFormField(
        maxLines: 3,
        controller: answerController,
        onTap: viewModel.setAnswerFocus,
        decoration: inputDecoration(
            hint: 'Enter Your Answer',
            focus: viewModel.focusAnswer,
            filled: answerController.text.isNotEmpty),
      );

  Widget _buildQuestionValidatorWrapper(
          CoursePracticeQuestionViewModel viewModel) =>
      viewModel.hasAnswerValidationMessage
          ? _buildQuestionValidator(viewModel)
          : Container();

  Widget _buildQuestionValidator(CoursePracticeQuestionViewModel viewModel) =>
      Text(
        viewModel.answerValidationMessage!,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _buildContinueButtonWrapper(
          CoursePracticeQuestionViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButtonState(viewModel),
      );

  Widget _buildContinueButtonState(CoursePracticeQuestionViewModel viewModel) =>
      viewModel.busy(StateObjects.coursePracticeQuestion)
          ? _buildProgressIndicator()
          : _buildContinueButton(viewModel);

  Widget _buildProgressIndicator() =>
      const CustomCircularProgressIndicator(color: kcPrimaryColor);

  Widget _buildContinueButton(CoursePracticeQuestionViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: answerController.text.isNotEmpty
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
        onTap: answerController.text.isNotEmpty
            ? () async => await viewModel.nextQuestion(
                index + 1 < viewModel.coursePracticeQuestions.length
                    ? index + 1
                    : index)
            : null,
        text: viewModel.currentQuestionIndex ==
                viewModel.coursePracticeQuestions.length - 1
            ? 'Finish'
            : 'Continue',
      );
}
