import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../common/app_colors.dart';
import '../../course_practice_viewmodel.dart';
import 'duolingo_listening_practice_1_question.dart';

class DuolingoListeningPractice1Variant
    extends ViewModelWidget<CoursePracticeViewModel> {
  final TextEditingController practiceController;

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

  const DuolingoListeningPractice1Variant(
      {super.key, required this.practiceController});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffold(viewModel);

  Widget _buildScaffold(CoursePracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _getVariant(viewModel),
      );

  Widget _buildVariant1(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[0].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[1].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[2].value['seconds'],
      );

  Widget _buildVariant2(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[1].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[3].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[4].value['seconds'],
      );

  Widget _buildVariant3(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[2].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[5].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[6].value['seconds'],
      );

  Widget _buildVariant4(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[3].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[7].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[8].value['seconds'],
      );

  Widget _buildVariant5(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[4].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[9].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[8].value['seconds'],
      );

  Widget _buildVariant(
          {required int duration,
          required String response,
          required String question,
          required CoursePracticeViewModel viewModel}) =>
      DuolingoListeningPractice1Question(
        question: question,
        response: response,
        duration: duration,
        practiceController: practiceController,
      );
}
