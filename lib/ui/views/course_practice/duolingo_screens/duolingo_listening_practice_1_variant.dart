import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_listening_practice_1_question.dart';
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

class DuolingoListeningPractice1Variant
    extends ViewModelWidget<CoursePracticeViewModel> {
  final TextEditingController practiceController;

  const DuolingoListeningPractice1Variant(
      {super.key, required this.practiceController});

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
        _buildVariant4(viewModel),
        _buildVariant5(viewModel),
      ];

  Widget _buildVariant1(CoursePracticeViewModel viewModel) => _buildVariant(
        question: 1,
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[0].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[1].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[0].value['seconds'],
      );

  Widget _buildVariant2(CoursePracticeViewModel viewModel) => _buildVariant(
        question: 2,
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[1].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[3].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[2].value['seconds'],
      );

  Widget _buildVariant3(CoursePracticeViewModel viewModel) => _buildVariant(
        question: 3,
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[2].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[5].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[4].value['seconds'],
      );

  Widget _buildVariant4(CoursePracticeViewModel viewModel) => _buildVariant(
        question: 4,
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[3].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[7].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[6].value['seconds'],
      );

  Widget _buildVariant5(CoursePracticeViewModel viewModel) => _buildVariant(
        question: 5,
        viewModel: viewModel,
        audio: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[4].value,
        response: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[9].value,
        duration: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[8].value['seconds'],
      );

  Widget _buildVariant(
          {required String audio,
          required int question,
          required int duration,
          required String response,
          required CoursePracticeViewModel viewModel}) =>
      DuolingoListeningPractice1Question(
        audio: audio,
        response: response,
        question: question,
        duration: duration,
        practiceController: practiceController,
      );
}
