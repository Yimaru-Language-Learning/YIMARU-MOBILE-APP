import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/models/course_question.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_listening_practice_1_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_listening_practice_2_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_listening_practice_3_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_listening_practice_4_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_practices_screens.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_finish_screen.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_intro_screen.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_listening_practice_1_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_listening_practice_2_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_listening_practice_3_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_retake_screen.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_speaking_practice_1_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_speaking_practice_1_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_speaking_practice_1_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_speaking_practice_2_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_speaking_practice_2_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_speaking_practice_2_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_speaking_practice_3_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_speaking_practice_3_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_speaking_practice_3_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_speaking_practice_4_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_speaking_practice_4_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_speaking_practice_4_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_writing_practice_1_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_writing_practice_1_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_writing_practice_2_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_writing_practice_2_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_writing_practice_2_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_writing_practice_3_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_writing_practice_3_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_writing_practice_4_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_writing_practice_4_review.dart';

import '../../common/app_colors.dart';
import '../../common/validators/form_validator.dart';
import '../../widgets/cancel_practice_sheet.dart';
import '../../widgets/page_loading_indicator.dart';
import '../../widgets/practice_loading_screen.dart';
import 'course_practice_view.form.dart';
import 'course_practice_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'practice', validator: FormValidator.validateForm),
])
class CoursePracticeView extends StackedView<CoursePracticeViewModel>
    with $CoursePracticeView {
  final int id;

  final CoursePractices practice;

  const CoursePracticeView({
    Key? key,
    required this.id,
    required this.practice,
  }) : super(key: key);

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.pop();
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (_) => _buildSheet(viewModel),
      );

  Widget _buildQuestionScreen(CoursePracticeViewModel viewModel) {
    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 12) {
      return const DuolingoSpeakingPractice1Question();
    } else if (id == 13) {
      return const DuolingoSpeakingPractice2Question();
    } else if (id == 0) {
      return const DuolingoSpeakingPractice3Question();
    } else if (id == 14) {
      return const DuolingoSpeakingPractice4Question();
    } else if (id == 0) {
      return DuolingoWritingPractice1Question(
          practiceController: practiceController);
    } else if (id == 0) {
      return DuolingoWritingPractice2Question(
          practiceController: practiceController);
    } else if (id == 24) {
      return DuolingoWritingPractice3Question(
          practiceController: practiceController);
    } else if (id == 0) {
      return DuolingoWritingPractice4Question(
          practiceController: practiceController);
    } else if (id == 28) {
      return DuolingoListeningPractice1Question(
          practiceController: practiceController);
    } else if (id == 0) {
      return DuolingoListeningPractice2Question(
          practiceController: practiceController);
    } else if (id == 29) {
      return const DuolingoListeningPractice3Question();
    } else if (id == 0) {
      return DuolingoListeningPractice4Question(
          practiceController: practiceController);
    }

    return Container();
  }

  Widget _buildAnswerScreen(CoursePracticeViewModel viewModel) {
    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 12) {
      return const DuolingoSpeakingPractice1Answer();
    } else if (id == 13) {
      return const DuolingoSpeakingPractice2Answer();
    } else if (id == 0) {
      return const DuolingoSpeakingPractice3Answer();
    } else if (id == 14) {
      return const DuolingoSpeakingPractice4Answer();
    } else if (id == 0) {
      return Container();
    } else if (id == 0) {
      return DuolingoWritingPractice2Answer(
          practiceController: practiceController);
    } else if (id == 0) {
      return Container();
    } else if (id == 0) {
      return Container();
    } else if (id == 0) {
      return Container();
    } else if (id == 0) {
      return Container();
    }

    return Container();
  }

  Widget _buildReviewScreen(CoursePracticeViewModel viewModel) {
    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 12) {
      return const DuolingoSpeakingPractice1Review();
    } else if (id == 13) {
      return const DuolingoSpeakingPractice2Review();
    } else if (id == 0) {
      return const DuolingoSpeakingPractice3Review();
    } else if (id == 14) {
      return const DuolingoSpeakingPractice4Review();
    } else if (id == 0) {
      return DuolingoWritingPractice1Review(
          practiceController: practiceController);
    } else if (id == 0) {
      return DuolingoWritingPractice2Review(
          practiceController: practiceController);
    } else if (id == 24) {
      return DuolingoWritingPractice3Review(
          practiceController: practiceController);
    } else if (id == 0) {
      return DuolingoWritingPractice4Review(
          practiceController: practiceController);
    } else if (id == 28) {
      return DuolingoListeningPractice1Review(
          practiceController: practiceController);
    } else if (id == 0) {
      return DuolingoListeningPractice2Review(
          practiceController: practiceController);
    }else if (id == 29) {
      return const DuolingoListeningPractice3Review();
    }

    return Container();
  }

  @override
  void onViewModelReady(CoursePracticeViewModel viewModel) async {
    syncFormWithViewModel(viewModel);
    await viewModel.getCoursePractices(id: id, practice: practice);
    super.onViewModelReady(viewModel);
  }

  @override
  CoursePracticeViewModel viewModelBuilder(BuildContext context) =>
      CoursePracticeViewModel();

  @override
  Widget builder(
    BuildContext context,
    CoursePracticeViewModel viewModel,
    Widget? child,
  ) =>
      _buildPracticeScreensWrapper(context: context, viewModel: viewModel);

  Widget _buildPracticeScreensWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, data) {
            if (!didPop) {
              Future.microtask(() async =>
                  await _showSheet(context: context, viewModel: viewModel));
            }
          },
          child: _buildScaffoldWrapper(viewModel));

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildScaffoldWrapper(CoursePracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildBodyState(viewModel),
      );

  Widget _buildBodyState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.coursePractice)
          ? const PageLoadingIndicator()
          : viewModel.practices.isEmpty || viewModel.questions.isEmpty
              ? _buildPageLoadingIndicator(viewModel)
              : _buildBody(viewModel);

  Widget _buildPageLoadingIndicator(CoursePracticeViewModel viewModel) =>
      PracticeLoadingScreen(
        isLoading: viewModel.busy(StateObjects.coursePractice),
        onTap: () async =>
            await viewModel.getCoursePractices(id: id, practice: practice),
        onPop: viewModel.practices.isEmpty || viewModel.questions.isEmpty
            ? viewModel.pop
            : null,
        isEmpty: viewModel.practices.isEmpty || viewModel.questions.isEmpty,
      );

  Widget _buildBody(CoursePracticeViewModel viewModel) => IndexedStack(
      index: viewModel.currentPage, children: _buildBodyChildren(viewModel));

  List<Widget> _buildBodyChildren(CoursePracticeViewModel viewModel) => [
        if (practice != CoursePractices.lesson)
          _buildDuolingoAssessmentsScreen(),
        _buildQuestionSetView(viewModel)
      ];

  Widget _buildQuestionSetView(CoursePracticeViewModel viewModel) =>
      PageView.builder(
        itemCount: viewModel.questions.length,
        controller: viewModel.questionController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (cotext, index) => _buildQuestionView(
            index: index + 1,
            viewModel: viewModel,
            question: viewModel.questions[index]),
      );

  Widget _buildQuestionView(
          {required int index,
          required CourseQuestion question,
          required CoursePracticeViewModel viewModel}) =>
      PageView(
        controller: viewModel.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _buildScreens(
            index: index, viewModel: viewModel, question: question),
      );

  List<Widget> _buildScreens(
          {required int index,
          required CourseQuestion question,
          required CoursePracticeViewModel viewModel}) =>
      [
        _buildDuolingoIntroScreen(viewModel),
        _buildDuolingoQuestionScreen(viewModel),
        if (viewModel.questions[viewModel.currentQuestion]
                    .questionTypeDefinitionId !=
                28 &&
            viewModel.questions[viewModel.currentQuestion]
                    .questionTypeDefinitionId !=
                24 &&
            viewModel.questions[viewModel.currentQuestion]
                    .questionTypeDefinitionId !=
                29)
          _buildDuolingoAnswerScreen(viewModel),
        _buildDuolingoReviewScreen(viewModel),
        // _buildDuolingoRetakeScreen(viewModel),
        _buildDuolingoFinishScreen(viewModel),
      ];

  Widget _buildDuolingoAssessmentsScreen() => const DuolingoPracticesScreens();

  Widget _buildDuolingoIntroScreen(CoursePracticeViewModel viewModel) =>
      DuolingoIntroScreen(
          practiceController: practiceController,
          type: viewModel.selectedQuestionParam['type'],
          title: viewModel.selectedQuestionParam['intro_title'],
          subtitle: viewModel.selectedQuestionParam['intro_subtitle']);

  Widget _buildDuolingoQuestionScreen(CoursePracticeViewModel viewModel) =>
      _buildQuestionScreen(viewModel);

  Widget _buildDuolingoAnswerScreen(CoursePracticeViewModel viewModel) =>
      _buildAnswerScreen(viewModel);

  Widget _buildDuolingoReviewScreen(CoursePracticeViewModel viewModel) =>
      _buildReviewScreen(viewModel);

  Widget _buildDuolingoRetakeScreen(CoursePracticeViewModel viewModel) =>
      DuolingoRetakeScreen(
          title: viewModel.selectedQuestionParam['outro_title'],
          subtitle: viewModel.selectedQuestionParam['outro_subtitle']);

  Widget _buildDuolingoFinishScreen(CoursePracticeViewModel viewModel) =>
      DuolingoFinishScreen(
          title: viewModel.selectedQuestionParam['outro_title'],
          subtitle: viewModel.selectedQuestionParam['outro_subtitle']);
}
