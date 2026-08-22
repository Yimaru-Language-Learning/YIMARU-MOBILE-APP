import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../../common/app_colors.dart';
import '../../course_practice_viewmodel.dart';
import 'duolingo_reading_practice_1_question.dart';

class DuolingoReadingPractice1Variant
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
    } else if (viewModel.variants == 5) {
      return _buildVariant6(viewModel);
    } else if (viewModel.variants == 6) {
      return _buildVariant7(viewModel);
    } else if (viewModel.variants == 7) {
      return _buildVariant8(viewModel);
    } else if (viewModel.variants == 8) {
      return _buildVariant9(viewModel);
    } else if (viewModel.variants == 9) {
      return _buildVariant10(viewModel);
    } else if (viewModel.variants == 10) {
      return _buildVariant11(viewModel);
    } else if (viewModel.variants == 11) {
      return _buildVariant12(viewModel);
    } else if (viewModel.variants == 12) {
      return _buildVariant13(viewModel);
    } else if (viewModel.variants == 13) {
      return _buildVariant14(viewModel);
    } else if (viewModel.variants == 14) {
      return _buildVariant15(viewModel);
    } else {
      return Container();
    }
  }

  const DuolingoReadingPractice1Variant({super.key});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffold(viewModel);

  Widget _buildScaffold(CoursePracticeViewModel viewModel) => Scaffold(
        
        backgroundColor: kcBackgroundColor,
        body: _getVariant(viewModel),
      );

  Widget _buildVariant1(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[0].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[1].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[2].value['seconds'],
      );

  Widget _buildVariant2(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[1].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[3].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[4].value['seconds'],
      );

  Widget _buildVariant3(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[2].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[5].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[6].value['seconds'],
      );

  Widget _buildVariant4(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[3].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[7].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[8].value['seconds'],
      );

  Widget _buildVariant5(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[4].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[9].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[10].value['seconds'],
      );

  Widget _buildVariant6(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[5].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[11].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[12].value['seconds'],
      );

  Widget _buildVariant7(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[6].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[13].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[14].value['seconds'],
      );

  Widget _buildVariant8(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[7].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[15].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[16].value['seconds'],
      );

  Widget _buildVariant9(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[8].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[17].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[18].value['seconds'],
      );

  Widget _buildVariant10(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[9].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[19].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[20].value['seconds'],
      );

  Widget _buildVariant11(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[10].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[21].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[22].value['seconds'],
      );

  Widget _buildVariant12(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[11].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[23].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[24].value['seconds'],
      );

  Widget _buildVariant13(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[12].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[25].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[26].value['seconds'],
      );

  Widget _buildVariant14(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[13].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[27].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[28].value['seconds'],
      );

  Widget _buildVariant15(CoursePracticeViewModel viewModel) => _buildVariant(
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[14].value,
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[29].value['options'],
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[28].value['seconds'],
      );

  Widget _buildVariant(
          {required String question,
          required int duration,
          required List options}) =>
      DuolingoReadingPractice1Question(
        options: options,
        question: question,
        duration: duration,
      );
}
