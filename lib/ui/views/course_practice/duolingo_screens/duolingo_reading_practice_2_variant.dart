import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_listening_practice_1_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_listening_practice_3_question.dart';

import '../../../common/app_colors.dart';
import '../course_practice_viewmodel.dart';
import 'duolingo_reading_practice_2_question.dart';

class DuolingoReadingPractice2Variant
    extends ViewModelWidget<CoursePracticeViewModel> {
  Widget _getVariant(CoursePracticeViewModel viewModel) {
    if (viewModel.variants == 0) {
      return _buildVariant1(viewModel);
    } else if (viewModel.variants == 1) {
      return _buildVariant2(viewModel);
    } else if (viewModel.variants == 2) {
      return _buildVariant3(viewModel);
    } else if (viewModel.variants == 3) {
      return _buildVariant4(viewModel);
    } else if (viewModel.variants == 4) {
      return _buildVariant5(viewModel);
    } else {
      return Container();
    }
  }

  const DuolingoReadingPractice2Variant({super.key});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffold(viewModel);

  Widget _buildScaffold(CoursePracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _getVariant(viewModel),
      );

  Widget _buildVariant1(CoursePracticeViewModel viewModel) => _buildVariant(
        blanks: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[0].value['word_bank'],
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[1].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[2].value['seconds'],
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[0].value['segments'],
      );

  Widget _buildVariant2(CoursePracticeViewModel viewModel) => _buildVariant(
    blanks: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.stimulus?[1].value['word_bank'],
    options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.response?[3].value['options'],
    duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.response?[4].value['seconds'],
    question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.stimulus?[1].value['segments'],
      );

  Widget _buildVariant3(CoursePracticeViewModel viewModel) => _buildVariant(
    blanks: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.stimulus?[2].value['word_bank'],
    options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.response?[5].value['options'],
    duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.response?[6].value['seconds'],
    question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.stimulus?[2].value['segments'],
      );

  Widget _buildVariant4(CoursePracticeViewModel viewModel) => _buildVariant(
    blanks: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.stimulus?[3].value['word_bank'],
    options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.response?[7].value['options'],
    duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.response?[8].value['seconds'],
    question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.stimulus?[3].value['segments'],
      );

  Widget _buildVariant5(CoursePracticeViewModel viewModel) => _buildVariant(
    blanks: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.stimulus?[4].value['word_bank'],
    options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.response?[9].value['options'],
    duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.response?[0].value['seconds'],
    question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.stimulus?[4].value['segments'],
      );

  Widget _buildVariant({
    required List blanks,
    required int duration,
    required List options,
    required dynamic question,
  }) =>
      DuolingoReadingPractice2Question(
        blanks: blanks,
        options: options,
        duration: duration,
        question: question,
      );
}
