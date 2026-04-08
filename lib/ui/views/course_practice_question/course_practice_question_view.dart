import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/ui/views/course_practice_question/course_practice_question_view.form.dart';
import 'package:yimaru_app/ui/views/course_practice_question/screens/practice_questions_screen.dart';
import 'package:yimaru_app/ui/views/course_practice_question/screens/practice_result_screen.dart';

import '../../common/validators/form_validator.dart';
import 'course_practice_question_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'answer', validator: FormValidator.validateForm),
])
class CoursePracticeQuestionView
    extends StackedView<CoursePracticeQuestionViewModel>
    with $CoursePracticeQuestionView {
  final int id;

  const CoursePracticeQuestionView({Key? key, required this.id})
      : super(key: key);

  @override
  void onViewModelReady(CoursePracticeQuestionViewModel viewModel) async {
    await viewModel.getCoursePracticeQuestions(id);
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  CoursePracticeQuestionViewModel viewModelBuilder(BuildContext context) =>
      CoursePracticeQuestionViewModel();

  @override
  Widget builder(
    BuildContext context,
    CoursePracticeQuestionViewModel viewModel,
    Widget? child,
  ) =>
      _buildAssessmentScreensWrapper(viewModel);

  Widget _buildAssessmentScreensWrapper(
          CoursePracticeQuestionViewModel viewModel) =>
      PopScope(
          canPop: false,
          onPopInvokedWithResult: (value, data) => viewModel.previousQuestion(),
          child: _buildAssessmentScreens(viewModel));

  Widget _buildAssessmentScreens(CoursePracticeQuestionViewModel viewModel) =>
      IndexedStack(
        index: viewModel.currentPage,
        children: _buildScreens(),
      );

  List<Widget> _buildScreens() => [
        _buildPracticeQuestionScreen(),
        _buildPracticeResultScreen(),
      ];

  Widget _buildPracticeQuestionScreen() =>
      PracticeQuestionsScreen(id: id, answerController: answerController);

  Widget _buildPracticeResultScreen() => const PracticeResultScreen();
}
