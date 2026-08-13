import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/models/practice_question.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_listening_practice_1_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_listening_practice_1_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_listening_practice_2_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_listening_practice_4_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_listening_practice_4_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/course_practices_screens.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_finish_screen.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_intro_screen.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_listening_practice_2_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_reading_practice_1_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_reading_practice_2_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_reading_practice_3_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_reading_practice_3_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_reading_practice_4_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_reading_practice_5_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_reading_practice_6_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_reading_practice_7_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_reading_practice_7_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_reading_practice_8_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_reading_practice_8_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_retake_screen.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_speaking_practice_1_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_speaking_practice_1_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_speaking_practice_1_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_speaking_practice_2_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_speaking_practice_2_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_speaking_practice_2_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_speaking_practice_3_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_speaking_practice_3_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_speaking_practice_3_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_speaking_practice_4_preparation.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_speaking_practice_4_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_speaking_practice_4_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_writing_practice_1_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_writing_practice_1_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_writing_practice_2_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_writing_practice_2_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_writing_practice_2_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_writing_practice_3_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_writing_practice_3_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_writing_practice_4_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/duolingo_screens/duolingo_writing_practice_4_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_finish_screen.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_listening_practice_1_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_listening_practice_3_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_listening_practice_4_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_listening_section_intro.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_reading_practice_10_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_reading_practice_3_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_reading_practice_7_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_intro_screen.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_reading_practice_8_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_reading_practice_9_question.dart'
    hide IeltsListeningPractice8Question;
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_reading_section_intro.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_speaking_practice_1_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_speaking_practice_2_answer.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_speaking_practice_2_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_speaking_practice_2_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_speaking_practice_3_review.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_speaking_practice_4_variant.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_listening_practice_6_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_listening_practice_8_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_writing_practice_1_question.dart';
import 'package:yimaru_app/ui/views/course_practice/screens/ielts_screens/ielts_writing_practice_1_review.dart';

import '../../common/app_colors.dart';
import '../../common/translations/locale_keys.g.dart';
import '../../common/validators/form_validator.dart';
import '../../widgets/cancel_practice_sheet.dart';
import '../../widgets/page_loading_indicator.dart';
import '../../widgets/practice_loading_screen.dart';
import 'course_practice_view.form.dart';
import 'course_practice_viewmodel.dart';
import 'screens/duolingo_screens/duolingo_listening_practice_3_variant.dart';
import 'screens/ielts_screens/ielts_listening_practice_10_question.dart';
import 'screens/ielts_screens/ielts_listening_practice_5_question.dart';
import 'screens/ielts_screens/ielts_listening_practice_7_question.dart';
import 'screens/ielts_screens/ielts_reading_practice_2_question.dart';
import 'screens/ielts_screens/ielts_listening_practice_2_question.dart';
import 'screens/ielts_screens/ielts_listening_practice_9_question.dart';
import 'screens/ielts_screens/ielts_reading_practice_1_question.dart';
import 'screens/ielts_screens/ielts_reading_practice_4_question.dart';
import 'screens/ielts_screens/ielts_reading_practice_5_question.dart';
import 'screens/ielts_screens/ielts_reading_practice_6_question.dart';
import 'screens/ielts_screens/ielts_speaking_practice_1_review.dart';
import 'screens/ielts_screens/ielts_speaking_practice_3_answer.dart';
import 'screens/ielts_screens/ielts_speaking_practice_3_question.dart';
import 'screens/ielts_screens/ielts_speaking_practice_4_review.dart';
import 'screens/ielts_screens/ielts_writing_practice_2_question.dart';
import 'screens/ielts_screens/ielts_writing_practice_2_review.dart';

