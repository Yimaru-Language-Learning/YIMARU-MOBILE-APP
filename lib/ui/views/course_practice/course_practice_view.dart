import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/models/practice_question.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_listening_practice_1_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_listening_practice_1_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_listening_practice_2_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_listening_practice_4_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_listening_practice_4_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/course_practices_screens.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_finish_screen.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_intro_screen.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_listening_practice_2_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_listening_practice_3_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_1_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_2_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_2_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_2_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_3_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_3_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_4_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_5_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_6_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_7_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_7_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_7_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_8_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_8_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_reading_practice_8_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_retake_screen.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_1_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_1_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_1_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_2_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_2_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_2_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_3_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_3_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_3_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_4_preparation.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_4_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_speaking_practice_4_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_writing_practice_1_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_writing_practice_1_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_writing_practice_2_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_writing_practice_2_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_writing_practice_2_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_writing_practice_3_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_writing_practice_3_review.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_writing_practice_4_question.dart';
import 'package:yimaru_app/ui/views/course_practice/duolingo_screens/duolingo_writing_practice_4_review.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_listening_practice_1_question.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_listening_practice_3_question.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_reading_practice_6_question.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_speaking_practice_1_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_speaking_practice_1_question.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_intro_screen.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_speaking_practice_1_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_speaking_practice_2_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_speaking_practice_2_question.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_speaking_practice_2_review.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_speaking_practice_3_review.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_speaking_practice_4_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_speaking_practice_4_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_speaking_practice_6_question.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_speaking_practice_8_question.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_writing_practice_1_question.dart';
import 'package:yimaru_app/ui/views/course_practice/ielts_screens/ielts_writing_practice_1_review.dart';

import '../../common/app_colors.dart';
import '../../common/validators/form_validator.dart';
import '../../widgets/cancel_practice_sheet.dart';
import '../../widgets/page_loading_indicator.dart';
import '../../widgets/practice_loading_screen.dart';
import 'course_practice_view.form.dart';
import 'course_practice_viewmodel.dart';
import 'duolingo_screens/duolingo_listening_practice_3_variant.dart';
import 'ielts_screens/ielts_reading_practice_2_question.dart';
import 'ielts_screens/ielts_listening_practice_2_question.dart';
import 'ielts_screens/ielts_listening_practice_9_question.dart';
import 'ielts_screens/ielts_reading_practice_1_question.dart';
import 'ielts_screens/ielts_reading_practice_3_question.dart';
import 'ielts_screens/ielts_reading_practice_4_question.dart';
import 'ielts_screens/ielts_reading_practice_5_question.dart';
import 'ielts_screens/ielts_speaking_practice_1_review.dart';
import 'ielts_screens/ielts_speaking_practice_3_answer.dart';
import 'ielts_screens/ielts_speaking_practice_3_question.dart';
import 'ielts_screens/ielts_speaking_practice_4_question.dart';
import 'ielts_screens/ielts_speaking_practice_4_review.dart';
import 'ielts_screens/ielts_writing_practice_2_question.dart';
import 'ielts_screens/ielts_writing_practice_2_review.dart';

