import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_4_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_4_question.dart';

import '../../../common/app_colors.dart';
import '../course_practice_viewmodel.dart';

class DuolingoSpeakingPractice4Variant
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoSpeakingPractice4Variant({super.key});

  Widget _getVariant(CoursePracticeViewModel viewModel) {
    if (viewModel.variants == 0) {
      return _buildVariant1(viewModel);
    } else if (viewModel.variants == 1) {
      return _buildVariant2(viewModel);
    } else if (viewModel.variants == 2) {
      return _buildVariant3(viewModel);
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
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[1].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[2].value['seconds'],

        /*      response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[1].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[0].value['seconds'],
        stimulus: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[1].value,*/
      );

  Widget _buildVariant2(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[3].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[3].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[4].value['seconds'],

        /*   response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[3].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[2].value['seconds'],
        stimulus: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[2].value,*/
      );

  Widget _buildVariant3(CoursePracticeViewModel viewModel) => _buildVariant(
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[3].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[5].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[4].value['seconds'],
      );

  Widget _buildVariant(
          {required int duration,
          required String audio,
          required String response,
          required CoursePracticeViewModel viewModel}) =>
      IndexedStack(
        index: viewModel.variant,
        children: _buildPractice(
            stimulus: audio, response: response, duration: duration),
      );

  List<Widget> _buildPractice({
    required int duration,
    required String stimulus,
    required String response,
  }) =>
      [
        const DuolingoSpeakingPractice4Question(),
        DuolingoSpeakingPractice4Answer(
            audio: stimulus, response: response, duration: duration)
      ];
}
