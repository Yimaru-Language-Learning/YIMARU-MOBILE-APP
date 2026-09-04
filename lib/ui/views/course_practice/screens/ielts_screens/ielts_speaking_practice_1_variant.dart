import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../common/app_colors.dart';
import '../../course_practice_viewmodel.dart';
import 'ielts_speaking_practice_1_answer.dart';
import 'ielts_speaking_practice_1_question.dart';

class IeltsSpeakingPractice1Variant
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsSpeakingPractice1Variant({super.key});

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
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffold(viewModel);

  Widget _buildScaffold(CoursePracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _getVariant(viewModel),
      );

  Widget _buildVariant1(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[2].value,
        text: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[1].value,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[0].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[1].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[2].value['seconds'],
      );

  Widget _buildVariant2(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[4].value,
        text: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[3].value,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[2].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[3].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[4].value['seconds'],
      );

  Widget _buildVariant3(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[6].value,
        text: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[5].value,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[4].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[5].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[6].value['seconds'],
      );

  Widget _buildVariant4(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[8].value,
        text: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[7].value,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[6].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[7].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[8].value['seconds'],
      );

  Widget _buildVariant5(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[10].value,
        text: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[9].value,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[8].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[9].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[10].value['seconds'],
      );

  Widget _buildVariant6(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[12].value,
        text: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[11].value,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[10].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[11].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[12].value['seconds'],
      );

  Widget _buildVariant7(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[14].value,
        text: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[13].value,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[12].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[13].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[14].value['seconds'],
      );

  Widget _buildVariant8(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[16].value,
        text: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[15].value,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[14].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[15].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[16].value['seconds'],
      );

  Widget _buildVariant9(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[18].value,
        text: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[17].value,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[16].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[17].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[18].value['seconds'],
      );

  Widget _buildVariant10(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[18].value,
        text: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[19].value,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[18].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[19].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[18].value['seconds'],
      );

  Widget _buildVariant(
          {required String audio,
          required String text,
          required int duration,
          required String response,
          required String question,
          required CoursePracticeViewModel viewModel}) =>
      IndexedStack(
        index: viewModel.variant,
        children: _buildPractice(
            audio: audio,
            text: text,
            response: response,
            duration: duration,
            question: question),
      );

  List<Widget> _buildPractice({
    required String text,
    required int duration,
    required String audio,
    required String response,
    required String question,
  }) =>
      [
        const IeltsSpeakingPractice1Question(),
        IeltsSpeakingPractice1Answer(
          text: text,
          audio: audio,
          response: response,
          duration: duration,
          question: question,
        )
      ];
}
