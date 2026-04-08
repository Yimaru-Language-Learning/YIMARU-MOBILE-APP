import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/widgets/custom_circular_progress_indicator.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import '../views/course_practice_question/course_practice_question_viewmodel.dart';
import 'custom_elevated_button.dart';
import 'custom_small_radio_button.dart';

class SelectableCoursePracticeQuestion
    extends ViewModelWidget<CoursePracticeQuestionViewModel> {
  final int index;

  const SelectableCoursePracticeQuestion({super.key, required this.index});

  @override
  Widget build(
          BuildContext context, CoursePracticeQuestionViewModel viewModel) =>
      _buildBodyScroller(viewModel);

  Widget _buildBodyScroller(CoursePracticeQuestionViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildBody(viewModel),
      );

  Widget _buildBody(CoursePracticeQuestionViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(CoursePracticeQuestionViewModel viewModel) =>
      [
        verticalSpaceMedium,
        _buildTitle(viewModel),
        verticalSpaceMedium,
        _buildAnswers(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildTitle(CoursePracticeQuestionViewModel viewModel) => Text(
        'Q${index + 1}. ${viewModel.currentQuestion?.questionText} ',
        style: style16DG600,
      );

  Widget _buildAnswers(CoursePracticeQuestionViewModel viewModel) =>
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.currentQuestion?.options?.length,
        itemBuilder: (context, inner) => _buildAnswer(
          title: viewModel.currentQuestion?.options?[inner].optionText ?? '',
          selected: viewModel.isSelectedAnswer(
              question: index + 1,
              answer:
                  viewModel.currentQuestion?.options?[inner].optionText ?? ''),
          onTap: () => viewModel.setSelectedAnswer(
              question: index + 1,
              option: viewModel.currentQuestion?.options?[inner]),
        ),
      );

  Widget _buildAnswer(
          {required String title,
          required bool selected,
          required GestureTapCallback onTap}) =>
      CustomSmallRadioButton(
        title: title,
        onTap: onTap,
        selected: selected,
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

  Widget _buildProgressIndicator()=>const CustomCircularProgressIndicator(color: kcPrimaryColor);

  Widget _buildContinueButton(CoursePracticeQuestionViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: viewModel.currentQuestionIndex ==
            viewModel.coursePracticeQuestions.length - 1
            ? 'Finish'
            : 'Continue',
        backgroundColor:
            viewModel.selectedAnswers.containsKey((index + 1).toString())
                ? kcPrimaryColor
                : kcPrimaryColor.withOpacity(0.1),
        onTap: viewModel.selectedAnswers.containsKey((index + 1).toString())
            ? ()async =>await viewModel.nextQuestion(viewModel
                    .coursePracticeQuestions[
                        index + 1 < viewModel.coursePracticeQuestions.length
                            ? index + 1
                            : index]
                    .questionId ??
                0)
            : null,

      );
}
