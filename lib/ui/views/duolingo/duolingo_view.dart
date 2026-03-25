import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/ui/views/duolingo/duolingo_view.form.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_assessments_screens.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_finish_screen.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_intro_screen.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_listening_assessment_1_question.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_listening_assessment_1_review.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_listening_assessment_2_question.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_listening_assessment_2_review.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_listening_assessment_3_question.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_retake_screen.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_speaking_assessment_1_answer.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_speaking_assessment_1_question.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_speaking_assessment_1_review.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_speaking_assessment_2_answer.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_speaking_assessment_2_question.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_speaking_assessment_2_review.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_speaking_assessment_3_answer.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_speaking_assessment_3_question.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_speaking_assessment_3_review.dart'
    hide DuolingoSpeakingAssessment2Question;
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_speaking_assessment_4_answer.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_speaking_assessment_4_question.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_speaking_assessment_4_review.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_writing_assessment_1_question.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_writing_assessment_1_review.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_writing_assessment_2_answer.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_writing_assessment_2_question.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_writing_assessment_2_review.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_writing_assessment_3_question.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_writing_assessment_3_review.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_writing_assessment_4_question.dart';
import 'package:yimaru_app/ui/views/duolingo/screens/duolingo_writing_assessment_4_review.dart';

import '../../common/app_colors.dart';
import '../../common/validators/form_validator.dart';
import 'duolingo_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'assessment', validator: FormValidator.validateForm),
])
class DuolingoView extends StackedView<DuolingoViewModel> with $DuolingoView {
  const DuolingoView({Key? key}) : super(key: key);

  Widget _buildQuestionScreen(DuolingoViewModel viewModel) {
    if (viewModel.selectedAssessment['intro_title'] ==
        'Speak About the Photo') {
      return const DuolingoSpeakingAssessment1Question();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Read, Then Speak') {
      return const DuolingoSpeakingAssessment2Question();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Speaking Sample') {
      return const DuolingoSpeakingAssessment3Question();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Interactive Speaking') {
      return const DuolingoSpeakingAssessment4Question();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Write About the Photo') {
      return DuolingoWritingAssessment1Question(
          assessmentController: assessmentController);
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Writing Sample') {
      return DuolingoWritingAssessment2Question(
          assessmentController: assessmentController);
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Interactive Writing Part 1') {
      return DuolingoWritingAssessment3Question(
          assessmentController: assessmentController);
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Interactive Writing Part 2') {
      return DuolingoWritingAssessment4Question(
          assessmentController: assessmentController);
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Listen and Type') {
      return DuolingoListeningAssessment1Question(
          assessmentController: assessmentController);
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Interactive Listening - Part 1') {
      return DuolingoListeningAssessment2Question(
          assessmentController: assessmentController);
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Interactive Listening - Part 2') {
      return DuolingoListeningAssessment3Question(
          assessmentController: assessmentController);
    }

    return Container();
  }

  Widget _buildAnswerScreen(DuolingoViewModel viewModel) {
    if (viewModel.selectedAssessment['intro_title'] ==
        'Speak About the Photo') {
      return const DuolingoSpeakingAssessment1Answer();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Read, Then Speak') {
      return const DuolingoSpeakingAssessment2Answer();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Speaking Sample') {
      return const DuolingoSpeakingAssessment3Answer();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Interactive Speaking') {
      return const DuolingoSpeakingAssessment4Answer();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Write About the Photo') {
      return Container();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Writing Sample') {
      return DuolingoWritingAssessment2Answer(
          assessmentController: assessmentController);
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Interactive Writing Part 1') {
      return Container();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Interactive Writing Part 2') {
      return Container();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Listen and Type') {
      return Container();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Interactive Listening - Part 1') {
      return Container();
    }

    return Container();
  }

  Widget _buildReviewScreen(DuolingoViewModel viewModel) {
    if (viewModel.selectedAssessment['intro_title'] ==
        'Speak About the Photo') {
      return const DuolingoSpeakingAssessment1Review();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Read, Then Speak') {
      return const DuolingoSpeakingAssessment2Review();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Speaking Sample') {
      return const DuolingoSpeakingAssessment3Review();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Interactive Speaking') {
      return const DuolingoSpeakingAssessment4Review();
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Write About the Photo') {
      return DuolingoWritingAssessment1Review(
          assessmentController: assessmentController);
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Writing Sample') {
      return DuolingoWritingAssessment2Review(
          assessmentController: assessmentController);
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Interactive Writing Part 1') {
      return DuolingoWritingAssessment3Review(
          assessmentController: assessmentController);
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Interactive Writing Part 2') {
      return DuolingoWritingAssessment4Review(
          assessmentController: assessmentController);
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Listen and Type') {
      return DuolingoListeningAssessment1Review(
          assessmentController: assessmentController);
    } else if (viewModel.selectedAssessment['intro_title'] ==
        'Interactive Listening - Part 1') {
      return DuolingoListeningAssessment2Review(
          assessmentController: assessmentController);
    }

    return Container();
  }

  @override
  DuolingoViewModel viewModelBuilder(BuildContext context) =>
      DuolingoViewModel();

  @override
  Widget builder(
    BuildContext context,
    DuolingoViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(DuolingoViewModel viewModel) => PopScope(
      canPop: true,
      onPopInvokedWithResult: (value, data) {
        if (!value) return;
        WidgetsBinding.instance.addPostFrameCallback((_) => viewModel.goBack());
      },
      child: _buildScaffold(viewModel));

  Widget _buildScaffold(DuolingoViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildBody(viewModel),
      );

  Widget _buildBody(DuolingoViewModel viewModel) => IndexedStack(
      index: viewModel.currentIndex, children: _buildScreens(viewModel));

  List<Widget> _buildScreens(DuolingoViewModel viewModel) => [
        _buildDuolingoAssessmentsScreen(),
        _buildDuolingoIntroScreen(viewModel),
        _buildDuolingoQuestionScreen(viewModel),
        _buildDuolingoAnswerScreen(viewModel),
        _buildDuolingoReviewScreen(viewModel),
        _buildDuolingoRetakeScreen(viewModel),
        _buildDuolingoFinishScreen(viewModel),
      ];

  Widget _buildDuolingoAssessmentsScreen() =>
      const DuolingoAssessmentsScreens();

  Widget _buildDuolingoIntroScreen(DuolingoViewModel viewModel) =>
      DuolingoIntroScreen(
          type: viewModel.selectedAssessment['type'],
          title: viewModel.selectedAssessment['intro_title'],
          subtitle: viewModel.selectedAssessment['intro_subtitle']);

  Widget _buildDuolingoQuestionScreen(DuolingoViewModel viewModel) =>
      _buildQuestionScreen(viewModel);

  Widget _buildDuolingoAnswerScreen(DuolingoViewModel viewModel) =>
      _buildAnswerScreen(viewModel);

  Widget _buildDuolingoReviewScreen(DuolingoViewModel viewModel) =>
      _buildReviewScreen(viewModel);

  Widget _buildDuolingoRetakeScreen(DuolingoViewModel viewModel) =>
      DuolingoRetakeScreen(
          title: viewModel.selectedAssessment['outro_title'],
          subtitle: viewModel.selectedAssessment['outro_subtitle']);

  Widget _buildDuolingoFinishScreen(DuolingoViewModel viewModel) =>
      DuolingoFinishScreen(
          title: viewModel.selectedAssessment['outro_title'],
          subtitle: viewModel.selectedAssessment['outro_subtitle']);
}
