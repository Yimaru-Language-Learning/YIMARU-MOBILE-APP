import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/course_practice_question/course_practice_question_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';
import 'package:yimaru_app/ui/widgets/selectable_course_practice_question.dart';
import 'package:yimaru_app/ui/widgets/writing_course_practice_question.dart';

import 'question_loading_screen.dart';

class PracticeQuestionsScreen
    extends ViewModelWidget<CoursePracticeQuestionViewModel> {
  final int id;
  final TextEditingController answerController;

  const PracticeQuestionsScreen(
      {super.key, required this.id, required this.answerController});

  @override
  Widget build(
          BuildContext context, CoursePracticeQuestionViewModel viewModel) =>
      _buildAssessmentScreens(viewModel);

  Widget _buildAssessmentScreens(CoursePracticeQuestionViewModel viewModel) =>
      viewModel.busy(StateObjects.coursePracticeQuestions) ||
              viewModel.busy(StateObjects.coursePracticeQuestion) ||
              viewModel.coursePracticeQuestions.isEmpty ||
              viewModel.currentQuestion == null
          ? _buildPageLoadingIndicator(viewModel)
          : _buildScaffoldWrapper(viewModel);

  Widget _buildPageLoadingIndicator(
          CoursePracticeQuestionViewModel viewModel) =>
      QuestionLoadingScreen(
        onPop: viewModel.coursePracticeQuestions.isEmpty ||
                viewModel.currentQuestion == null
            ? viewModel.pop
            : null,
        isEmpty: viewModel.coursePracticeQuestions.isEmpty ||
                viewModel.currentQuestion == null
            ? true
            : false,
        isLoading: viewModel.busy(StateObjects.coursePracticeQuestions) ||
            viewModel.busy(StateObjects.coursePracticeQuestion),
        onTap: () async => await viewModel.getCoursePracticeQuestions(id),
      );

  Widget _buildScaffoldWrapper(CoursePracticeQuestionViewModel viewModel) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CoursePracticeQuestionViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(
          CoursePracticeQuestionViewModel viewModel) =>
      [_buildAppBar(viewModel), _buildExpandedBody(viewModel)];

  Widget _buildAppBar(CoursePracticeQuestionViewModel viewModel) => LargeAppBar(
        onClose: viewModel.abort,
        showLanguageSelection: false,
        onPop: viewModel.previousQuestion,
        showBackButton: viewModel.currentQuestionIndex == 0 ? false : true,
      );

  Widget _buildExpandedBody(CoursePracticeQuestionViewModel viewModel) =>
      Expanded(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(CoursePracticeQuestionViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestion(viewModel),
      );

  Widget _buildQuestion(CoursePracticeQuestionViewModel viewModel) =>
      PageView.builder(
        controller: viewModel.pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.coursePracticeQuestions.length,
        itemBuilder: (cotext, index) =>
            _buildQuestionType(index: index, viewModel: viewModel),
      );

  Widget _buildQuestionType(
          {required int index,
          required CoursePracticeQuestionViewModel viewModel}) =>
      viewModel.currentQuestion?.questionType == 'SHORT_ANSWER'
          ? _buildWritingCoursePracticeQuestion(index)
          : _buildCoursePracticeQuestionWrapper(index);

  Widget _buildCoursePracticeQuestionWrapper(int index) =>
      SingleChildScrollView(
        child: _buildSelectableCoursePracticeQuestion(index),
      );

  Widget _buildSelectableCoursePracticeQuestion(int index) =>
      SelectableCoursePracticeQuestion(index: index);

  Widget _buildWritingCoursePracticeQuestion(int index) =>
      WritingCoursePracticeQuestion(
          index: index, answerController: answerController);
}
