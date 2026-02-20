import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/assessment/screens/Assessment_form_screen.dart';
import 'package:yimaru_app/ui/views/assessment/screens/assessment_completion_screen.dart';
import 'package:yimaru_app/ui/views/assessment/screens/assessment_failure_screen.dart';
import 'package:yimaru_app/ui/views/assessment/screens/assessment_intro_screen.dart';
import 'package:yimaru_app/ui/views/assessment/screens/assessment_result_screen.dart';
import 'package:yimaru_app/ui/views/assessment/screens/result_analysis_screen.dart';
import 'package:yimaru_app/ui/views/assessment/screens/retake_assessment_screen.dart';
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
  AssessmentViewModel viewModelBuilder(BuildContext context) => AssessmentViewModel();

  @override
  Widget builder(
    BuildContext context,
    AssessmentViewModel viewModel,
    Widget? child,
  ) =>
      _buildAssessmentScreens(viewModel);

  Widget _buildAssessmentScreens(AssessmentViewModel viewModel) => IndexedStack(
        index: viewModel.currentPage,
        children: _buildScreens(),
      );

  List<Widget> _buildScreens() => [
        _buildAssessmentIntro(),
        _buildAssessment(),
        /*
         _buildAssessmentFailure(),
         _buildRetakeAssessment(),
         _buildResultAnalysis(),
         _buildAssessmentCompletion(),
         */
        _buildAssessmentResult(),
        _buildStartLesson(),
      ];

  Widget _buildAssessmentIntro() => const AssessmentIntroScreen();

  Widget _buildAssessment() => const AssessmentFormScreen();

  Widget _buildAssessmentFailure() => const AssessmentFailureScreen();

  Widget _buildRetakeAssessment() => const RetakeAssessmentScreen();

  Widget _buildResultAnalysis() => const ResultAnalysisScreen();

  Widget _buildAssessmentCompletion() => const AssessmentCompletionScreen();

  Widget _buildAssessmentResult() => const AssessmentResultScreen();

  Widget _buildStartLesson() => const StartLessonScreen();


}
