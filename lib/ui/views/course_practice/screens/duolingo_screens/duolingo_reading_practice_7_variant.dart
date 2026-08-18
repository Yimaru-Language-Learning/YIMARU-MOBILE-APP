import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../common/app_colors.dart';
import '../../course_practice_viewmodel.dart';
import 'duolingo_reading_practice_7_question.dart';

class DuolingoReadingPractice7Variant
    extends ViewModelWidget<CoursePracticeViewModel> {
  Widget _getVariant(CoursePracticeViewModel viewModel) {
    if (viewModel.variants == 0) {
      return _buildVariant1(viewModel);
    } else if (viewModel.variants == 1) {
      return _buildVariant2(viewModel);
    } else {
      return Container();
    }
  }

  const DuolingoReadingPractice7Variant({super.key});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffold(viewModel);

  Widget _buildScaffold(CoursePracticeViewModel viewModel) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kcBackgroundColor,
        body: _getVariant(viewModel),
      );

  Widget _buildVariant1(CoursePracticeViewModel viewModel) => _buildVariant(
        instruction: viewModel.questions[viewModel.currentQuestion]
            .dynamicPayload?.stimulus?[0].value,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[1].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[1].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[2].value['seconds'],
      );

  Widget _buildVariant2(CoursePracticeViewModel viewModel) => _buildVariant(
        instruction: viewModel.questions[viewModel.currentQuestion]
            .dynamicPayload?.stimulus?[2].value,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[3].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[3].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[2].value['seconds'],
      );

  Widget _buildVariant(
          {required int duration,
          required String question,
          required String response,
          required String instruction}) =>
      DuolingoReadingPractice7Question(
        response: response,
        question: question,
        duration: duration,
        instruction: instruction,
      );
}
