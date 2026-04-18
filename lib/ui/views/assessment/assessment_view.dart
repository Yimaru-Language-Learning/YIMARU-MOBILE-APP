import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/assessment/screens/assessment_questions_screen.dart';
import 'package:yimaru_app/ui/views/assessment/screens/assessment_intro_screen.dart';
import 'package:yimaru_app/ui/views/assessment/screens/assessment_result_screen.dart';
import 'package:yimaru_app/ui/views/assessment/screens/start_lesson_screen.dart';

import 'assessment_viewmodel.dart';

class AssessmentView extends StackedView<AssessmentViewModel> {
  final Map<String, dynamic> data;

  const AssessmentView({Key? key, required this.data}) : super(key: key);

  @override
  void onViewModelReady(AssessmentViewModel viewModel) async {
    viewModel.initUserData(data);
    await viewModel.getAssessments();
    super.onViewModelReady(viewModel);
  }

  @override
  AssessmentViewModel viewModelBuilder(BuildContext context) =>
      AssessmentViewModel();

  @override
  Widget builder(
    BuildContext context,
    AssessmentViewModel viewModel,
    Widget? child,
  ) =>
      _buildAssessmentScreensWrapper(viewModel);

  Widget _buildAssessmentScreensWrapper(AssessmentViewModel viewModel) =>
      PopScope(
          canPop: viewModel.currentPage == 0 ? true : false,
          onPopInvokedWithResult: (value, data) => viewModel.goBack(),
          child: _buildAssessmentScreens(viewModel));

  Widget _buildAssessmentScreens(AssessmentViewModel viewModel) => IndexedStack(
        index: viewModel.currentPage,
        children: _buildScreens(),
      );

  List<Widget> _buildScreens() => [
        _buildAssessmentIntro(),
        _buildAssessment(),
        _buildAssessmentResult(),
        _buildStartLesson(),
      ];

  Widget _buildAssessmentIntro() => const AssessmentIntroScreen();

  Widget _buildAssessment() => const AssessmentQuestionsScreen();

  Widget _buildAssessmentResult() => const AssessmentResultScreen();

  Widget _buildStartLesson() => const StartLessonScreen();
}
