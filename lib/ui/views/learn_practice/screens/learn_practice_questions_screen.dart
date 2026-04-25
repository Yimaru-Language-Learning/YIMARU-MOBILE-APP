import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_question.dart';
import 'package:yimaru_app/models/practice.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/start_learn_practice_screen.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/small_app_bar.dart';
import '../learn_practice_viewmodel.dart';
import 'interact_learn_practice_screen.dart';

class LearnPracticeQuestionsScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeQuestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildQuestionSetView(viewModel);

  Widget _buildQuestionSetView(LearnPracticeViewModel viewModel) =>
      PageView.builder(
        itemCount: viewModel.questions.length,
        controller: viewModel.questionSetController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (cotext, index) => _buildQuestionView(
            index: index + 1,
            viewModel: viewModel,
            question: viewModel.questions[index]),
      );

  Widget _buildQuestionView(
          {required int index,
          required LearnQuestion question,
          required LearnPracticeViewModel viewModel}) =>
      PageView(
        controller: viewModel.questionController,
        physics: const NeverScrollableScrollPhysics(),
        children: _buildScreens(index:index,question: question),
      );

  List<Widget> _buildScreens({
    required int index,
    required LearnQuestion question,
  }) =>
      [
        _buildStartLearnPracticeScreen(index:index,question: question),
        _buildInteractLearnPracticeScreen(index:index,question: question)
      ];

  Widget _buildStartLearnPracticeScreen({
  required int index,
  required LearnQuestion question,}
  ) => StartLearnPracticeScreen(
        index: index,
    question: question,
      );

  Widget _buildInteractLearnPracticeScreen({
    required int index,
    required LearnQuestion question,}) =>
      InteractLearnPracticeScreen(index: index,question: question,);
}
