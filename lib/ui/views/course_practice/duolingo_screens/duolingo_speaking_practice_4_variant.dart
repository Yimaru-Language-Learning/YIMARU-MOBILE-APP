import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_4_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_4_preparation.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_4_question.dart';
import 'package:yimaru_app/ui/widgets/dwarf_tile.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../../../widgets/speaking_indicator.dart';
import '../course_practice_viewmodel.dart';

class DuolingoSpeakingPractice4Variant
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoSpeakingPractice4Variant({super.key});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffold(viewModel);

  Widget _buildScaffold(CoursePracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildPageView(viewModel),
      );

  Widget _buildPageView(CoursePracticeViewModel viewModel) => IndexedStack(
        index: viewModel.variants,
        children: _buildPageViewChildren(viewModel),
      );

  List<Widget> _buildPageViewChildren(CoursePracticeViewModel viewModel) => [
        _buildVariant1(viewModel),
        _buildVariant2(viewModel),
        _buildVariant3(viewModel),
      ];

  Widget _buildVariant1(CoursePracticeViewModel viewModel) => _buildVariant(
        question: 1,
        viewModel: viewModel,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[1].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[0].value['seconds'],
        stimulus: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[1].value,
      );

  Widget _buildVariant2(CoursePracticeViewModel viewModel) => _buildVariant(
        question: 2,
        viewModel: viewModel,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[3].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[2].value['seconds'],
        stimulus: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[2].value,
      );

  Widget _buildVariant3(CoursePracticeViewModel viewModel) => _buildVariant(
        question: 3,
        viewModel: viewModel,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[5].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[4].value['seconds'],
        stimulus: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[3].value,
      );

  Widget _buildVariant(
          {required int question,
          required int duration,
          required String stimulus,
          required String response,
          required CoursePracticeViewModel viewModel}) =>
      IndexedStack(
        index: viewModel.variant,
        children: _buildPractice(
            stimulus: stimulus,
            response: response,
            question: question,
            duration: duration),
      );

  List<Widget> _buildPractice({
    required int question,
    required int duration,
    required String stimulus,
    required String response,
  }) =>
      [
        const DuolingoSpeakingPractice4Question(),
        DuolingoSpeakingPractice4Answer(
            stimulus: stimulus,
            response: response,
            question: question,
            duration: duration)
      ];
}