@FormView(fields: [
  FormTextField(name: 'practice', validator: FormValidator.validateForm),
])
class CoursePracticeView extends StackedView<CoursePracticeViewModel>
    with $CoursePracticeView {
  final int id;
  final SubscriptionType type;
  final CoursePractices practice;

  const CoursePracticeView(
      {Key? key, required this.id, required this.type, required this.practice})
      : super(key: key);

  String _getErrorMessages() {
    if (practice == CoursePractices.courseCatalog) {
      return LocaleKeys.no_practice_available_course.tr();
    } else if (practice == CoursePractices.unit) {
      return LocaleKeys.no_practice_available_unit.tr();
    } else {
      return LocaleKeys.no_practice_available_lesson.tr();
    }
  }

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
    if (id == 12 /*Duolingo - Speak about the photo*/) {
      return const DuolingoSpeakingPractice1Question();
    } else if (id == 13 /*Duolingo - Read then speak*/) {
      return const DuolingoSpeakingPractice2Question();
    } else if (id == 36 /*Duolingo - Speaking sample*/) {
      return const DuolingoSpeakingPractice3Question();
    } else if (id == 14 /*Duolingo - Interactive speaking*/) {
      return const DuolingoSpeakingPractice4Preparation();
    } else if (id == 22 /*Duolingo - Write about the photo*/) {
      return DuolingoWritingPractice1Question(
          practiceController: practiceController);
    } else if (id == 23 /*Duolingo - Writing sample*/) {
      return DuolingoWritingPractice2Question(
          practiceController: practiceController);
    } else if (id == 24 /*Duolingo - Interactive writing part 1*/) {
      return DuolingoWritingPractice3Question(
          practiceController: practiceController);
    } else if (id == 25 /*Duolingo - Interactive writing part 2*/) {
      return DuolingoWritingPractice4Question(
          practiceController: practiceController);
    } else if (id == 28 /*Duolingo - Listen and type*/) {
      return DuolingoListeningPractice1Variant(
          practiceController: practiceController);
    } else if (id == 56 /*Duolingo - Interactive listening part 1*/) {
      return const DuolingoListeningPractice2Question();
    } else if (id == 29 /*Duolingo - Interactive listening part 2*/) {
      return const DuolingoListeningPractice3Variant();
    } else if (id == 57 /*Duolingo - Interactive listening part 3*/) {
      return DuolingoListeningPractice4Question(
          practiceController: practiceController);
    } else if (id == 49 /*Duolingo - Read and select*/) {
      return const DuolingoReadingPractice1Variant();
    } else if (id == 3 /*Duolingo - Fill in the blank*/) {
      return const DuolingoReadingPractice2Variant();
    } else if (id == 51 /*Duolingo - Interactive reading - complete the sentence*/) {
      return const DuolingoReadingPractice3Question();
    } else if (id == 52 /*Duolingo - Interactive reading - complete the passage*/) {
      return const DuolingoReadingPractice4Question();
    } else if (id == 53 /*Duolingo - Interactive reading - identify the idea*/) {
      return const DuolingoReadingPractice5Question();
    } else if (id == 54 /*Duolingo - Interactive reading - title the passage*/) {
      return const DuolingoReadingPractice6Question();
    } else if (id == 55 /*Duolingo - Interactive reading - highlight the answer*/) {
      return const DuolingoReadingPractice7Variant();
    } else if (id == 50 /*Duolingo - Read and complete*/) {
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
    if (id == 12 /*Duolingo - Speak about the photo*/) {
      return const DuolingoSpeakingPractice1Answer();
    } else if (id == 13 /*Duolingo - Read then speak*/) {
      return const DuolingoSpeakingPractice2Answer();
    } else if (id == 36 /*Duolingo - Speaking sample*/) {
      return const DuolingoSpeakingPractice3Answer();
    } else if (id == 14 /*Duolingo - Interactive speaking*/) {
      return const DuolingoSpeakingPractice4Variant();
    } else if (id == 23 /*Duolingo - Writing sample*/) {
      return DuolingoWritingPractice2Answer(
          practiceController: practiceController);
    } else {
      return Container();
    }
  }

  bool _buildDuolingoReviewScreenCondition(CoursePracticeViewModel viewModel) =>
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
    if (id == 12 /*Duolingo - Speak about the photo*/) {
      return const DuolingoSpeakingPractice1Review();
    } else if (id == 13 /*Duolingo - Read then speak*/) {
      return const DuolingoSpeakingPractice2Review();
    } else if (id == 36 /*Duolingo - Speaking sample*/) {
      return const DuolingoSpeakingPractice3Review();
    } else if (id == 14 /*Duolingo - Interactive speaking*/) {
      return const DuolingoSpeakingPractice4Review();
    } else if (id == 22 /*Duolingo - Write about the photo*/) {
      return DuolingoWritingPractice1Review(
          practiceController: practiceController);
    } else if (id == 23 /*Duolingo - Writing sample*/) {
      return DuolingoWritingPractice2Review(
          practiceController: practiceController);
    } else if (id == 24 /*Duolingo - Interactive writing part 1*/) {
      return DuolingoWritingPractice3Review(
          practiceController: practiceController);
    } else if (id == 25 /*Duolingo - Interactive writing part 2*/) {
      return DuolingoWritingPractice4Review(
          practiceController: practiceController);
    } else if (id == 28 /*Duolingo - Listen and type*/) {
      return const DuolingoListeningPractice1Review();
    } else if (id == 56 /*Duolingo - Interactive listening part 1*/) {
      return const DuolingoListeningPractice2Review();
    } else if (id == 57 /*Duolingo - Interactive listening part 3*/) {
      return DuolingoListeningPractice4Review(
          practiceController: practiceController);
    } else if (id == 51 /*Duolingo - Interactive reading - complete the sentence*/) {
      return const DuolingoReadingPractice3Review();
    } else if (id == 55 /*Duolingo - Interactive reading - highlight the answer*/) {
      return const DuolingoReadingPractice7Review();
    } else if (id == 50 /*Duolingo - Read and complete*/) {
      return const DuolingoReadingPractice8Review();
    }

    return Container();
  }

  bool _buildIeltsSectionScreenCondition(CoursePracticeViewModel viewModel) =>
      viewModel
              .questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          1  ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          31 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          33 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          34 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          40 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          42 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          43 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          46 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          47 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          48 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          58 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          59 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          60 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          61 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          62 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          62 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          63 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          64 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          65 ||
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          68||
          viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
              69;

  bool _buildIeltsIntroScreenCondition(CoursePracticeViewModel viewModel) =>
      viewModel
              .questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          1 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          31 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          33 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          34 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          40 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          42 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          43 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          46 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          47 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          48 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          58 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          59 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          60 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          61 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          62 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          63 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          64 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          65 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          68 &&
          viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
              69;

  Widget? _buildIeltsIntroScreenWrapper(CoursePracticeViewModel viewModel) {
    if (_buildIeltsSectionScreenCondition(viewModel)) {
      if (viewModel.stimulusBlockKey != null) {
        if (viewModel.isSectionStart) {
          if (viewModel.questions[viewModel.currentQuestion].stimulusBlockKey ==
              'listening-section-1') {
            return const IeltsListeningSectionIntro(
                title: 'Listening - Section 1');
          } else if (viewModel
                  .questions[viewModel.currentQuestion].stimulusBlockKey ==
              'listening-section-2') {
            return const IeltsListeningSectionIntro(
                title: 'Listening - Section 2');
          } else if (viewModel
                  .questions[viewModel.currentQuestion].stimulusBlockKey ==
              'listening-section-3') {
            return const IeltsListeningSectionIntro(
                title: 'Listening - Section 3');
          } else if (viewModel
                  .questions[viewModel.currentQuestion].stimulusBlockKey ==
              'listening-section-4') {
            return const IeltsListeningSectionIntro(
                title: 'Listening - Section 4');
          } else if (viewModel
                  .questions[viewModel.currentQuestion].stimulusBlockKey ==
              'reading-section-1') {
            return const IeltsReadingSectionIntro();
          } else if (viewModel
                  .questions[viewModel.currentQuestion].stimulusBlockKey ==
              'reading-section-2') {
            return const IeltsReadingSectionIntro();
          } else if (viewModel
                  .questions[viewModel.currentQuestion].stimulusBlockKey ==
              'reading-section-3') {
            return const IeltsReadingSectionIntro();
          }
          return Container();
        } else {
          return null;
        }
      }
      return _buildIeltsIntroScreen(viewModel);
    } else {
      return _buildIeltsIntroScreen(viewModel);
    }
  }

  Widget _buildIeltsQuestionScreen(CoursePracticeViewModel viewModel) {
    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 17 /*IELTS Speaking – Interview*/) {
      return const IeltsSpeakingPractice1Variant();
    } else if (id == 18 /*IELTS Speaking – Cue Card Part 1*/) {
      return const IeltsSpeakingPractice2Question();
    } else if (id == 20 /*IELTS Speaking – Cue Card Part 2*/) {
      return const IeltsSpeakingPractice3Question();
    } else if (id == 21 /*IELTS Speaking – Discussion*/) {
      return const IeltsSpeakingPractice4Variant();
    } else if (id == 26 /*IELTS Writing – Part 1*/) {
      return IeltsWritingPractice1Question(
          practiceController: practiceController);
    } else if (id == 27 /*IELTS Writing – Part 2*/) {
      return IeltsWritingPractice2Question(
          practiceController: practiceController);
    } else if (id == 40 /*IELTS Listening - Form completion*/) {
      return const IeltsListeningPractice1Question();
    } else if (id == 42 /*IELTS Listening - Note completion*/) {
      return const IeltsListeningPractice2Question();
    } else if (id == 69 /*IELTS Listening - Short Answer*/) {
      return const IeltsListeningPractice3Question();
    } else if (id == 43 /*IELTS Listening - Table completion*/) {
      return const IeltsListeningPractice4Question();
    } else if (id == 61 /*IELTS Listening - Map/Plan/Diagram Completion*/) {
      return const IeltsListeningPractice5Question();
    } else if (id == 31 /*IELTS Listening - Diagram labeling*/) {
      return const IeltsListeningPractice6Question();
    } else if (id == 62 /*IELTS Listening - Multiple choice*/) {
      return const IeltsListeningPractice7Question();
    } else if (id == 33 /*IELTS Listening - Matching*/) {
      return const IeltsListeningPractice8Question();
    } else if (id == 34 /*IELTS Listening - Summary completion*/) {
      return const IeltsListeningPractice9Question();
    } else if (id == 35 /*IELTS Listening - Sentence completion*/) {
      return const IeltsListeningPractice10Question();
    } else if (id == 46 /*IELTS Reading - Paragraph choice*/) {
      return const IeltsReadingPractice1Question();
    } else if (id == 58 /*IELTS Reading - Diagram Labeling*/) {
      return const IeltsReadingPractice2Question();
    } else if (id == 63 /*IELTS Reading - Summary completion*/) {
      return const IeltsReadingPractice3Question();
    } else if (id == 47 /*IELTS Reading - Sentence Ending Matching*/) {
      return const IeltsReadingPractice4Question();
    } else if (id == 48 /*IELTS Reading - True / False / Not Given*/) {
      return const IeltsReadingPractice5Question();
    } else if (id == 64 /*IELTS Reading - Multiple choice*/) {
      return const IeltsReadingPractice6Question();
    } else if (id == 59 /*IELTS Reading - Yes / No / Not Given*/) {
      return const IeltsReadingPractice7Question();
    } else if (id == 60 /*IELTS Reading - Heading Matching*/) {
      return const IeltsReadingPractice8Question();
    } else if (id == 65 /*IELTS Reading - Feature Matching*/) {
      return const IeltsReadingPractice9Question();
    } else if (id == 68 /*IELTS Reading - Table completion*/) {
      return const IeltsReadingPractice10Question();
    }
    return Container();
  }

  bool _buildIeltsAnswerScreenCondition(CoursePracticeViewModel viewModel) =>
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          1 &&

      // Original
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          26 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          27
      // Original
      &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          31 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          33 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          34 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          35 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          40 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          42 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          43 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          46 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          47 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          48 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          58 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          59 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          60 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          61 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          62 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          63 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          64 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          65 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          68 &&viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
  69;

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

  bool _buildIeltsReviewScreenCondition(CoursePracticeViewModel viewModel) =>
      viewModel
              .questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          1 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          31 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          33 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          34 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          35 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          40 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          42 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          43 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          46 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          47 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          48 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          58 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          59 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          60 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          61 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          62 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          63 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          64 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          65 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          68 &&
          viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
              69;

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

  bool _buildIeltsFinishScreenCondition(CoursePracticeViewModel viewModel) =>
      viewModel.isSectionEnd &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          43 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          46 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          47 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          48 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          58 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          59 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          60 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          63 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          64 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          65 &&
      viewModel.questions[viewModel.currentQuestion].questionTypeDefinitionId !=
          68;

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
        message: _getErrorMessages(),
        isEmpty: viewModel.practices.isEmpty,
        isLoading: viewModel.busy(StateObjects.coursePractice),
        onRetry: () async =>
            await viewModel.getCoursePractices(id: id, practice: practice),
        onPop: viewModel.practices.isEmpty || viewModel.questions.isEmpty
            ? viewModel.pop
            : null,
      );

  Widget _buildBody(CoursePracticeViewModel viewModel) => IndexedStack(
      index: viewModel.currentPage, children: _buildBodyChildren(viewModel));

  List<Widget> _buildBodyChildren(CoursePracticeViewModel viewModel) =>
      [_buildCoursePracticesScreen(viewModel), _buildPracticesView(viewModel)];

  Widget _buildCoursePracticesScreen(CoursePracticeViewModel viewModel) =>
      CoursePracticesScreens(
          practiceController: practiceController, type: type);

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
        if (_buildIeltsIntroScreenWrapper(viewModel) != null)
          _buildIeltsIntroScreenWrapper(viewModel)!,

/*        if (_buildIeltsIntroScreenCondition(viewModel))
          _buildIeltsIntroScreen(viewModel),*/
        _buildIeltsQuestionScreen(viewModel),
        if (_buildIeltsAnswerScreenCondition(viewModel))
          _buildIeltsAnswerScreen(viewModel),
        if (_buildIeltsReviewScreenCondition(viewModel))
          _buildIeltsReviewScreen(viewModel),
        if (_buildIeltsFinishScreenCondition(viewModel))
          _buildIeltsFinishScreenWrapper(viewModel),
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

  Widget _buildIeltsFinishScreenWrapper(CoursePracticeViewModel viewModel) =>
      IeltsFinishScreen(
          title: viewModel.selectedQuestionParam['outro_title'],
          subtitle: viewModel.selectedQuestionParam['outro_subtitle']);
}