@FormView(fields: [
  FormTextField(name: 'practice', validator: FormValidator.validateForm),
])
class CoursePracticeView extends StackedView<CoursePracticeViewModel>
    with $CoursePracticeView {
  final int id;
  final CoursePractices practice;

  const CoursePracticeView({Key? key, required this.id, required this.practice})
      : super(key: key);

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.goBack();
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

  Widget _buildDuolingoQuestionScreen(CoursePracticeViewModel viewModel) {
    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 12 /*Speak about the photo*/) {
      return const DuolingoSpeakingPractice1Question();
    } else if (id == 13 /*Read then speak*/) {
      return const DuolingoSpeakingPractice2Question();
    } else if (id == 36 /*Speaking sample*/) {
      return const DuolingoSpeakingPractice3Question();
    } else if (id == 14 /*Interactive speaking*/) {
      return const DuolingoSpeakingPractice4Preparation();
    } else if (id == 22 /*Write about the photo*/) {
      return DuolingoWritingPractice1Question(
          practiceController: practiceController);
    } else if (id == 23 /*Writing sample*/) {
      return DuolingoWritingPractice2Question(
          practiceController: practiceController);
    } else if (id == 24 /*Interactive writing part 1*/) {
      return DuolingoWritingPractice3Question(
          practiceController: practiceController);
    } else if (id == 25 /*Interactive writing part 2*/) {
      return DuolingoWritingPractice4Question(
          practiceController: practiceController);
    } else if (id == 28 /*Listen and type*/) {
      return DuolingoListeningPractice1Variant(
          practiceController: practiceController);
    } else if (id == 56 /*Interactive listening part 1*/) {
      return const DuolingoListeningPractice2Question();
    } else if (id == 29 /*Interactive listening part 2*/) {
      return const DuolingoListeningPractice3Variant();
    } else if (id == 57 /*Interactive listening part 3*/) {
      return DuolingoListeningPractice4Question(
          practiceController: practiceController);
    } else if (id == 49 /*Read and select*/) {
      return const DuolingoReadingPractice1Variant();
    } else if (id == 3 /*Fill in the blank*/) {
      return Container();
      return const DuolingoReadingPractice2Variant();
    } else if (id == 51 /*Interactive reading - complete the sentence*/) {
      return const DuolingoReadingPractice3Question();
    } else if (id == 52 /*Interactive reading - complete the passage*/) {
      return const DuolingoReadingPractice4Question();
    } else if (id == 53 /*Interactive reading - identify the idea*/) {
      return const DuolingoReadingPractice5Question();
    } else if (id == 54 /*Interactive reading - title the passage*/) {
      return const DuolingoReadingPractice6Question();
    } else if (id == 55 /*Interactive reading - highlight the answer*/) {
      return const DuolingoReadingPractice7Variant();
    } else if (id == 50 /*Read and complete*/) {
      return DuolingoReadingPractice8Variant(
          practiceController: practiceController);
    }

    return Container();
  }

  bool _buildDuolingoAnswerScreenCondition(CoursePracticeViewModel viewModel) =>
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          3 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          22 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          24 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          25 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          28 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          29 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          49 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          50 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          51 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          52 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          53 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          54 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          55 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          56 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          57;

  Widget _buildDuolingoAnswerScreen(CoursePracticeViewModel viewModel) {
    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 12 /*Speak about the photo*/) {
      return const DuolingoSpeakingPractice1Answer();
    } else if (id == 13 /*Read then speak*/) {
      return const DuolingoSpeakingPractice2Answer();
    } else if (id == 36 /*Speaking sample*/) {
      return const DuolingoSpeakingPractice3Answer();
    } else if (id == 14 /*Interactive speaking*/) {
      return const DuolingoSpeakingPractice4Variant();
    } else if (id == 23 /*Writing sample*/) {
      return DuolingoWritingPractice2Answer(
          practiceController: practiceController);
    } else {
      return Container();
    }
  }

  bool _buildDuolingoReviewScreenCondition(
          CoursePracticeViewModel viewModel) =>
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          3 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          29 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          49 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          52 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          53 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          54;

  Widget _buildDuolingoReviewScreen(CoursePracticeViewModel viewModel) {
    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 12 /*Speak about the photo*/) {
      return const DuolingoSpeakingPractice1Review();
    } else if (id == 13 /*Read then speak*/) {
      return const DuolingoSpeakingPractice2Review();
    } else if (id == 36 /*Speaking sample*/) {
      return const DuolingoSpeakingPractice3Review();
    } else if (id == 14 /*Interactive speaking*/) {
      return const DuolingoSpeakingPractice4Review();
    } else if (id == 22 /*Write about the photo*/) {
      return DuolingoWritingPractice1Review(
          practiceController: practiceController);
    } else if (id == 23 /*Writing sample*/) {
      return DuolingoWritingPractice2Review(
          practiceController: practiceController);
    } else if (id == 24 /*Interactive writing part 1*/) {
      return DuolingoWritingPractice3Review(
          practiceController: practiceController);
    } else if (id == 25 /*Interactive writing part 2*/) {
      return DuolingoWritingPractice4Review(
          practiceController: practiceController);
    } else if (id == 28 /*Listen and type*/) {
      return const DuolingoListeningPractice1Review();
    } else if (id == 56 /*Interactive listening part 1*/) {
      return const DuolingoListeningPractice2Review();
    } else if (id == 57 /*Interactive listening part 3*/) {
      return DuolingoListeningPractice4Review(
          practiceController: practiceController);
    }
    /*  else if (id == 3 */ /*Fill in the blank*/ /*) {
      return const DuolingoReadingPractice2Review();
    } */
    else if (id == 51 /*Interactive reading - complete the sentence*/) {
      return const DuolingoReadingPractice3Review();
    } else if (id == 55 /*Interactive reading - highlight the answer*/) {
      return const DuolingoReadingPractice7Review();
    } else if (id == 50 /*Read and complete*/) {
      return const DuolingoReadingPractice8Review();
    }

    return Container();
  }

  Widget _buildIeltsIntroScreenWrapper(CoursePracticeViewModel viewModel) {
    if (viewModel.questions[viewModel.currentQuestion]
                .questionTypeDefinitionId !=
            1 &&
        viewModel.questions[viewModel.currentQuestion]
                .questionTypeDefinitionId !=
            4 &&
        viewModel.questions[viewModel.currentQuestion]
                .questionTypeDefinitionId !=
            31 &&
        viewModel.questions[viewModel.currentQuestion]
                .questionTypeDefinitionId !=
            33 &&
        viewModel.questions[viewModel.currentQuestion]
                .questionTypeDefinitionId !=
            34 &&
        viewModel.questions[viewModel.currentQuestion]
                .questionTypeDefinitionId !=
            40 &&
        viewModel.questions[viewModel.currentQuestion]
                .questionTypeDefinitionId !=
            42 &&
        viewModel.questions[viewModel.currentQuestion]
                .questionTypeDefinitionId !=
            46 &&
        viewModel.questions[viewModel.currentQuestion]
                .questionTypeDefinitionId !=
            47 &&
        viewModel.questions[viewModel.currentQuestion]
                .questionTypeDefinitionId !=
            48 &&
        viewModel.questions[viewModel.currentQuestion]
                .questionTypeDefinitionId !=
            58 &&
        viewModel.questions[viewModel.currentQuestion]
                .questionTypeDefinitionId !=
            59) {
      return _buildIeltsIntroScreen(viewModel);
    }
    return Container();
  }

  Widget _buildIeltsQuestionScreen(CoursePracticeViewModel viewModel) {
    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 17 /*IELTS Speaking – Interview*/) {
      return const IeltsSpeakingPractice1Question();
    } else if (id == 18 /*IELTS Speaking – Cue Card Part 1*/) {
      return const IeltsSpeakingPractice2Question();
    } else if (id == 20 /*IELTS Speaking – Cue Card Part 2*/) {
      return const IeltsSpeakingPractice3Question();
    } else if (id == 21 /*IELTS Speaking – Discussion*/) {
      return const IeltsSpeakingPractice4Question();
    } else if (id == 26 /*IELTS Writing – Part 1*/) {
      return IeltsWritingPractice1Question(
          practiceController: practiceController);
    } else if (id == 27 /*IELTS Writing – Part 2*/) {
      return IeltsWritingPractice2Question(
          practiceController: practiceController);
    } else if (id == 40 /*Form completion*/) {
      return IeltsListeningPractice1Question(
          practiceController: practiceController);
    } else if (id == 42 /*Note completion*/) {
      return IeltsListeningPractice2Question(
          practiceController: practiceController);
    } else if (id == 4 /*Short Answer*/) {
      return IeltsListeningPractice3Question(
          practiceController: practiceController);
    } else if (id == 0 /*Table completion*/) {
      return Container();
    } else if (id == 0 /*Diagram completion*/) {
      return Container();
    } else if (id == 31 /*Diagram labeling*/) {
      return const IeltsSpeakingPractice6Question();
    } else if (id == 0 /*Multiple choice*/) {
      return Container();
    } else if (id == 33 /*Matching*/) {
      return const IeltsSpeakingPractice8Question();
    } else if (id == 34 /*Summary completion*/) {
      return const IeltsListeningPractice9Question();
    } else if (id == 0 /*Sentence completion*/) {
      return Container();
    } else if (id == 46 /*Paragraph choice*/) {
      return const IeltsReadingPractice1Question();
    } else if (id == 58 /*Reading diagram labeling*/) {
      return const IeltsReadingPractice2Question();
    } else if (id == 47 /*Sentence Ending Matching*/) {
      return const IeltsReadingPractice3Question();
    } else if (id == 48 /*True / False / Not Given*/) {
      return const IeltsReadingPractice4Question();
    } else if (id == 1 /*Multiple choice*/) {
      return const IeltsReadingPractice5Question();
    } else if (id == 59 /*Yes / No / Not Given*/) {
      return const IeltsReadingPractice6Question();
    }
    return Container();
  }

  bool _buildIeltsAnswerScreenCondition(CoursePracticeViewModel viewModel) =>
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          26 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          27;

  Widget _buildIeltsAnswerScreen(CoursePracticeViewModel viewModel) {
    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 17 /*IELTS Speaking – Interview*/) {
      return const IeltsSpeakingPractice1Variant();
    } else if (id == 18 /*IELTS Speaking – Cue Card Part 1*/) {
      return const IeltsSpeakingPractice2Answer();
    } else if (id == 20 /*IELTS Speaking – Cue Card Part 2*/) {
      return const IeltsSpeakingPractice3Answer();
    } else if (id == 21 /*IELTS Speaking – Discussion*/) {
      return const IeltsSpeakingPractice4Variant();
    } else {
      return Container();
    }
  }

  Widget _buildIeltsReviewScreen(CoursePracticeViewModel viewModel) {
    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 17 /*IELTS Speaking – Interview*/) {
      return const IeltsSpeakingPractice1Review();
    } else if (id == 18 /*IELTS Speaking – Cue Card Part 1*/) {
      return const IeltsSpeakingPractice2Review();
    } else if (id == 20 /*IELTS Speaking – Cue Card Part 2*/) {
      return const IeltsSpeakingPractice3Review();
    } else if (id == 21 /*IELTS Speaking – Discussion*/) {
      return const IeltsSpeakingPractice4Review();
    } else if (id == 26 /*IELTS Writing – Part 1*/) {
      return const IeltsWritingPractice1Review();
    } else if (id == 27 /*IELTS Writing – Part 2*/) {
      return const IeltsWritingPractice2Review();
    } else {
      return Container();
    }
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
          : viewModel.practices.isEmpty
              ? _buildPageLoadingIndicator(viewModel)
              : _buildBody(viewModel);

  Widget _buildPageLoadingIndicator(CoursePracticeViewModel viewModel) =>
      PracticeLoadingScreen(
        isEmpty: viewModel.practices.isEmpty,
        isLoading: viewModel.busy(StateObjects.coursePractice),
        onTap: () async =>
            await viewModel.getCoursePractices(id: id, practice: practice),
        onPop: viewModel.practices.isEmpty || viewModel.questions.isEmpty
            ? viewModel.pop
            : null,
      );

  Widget _buildBody(CoursePracticeViewModel viewModel) => IndexedStack(
      index: viewModel.currentPage, children: _buildBodyChildren(viewModel));

  List<Widget> _buildBodyChildren(CoursePracticeViewModel viewModel) =>
      [_buildCoursePracticesScreen(), _buildPracticesView(viewModel)];

  Widget _buildCoursePracticesScreen() =>
      CoursePracticesScreens(practiceController: practiceController);

  Widget _buildPracticesView(CoursePracticeViewModel viewModel) =>
      PageView.builder(
        itemCount: viewModel.questions.length,
        controller: viewModel.questionsController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (cotext, index) => _buildQuestionView(
          index: index + 1,
          viewModel: viewModel,
          question: viewModel.questions[index],
        ),
      );

  Widget _buildQuestionView(
          {required int index,
          required PracticeQuestion question,
          required CoursePracticeViewModel viewModel}) =>
      PageView(
        controller: viewModel.questionController,
        physics: const NeverScrollableScrollPhysics(),
        children: _buildQuestionScreens(
            index: index, question: question, viewModel: viewModel),
      );

  List<Widget> _buildQuestionScreens(
          {required int index,
          required PracticeQuestion question,
          required CoursePracticeViewModel viewModel}) =>
      viewModel.selectedQuestionParam['type'] != CoursePracticeType.ielts
          ? _buildDuolingoScreens(
              index: index, viewModel: viewModel, question: question)
          : _buildIeltsScreens(
              index: index, viewModel: viewModel, question: question);

  List<Widget> _buildDuolingoScreens(
          {required int index,
          required PracticeQuestion question,
          required CoursePracticeViewModel viewModel}) =>
      [
        _buildDuolingoIntroScreen(viewModel),
        _buildDuolingoQuestionScreen(viewModel),
        if (_buildDuolingoAnswerScreenCondition(viewModel))
          _buildDuolingoAnswerScreen(viewModel),
        if (_buildDuolingoReviewScreenCondition(viewModel))
          _buildDuolingoReviewScreen(viewModel),
        // _buildDuolingoRetakeScreen(viewModel),
        _buildDuolingoFinishScreenWrapper(viewModel),
      ];

  Widget _buildDuolingoIntroScreen(CoursePracticeViewModel viewModel) =>
      DuolingoIntroScreen(
          practiceController: practiceController,
          type: viewModel.selectedQuestionParam['type'],
          title: viewModel.selectedQuestionParam['intro_title'],
          subtitle: viewModel.selectedQuestionParam['intro_subtitle']);

  Widget _buildDuolingoRetakeScreenWrapper(CoursePracticeViewModel viewModel) =>
      DuolingoRetakeScreen(
          title: viewModel.selectedQuestionParam['outro_title'],
          subtitle: viewModel.selectedQuestionParam['outro_subtitle']);

  Widget _buildDuolingoFinishScreenWrapper(CoursePracticeViewModel viewModel) =>
      DuolingoFinishScreen(
          title: viewModel.selectedQuestionParam['outro_title'],
          subtitle: viewModel.selectedQuestionParam['outro_subtitle']);

  // Ielts section
  List<Widget> _buildIeltsScreens(
          {required int index,
          required PracticeQuestion question,
          required CoursePracticeViewModel viewModel}) =>
      [
        _buildIeltsIntroScreenWrapper(viewModel),
        _buildIeltsQuestionScreen(viewModel),
        if (_buildIeltsAnswerScreenCondition(viewModel))
          _buildIeltsAnswerScreen(viewModel),
        _buildIeltsReviewScreen(viewModel),
      ];

  Widget _buildIeltsIntroScreen(CoursePracticeViewModel viewModel) =>
      IeltsIntroScreen(
        practiceController: practiceController,
        title: viewModel.selectedQuestionParam['title'],
        subtitle: viewModel.selectedQuestionParam['subtitle'],
        instructionSubtitle:
            viewModel.selectedQuestionParam['instruction_subtitle'],
        instructionTitle: viewModel.selectedQuestionParam['instruction_title'],
      );
}
