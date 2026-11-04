import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course_catalog.dart';
import 'package:yimaru_app/models/course_lesson.dart';
import 'package:yimaru_app/models/course_module.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/course_module/course_module_viewmodel.dart';

import 'package:yimaru_app/ui/common/enmus.dart';
import '../common/app_colors.dart';

const Map<int, String> _kProfAssets = {
  1: 'assets/images/09-english-for-professionals/lessons/01-finding-and-securing-the-right-job-for-you.svg',
  2: 'assets/images/09-english-for-professionals/lessons/02-self-assessments-and-understanding-job-advertisements.svg',
  3: 'assets/images/09-english-for-professionals/lessons/03-writing-your-cv-curriculum-vitae-or-resume.svg',
  4: 'assets/images/09-english-for-professionals/lessons/04-how-to-write-your-cover-letter.svg',
  5: 'assets/images/09-english-for-professionals/lessons/05-the-interview-attire-and-attitude.svg',
  6: 'assets/images/09-english-for-professionals/lessons/06-talking-about-yourself-personal-information-and-summary-of-skills-and-.svg',
  7: 'assets/images/09-english-for-professionals/lessons/07-talking-about-yourself-strengths-and-weaknesses.svg',
  8: 'assets/images/09-english-for-professionals/lessons/08-why-should-we-hire-you-and-do-you-have-any-questions-for-us.svg',
  9: 'assets/images/09-english-for-professionals/lessons/09-how-to-negotiate-your-salary.svg',
  10: 'assets/images/09-english-for-professionals/lessons/10-in-person-communication-with-your-colleagues-small-talk-work-collabora.svg',
  11: 'assets/images/09-english-for-professionals/lessons/11-in-person-communication-with-your-boss-small-talk-reports-and-complain.svg',
  12: 'assets/images/09-english-for-professionals/lessons/12-virtual-communication-phone-calls-email-and-video-conferences.svg',
};

const Map<int, String> _kProfAmharicTitles = {
  1: 'እርስዎ የሚፈልጉትን ትክክለኛ ሥራ ማግኘት',
  2: 'የራስ ግምገማዎች እና የሥራ ማስታወቂያዎችን መረዳት',
  3: 'ሲቪ (CV - ከሪኩለም ቪቴ) ወይም የሥራ ከንቲብ ማዘጋጀት',
  4: 'የሥራ ደብዳቤ (Cover Letter) እንዴት እንደሚጻፍ',
  5: 'ቃለ መጠይቅ (አለባበስ እና አመለካከት)',
  6: 'ስለ ራስዎ ማውራት (የግል መረጃ እና የክህሎቶች እና የብቃት ማጠቃለያ)',
  7: 'ስለ ራስዎ ማውራት (ጥንካሬዎች እና ድክመቶች)',
  8: 'ለምን እርስዎን ልንቀጥርዎ ይገባል እና ማንኛውም ጥያቄ አለዎት?',
  9: 'ደሞዝዎን እንዴት እንደሚደራደሩ',
  10: 'ከሥራ ባልደረቦችዎ ጋር በአካል መግባባት',
  11: 'ከአለቃዎ ጋር በአካል መግባባት',
  12: 'የበይነመረብ ግንኙነት (ስልክ፣ ኢሜይል እና ቪዲዮ ኮንፈረንስ)',
};

const Map<int, String> _kProfEnglishSubtitles = {
  1: 'Finding and securing the right job for you',
  2: 'Self assessments & Understanding job advertisements',
  3: 'Writing your CV (Curriculum Vitae) or resume',
  4: 'How to write your cover letter',
  5: 'The interview (Attire & Attitude)',
  6: 'Talking about Yourself (Personal Information & Summary of Skills and Qualifications)',
  7: 'Talking about yourself (Strengths and weaknesses)',
  8: 'Why should we hire you & Do you have any questions for us',
  9: 'How to negotiate your salary',
  10: 'In-person communication with your colleagues (small talk, work collaboration)',
  11: 'In-person communication with your boss (small talk, reports and complaints)',
  12: 'Virtual communication (phone calls, email and video conferences)',
};

// ── Complete lesson asset map ─────────────────────────────────────────────────
// Key format: '{unitSort}-{moduleSort}-{lessonSort}'
// Unit 1, Module 1 (intro) uses the main folder's generic lesson thumbnails
// All other units/modules use the lessons/ subfolder with specific illustrations
const Map<String, String> _kLessonAssets = {
  // Unit 1 · Module 1 – Introduction
  '1-1-1': 'assets/images/07-duolingo-english-test/7.3-module-lessons-01.svg',
  '1-1-2': 'assets/images/07-duolingo-english-test/7.3-module-lessons-02.svg',
  '1-1-3': 'assets/images/07-duolingo-english-test/7.3-module-lessons-03.svg',
  // Unit 1 · Module 2 – How Scoring Works
  '1-2-1': 'assets/images/07-duolingo-english-test/lessons/1-2-1-det-subscores.svg',
  '1-2-2': 'assets/images/07-duolingo-english-test/lessons/1-2-2-scoring-details.svg',
  // Unit 2 · Module 1
  '2-1-1': 'assets/images/07-duolingo-english-test/lessons/2-1-1-comprehension.svg',
  '2-1-2': 'assets/images/07-duolingo-english-test/lessons/2-1-2-literacy.svg',
  // Unit 2 · Module 2
  '2-2-1': 'assets/images/07-duolingo-english-test/lessons/2-2-1-production.svg',
  '2-2-2': 'assets/images/07-duolingo-english-test/lessons/2-2-2-conversation.svg',
  // Unit 3 · Module 1
  '3-1-1': 'assets/images/07-duolingo-english-test/lessons/3-1-1-listen-and-type-introduction.svg',
  '3-1-2': 'assets/images/07-duolingo-english-test/lessons/3-1-2-essential-tips-and-strategies.svg',
  // Unit 3 · Module 2
  '3-2-1': 'assets/images/07-duolingo-english-test/lessons/3-2-1-interactive-listening-introduction.svg',
  '3-2-2': 'assets/images/07-duolingo-english-test/lessons/3-2-2-interactive-listening-listen-and-complete.svg',
  '3-2-3': 'assets/images/07-duolingo-english-test/lessons/3-2-3-interactive-listening-listen-and-respond.svg',
  '3-2-4': 'assets/images/07-duolingo-english-test/lessons/3-2-4-interactive-listening-summarize-the-conversation.svg',
  // Unit 4 · Module 1
  '4-1-1': 'assets/images/07-duolingo-english-test/lessons/4-1-1-read-and-complete-introduction.svg',
  '4-1-2': 'assets/images/07-duolingo-english-test/lessons/4-1-2-essential-tips-and-strategies.svg',
  '4-1-3': 'assets/images/07-duolingo-english-test/lessons/4-1-3-mastering-context-and-grammar.svg',
  // Unit 4 · Module 2
  '4-2-1': 'assets/images/07-duolingo-english-test/lessons/4-2-1-read-and-select-introduction.svg',
  '4-2-2': 'assets/images/07-duolingo-english-test/lessons/4-2-2-mastering-your-vocabulary.svg',
  '4-2-3': 'assets/images/07-duolingo-english-test/lessons/4-2-3-how-to-spot-fake-words.svg',
  // Unit 4 · Module 3
  '4-3-1': 'assets/images/07-duolingo-english-test/lessons/4-3-1-fill-in-the-blanks-introduction.svg',
  '4-3-2': 'assets/images/07-duolingo-english-test/lessons/4-3-2-essential-tips-and-strategies.svg',
  // Unit 4 · Module 4
  '4-4-1': 'assets/images/07-duolingo-english-test/lessons/4-4-1-interactive-reading-introduction.svg',
  '4-4-2': 'assets/images/07-duolingo-english-test/lessons/4-4-2-interactive-reading-complete-the-sentence.svg',
  '4-4-3': 'assets/images/07-duolingo-english-test/lessons/4-4-3-interactive-reading-complete-the-passage.svg',
  '4-4-4': 'assets/images/07-duolingo-english-test/lessons/4-4-4-interactive-reading-highlight-the-answer.svg',
  '4-4-5': 'assets/images/07-duolingo-english-test/lessons/4-4-5-interactive-reading-identify-the-idea.svg',
  '4-4-6': 'assets/images/07-duolingo-english-test/lessons/4-4-6-interactive-reading-title-the-passage.svg',
  // Unit 5 · Module 1
  '5-1-1': 'assets/images/07-duolingo-english-test/lessons/5-1-1-introduction.svg',
  '5-1-2': 'assets/images/07-duolingo-english-test/lessons/5-1-2-essential-tips-and-strategies.svg',
  // Unit 5 · Module 2
  '5-2-1': 'assets/images/07-duolingo-english-test/lessons/5-2-1-introduction.svg',
  '5-2-2': 'assets/images/07-duolingo-english-test/lessons/5-2-2-essential-tips-and-strategies.svg',
  // Unit 5 · Module 3
  '5-3-1': 'assets/images/07-duolingo-english-test/lessons/5-3-1-introduction.svg',
  '5-3-2': 'assets/images/07-duolingo-english-test/lessons/5-3-2-mastering-part-1.svg',
  '5-3-3': 'assets/images/07-duolingo-english-test/lessons/5-3-3-the-follow-up-task.svg',
  // Unit 6 · Module 1
  '6-1-1': 'assets/images/07-duolingo-english-test/lessons/6-1-1-introduction.svg',
  '6-1-2': 'assets/images/07-duolingo-english-test/lessons/6-1-2-common-mistakes-and-high-scoring-tips.svg',
  // Unit 6 · Module 2
  '6-2-1': 'assets/images/07-duolingo-english-test/lessons/6-2-1-introduction.svg',
  '6-2-2': 'assets/images/07-duolingo-english-test/lessons/6-2-2-essential-tips-and-strategies.svg',
  // Unit 6 · Module 3
  '6-3-1': 'assets/images/07-duolingo-english-test/lessons/6-3-1-introduction-and-basics.svg',
  '6-3-2': 'assets/images/07-duolingo-english-test/lessons/6-3-2-tips-and-strategies.svg',
  // Unit 6 · Module 4
  '6-4-1': 'assets/images/07-duolingo-english-test/lessons/6-4-1-introduction.svg',
  '6-4-2': 'assets/images/07-duolingo-english-test/lessons/6-4-2-the-35-second-answer-formula.svg',
  '6-4-3': 'assets/images/07-duolingo-english-test/lessons/6-4-3-boosting-your-score-and-handling-mistakes.svg',
};

// Fallback thumbnails for unmapped lessons (cycle of 3)
const List<String> _kFallbackAssets = [
  'assets/images/07-duolingo-english-test/7.3-module-lessons-01.svg',
  'assets/images/07-duolingo-english-test/7.3-module-lessons-02.svg',
  'assets/images/07-duolingo-english-test/7.3-module-lessons-03.svg',
];

// ── Complete IELTS lesson asset map ──────────────────────────────────────────
const Map<String, String> _kIeltsLessonAssets = {
  // Unit 1 · Module 1
  '1-1-1': 'assets/images/08-ielts/lessons/1-1-1-introduction-to-the-instructor.svg',
  '1-1-2': 'assets/images/08-ielts/lessons/1-1-2-ielts-overview.svg',
  // Unit 1 · Module 2
  '1-2-1': 'assets/images/08-ielts/lessons/1-2-1-academic-vs-general.svg',
  '1-2-2': 'assets/images/08-ielts/lessons/1-2-2-paper-vs-computer.svg',
  '1-2-3': 'assets/images/08-ielts/lessons/1-2-3-what-are-bands-and-what-band-should-i-aim-for.svg',
  // Unit 1 · Module 3
  '1-3-1': 'assets/images/08-ielts/lessons/1-3-1-registration-walkthrough.svg',
  '1-3-2': 'assets/images/08-ielts/lessons/1-3-2-book-your-ielts-test-with-yimaru.svg',
  // Unit 2 · Module 1
  '2-1-1': 'assets/images/08-ielts/lessons/2-1-1-test-format.svg',
  '2-1-2': 'assets/images/08-ielts/lessons/2-1-2-what-are-they-testing.svg',
  '2-1-3': 'assets/images/08-ielts/lessons/2-1-3-how-to-simulate-the-test-at-home-for-practice.svg',
  // Unit 2 · Module 2
  '2-2-1': 'assets/images/08-ielts/lessons/2-2-1-what-to-expect-in-part-1.svg',
  '2-2-2': 'assets/images/08-ielts/lessons/2-2-2-ielts-speaking-part-1-dos-don-ts.svg',
  '2-2-3': 'assets/images/08-ielts/lessons/2-2-3-frameworks-for-part-1.svg',
  '2-2-4': 'assets/images/08-ielts/lessons/2-2-4-an-example-for-part-1.svg',
  // Unit 2 · Module 3
  '2-3-1': 'assets/images/08-ielts/lessons/2-3-1-what-to-expect-in-part-2.svg',
  '2-3-2': 'assets/images/08-ielts/lessons/2-3-2-ielts-speaking-part-2-dos-don-ts.svg',
  '2-3-3': 'assets/images/08-ielts/lessons/2-3-3-frameworks-for-part-2.svg',
  '2-3-4': 'assets/images/08-ielts/lessons/2-3-4-an-example-for-part-2.svg',
  // Unit 2 · Module 4
  '2-4-1': 'assets/images/08-ielts/lessons/2-4-1-what-to-expect-in-part-3.svg',
  '2-4-2': 'assets/images/08-ielts/lessons/2-4-2-ielts-speaking-part-3-dos-don-ts.svg',
  '2-4-3': 'assets/images/08-ielts/lessons/2-4-3-frameworks-for-part-3.svg',
  '2-4-4': 'assets/images/08-ielts/lessons/2-4-4-an-example-for-part-3.svg',
  // Unit 2 · Module 5
  '2-5-1': 'assets/images/08-ielts/lessons/2-5-1-band-7-vocabulary-use.svg',
  '2-5-2': 'assets/images/08-ielts/lessons/2-5-2-idioms-to-use-for-a-band-7.svg',
  // Unit 2 · Module 6
  '2-6-1': 'assets/images/08-ielts/lessons/2-6-1-5-tips-for-a-band-7-in-speaking.svg',
  // Unit 3 · Module 2
  '3-2-1': 'assets/images/08-ielts/lessons/3-2-1-an-introduction-to-the-question-types.svg',
  // Unit 3 · Module 4
  '3-4-1': 'assets/images/08-ielts/lessons/3-4-1-what-to-expect-in-section-2.svg',
  '3-4-2': 'assets/images/08-ielts/lessons/3-4-2-strategies-for-section-2.svg',
  '3-4-3': 'assets/images/08-ielts/lessons/3-4-3-common-section-2-task-multiple-choice.svg',
  '3-4-4': 'assets/images/08-ielts/lessons/3-4-4-common-section-2-task-plan-map-diagram-labelling.svg',
  '3-4-5': 'assets/images/08-ielts/lessons/3-4-5-common-section-2-task-information-completion.svg',
  '3-4-6': 'assets/images/08-ielts/lessons/3-4-6-examples-for-section-2.svg',
  // Unit 3 · Module 5
  '3-5-1': 'assets/images/08-ielts/lessons/3-5-1-what-to-expect-in-section-3.svg',
  '3-5-2': 'assets/images/08-ielts/lessons/3-5-2-strategies-for-section-3.svg',
  '3-5-3': 'assets/images/08-ielts/lessons/3-5-3-common-section-3-task-complex-multiple-choice.svg',
  '3-5-4': 'assets/images/08-ielts/lessons/3-5-4-common-section-3-task-matching.svg',
  '3-5-5': 'assets/images/08-ielts/lessons/3-5-5-examples-for-section-3.svg',
  // Unit 3 · Module 6
  '3-6-1': 'assets/images/08-ielts/lessons/3-6-1-what-to-expect-in-section-4.svg',
  '3-6-2': 'assets/images/08-ielts/lessons/3-6-2-strategies-for-section-4.svg',
  '3-6-3': 'assets/images/08-ielts/lessons/3-6-3-common-section-4-task-completion-tasks.svg',
  '3-6-4': 'assets/images/08-ielts/lessons/3-6-4-common-section-4-task-sentence-completion.svg',
  '3-6-5': 'assets/images/08-ielts/lessons/3-6-5-examples-for-section-4.svg',
  // Unit 3 · Module 7
  '3-7-1': 'assets/images/08-ielts/lessons/3-7-1-5-tips-for-a-band-7-in-listening.svg',
  // Unit 4 · Module 1
  '4-1-1': 'assets/images/08-ielts/lessons/4-1-1-test-format.svg',
  // Unit 4 · Module 2
  '4-2-1': 'assets/images/08-ielts/lessons/4-2-1-skills-to-work-on-for-ielts-reading.svg',
  // Unit 4 · Module 3
  '4-3-1': 'assets/images/08-ielts/lessons/4-3-1-strategies-for-question-types-in-passage-1.svg',
  '4-3-2': 'assets/images/08-ielts/lessons/4-3-2-examples-for-short-answer-questions.svg',
  '4-3-3': 'assets/images/08-ielts/lessons/4-3-3-example-for-true-false-not-given.svg',
  '4-3-4': 'assets/images/08-ielts/lessons/4-3-4-example-for-sentence-completion.svg',
  '4-3-5': 'assets/images/08-ielts/lessons/4-3-5-example-for-labelling-a-diagram.svg',
  // Unit 4 · Module 5
  '4-5-1': 'assets/images/08-ielts/lessons/4-5-1-strategies-for-question-types-in-passage-3.svg',
  '4-5-2': 'assets/images/08-ielts/lessons/4-5-2-yes-no-not-given.svg',
  '4-5-3': 'assets/images/08-ielts/lessons/4-5-3-example-for-summary-completion.svg',
  '4-5-4': 'assets/images/08-ielts/lessons/4-5-4-example-for-matching-sentences.svg',
  '4-5-5': 'assets/images/08-ielts/lessons/4-5-5-example-for-multiple-choice-questions-one-answer.svg',
  '4-5-6': 'assets/images/08-ielts/lessons/4-5-6-example-for-multiple-choice-questions-two-answers.svg',
  // Unit 4 · Module 6
  '4-6-1': 'assets/images/08-ielts/lessons/4-6-1-5-tips-to-get-a-band-7-in-reading.svg',
  // Unit 5 · Module 1
  '5-1-1': 'assets/images/08-ielts/lessons/5-1-1-test-format.svg',
  '5-1-2': 'assets/images/08-ielts/lessons/5-1-2-what-are-they-testing.svg',
  // Unit 5 · Module 2
  '5-2-1': 'assets/images/08-ielts/lessons/5-2-1-understanding-task-1-questions-part-1.svg',
  '5-2-2': 'assets/images/08-ielts/lessons/5-2-2-understanding-task-1-questions-part-2.svg',
  '5-2-3': 'assets/images/08-ielts/lessons/5-2-3-a-framework-to-tackle-any-task-1-question.svg',
  '5-2-4': 'assets/images/08-ielts/lessons/5-2-4-before-you-start-writing.svg',
  '5-2-5': 'assets/images/08-ielts/lessons/5-2-5-writing-an-introduction.svg',
  '5-2-6': 'assets/images/08-ielts/lessons/5-2-6-writing-an-overview.svg',
  '5-2-7': 'assets/images/08-ielts/lessons/5-2-7-writing-detail-paragraphs.svg',
  '5-2-8': 'assets/images/08-ielts/lessons/5-2-8-example-for-task-1.svg',
  '5-2-9': 'assets/images/08-ielts/lessons/5-2-9-vocabulary-use-for-task-1.svg',
  // Unit 5 · Module 3
  '5-3-1': 'assets/images/08-ielts/lessons/5-3-1-5-tips-for-a-band-7-score-in-ielts-task-1.svg',
  // Unit 5 · Module 4
  '5-4-1': 'assets/images/08-ielts/lessons/5-4-1-understanding-task-2-questions-part-1.svg',
  '5-4-2': 'assets/images/08-ielts/lessons/5-4-2-understanding-task-2-questions-part-2.svg',
  '5-4-3': 'assets/images/08-ielts/lessons/5-4-3-essay-structure.svg',
  '5-4-4': 'assets/images/08-ielts/lessons/5-4-4-before-you-start-writing.svg',
  '5-4-5': 'assets/images/08-ielts/lessons/5-4-5-writing-an-introduction.svg',
  '5-4-6': 'assets/images/08-ielts/lessons/5-4-6-writing-body-paragraphs.svg',
  '5-4-7': 'assets/images/08-ielts/lessons/5-4-7-writing-a-conclusion.svg',
  '5-4-8': 'assets/images/08-ielts/lessons/5-4-8-example-for-task-2.svg',
  '5-4-9': 'assets/images/08-ielts/lessons/5-4-9-vocabulary-use-for-task-2.svg',
  // Unit 5 · Module 5
  '5-5-1': 'assets/images/08-ielts/lessons/5-5-1-5-tips-for-a-band-7-score-in-ielts-task-2.svg',
  // Unit 6 · Module 1
  '6-1-1': 'assets/images/08-ielts/lessons/6-1-1-what-to-bring-on-test-day.svg',
  // Unit 6 · Module 2
  '6-2-1': 'assets/images/08-ielts/lessons/6-2-1-getting-familiar-with-ielts-answer-sheets.svg',
  // Unit 6 · Module 3
  '6-3-1': 'assets/images/08-ielts/lessons/6-3-1-results-and-farewell.svg',
};

const List<String> _kIeltsFallbackAssets = [
  'assets/images/08-ielts/8.1-ielts-course-01.svg',
  'assets/images/08-ielts/8.1-ielts-course-01.svg',
  'assets/images/08-ielts/8.1-ielts-course-01.svg',
];


class CourseLessonTile extends ViewModelWidget<CourseModuleViewModel> {
  final int index;
  final CourseLesson lesson;
  final CourseModule? module;
  final SubscriptionType courseType;
  final CourseCatalog? catalog;
  final int unitSortOrder;
  final int moduleSortOrder;
  final GestureTapCallback? onVideoTap;
  final GestureTapCallback? onPracticeTap;

  const CourseLessonTile({
    super.key,
    required this.index,
    required this.lesson,
    this.module,
    this.catalog,
    this.courseType = SubscriptionType.duolingo,
    this.unitSortOrder = 1,
    this.moduleSortOrder = 1,
    this.onVideoTap,
    this.onPracticeTap,
  });

  bool get _isProfessionals =>
      (catalog?.name ?? '').toLowerCase().contains('prof') ||
      (catalog?.category ?? '').toLowerCase().contains('prof') ||
      courseType == SubscriptionType.learn ||
      (module?.name ?? '').contains('ሥራ') ||
      (module?.name ?? '').contains('ሲቪ') ||
      (module?.name ?? '').contains('ቃለ መጠይቅ') ||
      (lesson.title ?? '').contains('ሥራ') ||
      (lesson.title ?? '').contains('ሲቪ') ||
      (lesson.title ?? '').contains('ቃለ መጠይቅ') ||
      (lesson.title ?? '').contains('Cover Letter') ||
      (lesson.title ?? '').contains('CV');

  bool get _isIelts => !_isProfessionals && courseType == SubscriptionType.ielts;

  Color get _themeColor {
    if (_isProfessionals) return const Color(0xFF8E2483);
    if (_isIelts) return const Color(0xFFE4002B);
    return AppColors.chartreuse40;
  }

  int get _profModuleIndex {
    // English For Professionals has 2 units × 6 modules = 12 lesson cards total.
    // unitSortOrder ∈ {1,2}, moduleSortOrder ∈ {1..6}
    // Global 1-based index = (unit-1)*6 + module
    final uSort = unitSortOrder;  // 1 or 2
    final mSort = moduleSortOrder; // 1..6
    if (uSort > 0 && mSort > 0) {
      final computed = (uSort - 1) * 6 + mSort; // 1..12
      if (computed >= 1 && computed <= 12) return computed;
    }

    // Keyword fallback (when sort orders are unavailable)
    final mName = (module?.name ?? '').toLowerCase();
    final lTitle = (lesson.title ?? '').toLowerCase();
    if (mName.contains('ትክክለኛ ሥራ') || lTitle.contains('finding') || lTitle.contains('ትክክለኛ ሥራ')) return 1;
    if (mName.contains('የራስ ግምገማ') || lTitle.contains('self') || lTitle.contains('የራስ ግምገማ')) return 2;
    if (mName.contains('ሲቪ') || mName.contains('cv') || lTitle.contains('cv') || lTitle.contains('ሲቪ')) return 3;
    if (mName.contains('ደብዳቤ') || mName.contains('cover') || lTitle.contains('cover') || lTitle.contains('ደብዳቤ')) return 4;
    if (mName.contains('ቃለ መጠይቅ') || lTitle.contains('interview') || lTitle.contains('ቃለ መጠይቅ')) return 5;
    if (mName.contains('የግል መረጃ') || lTitle.contains('personal') || lTitle.contains('ማጠቃለያ')) return 6;
    if (mName.contains('ጥንካሬ') || lTitle.contains('strengths')) return 7;
    if (mName.contains('ለምን') || lTitle.contains('hire')) return 8;
    if (mName.contains('ደሞዝ') || lTitle.contains('salary')) return 9;
    if (mName.contains('ባልደረቦች') || lTitle.contains('colleagues')) return 10;
    if (mName.contains('አለቃ') || lTitle.contains('boss')) return 11;
    if (mName.contains('በይነመረብ') || lTitle.contains('virtual') || lTitle.contains('conference')) return 12;
    return (index % 12) + 1;
  }

  String get _profThumbnailAsset =>
      _kProfAssets[_profModuleIndex] ?? _kProfAssets[1]!;

  String get _profAmharicTitle {
    if (lesson.title != null &&
        lesson.title!.isNotEmpty &&
        lesson.title!.contains(RegExp(r'[\u1200-\u137F]'))) {
      return lesson.title!;
    }
    return _kProfAmharicTitles[_profModuleIndex] ?? lesson.title ?? '';
  }

  String get _profEnglishSubtitle {
    if (lesson.description != null && lesson.description!.isNotEmpty) {
      return lesson.description!;
    }
    return _kProfEnglishSubtitles[_profModuleIndex] ?? '';
  }

  /// Resolves the exact SVG asset for this lesson.
  /// Uses a multi-tier matching strategy:
  /// 1. Regex on lesson title ("1.1.1", "1.2.1", etc.)
  /// 2. Regex on module name ("1.1", "1.2") + list position
  /// 3. Keyword matching on lesson title
  /// 4. Unit / Module sort orders
  /// 5. Deterministic fallback
  String get _thumbnailAsset {
    if (_isProfessionals) {
      return _profThumbnailAsset;
    }
    final title = (lesson.title ?? '').trim().toLowerCase();
    final modName = (module?.name ?? '').trim().toLowerCase();

    if (_isIelts) {
      return _getIeltsThumbnailAsset(title, modName);
    }

    // 1. Direct Regex match on lesson title (e.g. "1.1.1", "1.2.1", "1-2-1", etc.)
    final titleMatch =
        RegExp(r'(\d+)[\.\-_](\d+)[\.\-_](\d+)').firstMatch(title);
    if (titleMatch != null) {
      final u = int.tryParse(titleMatch.group(1)!) ?? 1;
      final m = int.tryParse(titleMatch.group(2)!) ?? 1;
      final l = int.tryParse(titleMatch.group(3)!) ?? 1;
      final key = '$u-$m-$l';
      if (_kLessonAssets.containsKey(key)) {
        return _kLessonAssets[key]!;
      }
    }

    // 2. Direct Regex match on module name + index (e.g. "1.2 How Scoring Works" -> u=1, m=2)
    final modMatch = RegExp(r'(\d+)[\.\-_](\d+)').firstMatch(modName);
    if (modMatch != null) {
      final u = int.tryParse(modMatch.group(1)!) ?? 1;
      final m = int.tryParse(modMatch.group(2)!) ?? 1;
      final l = index + 1;
      final key = '$u-$m-$l';
      if (_kLessonAssets.containsKey(key)) {
        return _kLessonAssets[key]!;
      }
    }

    // 3. Keyword matching based on Duolingo DET lesson topics
    // Unit 1 · Module 1
    if (title.contains('overview') ||
        (modName.contains('intro') && index == 0)) {
      return 'assets/images/07-duolingo-english-test/7.3-module-lessons-01.svg';
    }
    if (title.contains('why take') ||
        (modName.contains('intro') && index == 1)) {
      return 'assets/images/07-duolingo-english-test/7.3-module-lessons-02.svg';
    }
    if (title.contains('expect') ||
        (modName.contains('intro') && index == 2)) {
      return 'assets/images/07-duolingo-english-test/7.3-module-lessons-03.svg';
    }

    // Unit 1 · Module 2 (Scoring)
    if (title.contains('subscore') ||
        title.contains('sub-score') ||
        title.contains('sub score') ||
        (modName.contains('scoring') && index == 0)) {
      return 'assets/images/07-duolingo-english-test/lessons/1-2-1-det-subscores.svg';
    }
    if (title.contains('scoring detail') ||
        title.contains('scoring') ||
        (modName.contains('scoring') && index == 1)) {
      return 'assets/images/07-duolingo-english-test/lessons/1-2-2-scoring-details.svg';
    }

    // Unit 2 (Subscores Explained)
    if (title.contains('comprehension')) {
      return 'assets/images/07-duolingo-english-test/lessons/2-1-1-comprehension.svg';
    }
    if (title.contains('literacy')) {
      return 'assets/images/07-duolingo-english-test/lessons/2-1-2-literacy.svg';
    }
    if (title.contains('production')) {
      return 'assets/images/07-duolingo-english-test/lessons/2-2-1-production.svg';
    }
    if (title.contains('conversation')) {
      return 'assets/images/07-duolingo-english-test/lessons/2-2-2-conversation.svg';
    }

    // Unit 3 (Listening)
    if (title.contains('listen and type') || title.contains('listen & type')) {
      if (index == 0 || title.contains('intro')) {
        return 'assets/images/07-duolingo-english-test/lessons/3-1-1-listen-and-type-introduction.svg';
      }
      return 'assets/images/07-duolingo-english-test/lessons/3-1-2-essential-tips-and-strategies.svg';
    }
    if (title.contains('interactive listening')) {
      if (index == 0 || title.contains('intro')) {
        return 'assets/images/07-duolingo-english-test/lessons/3-2-1-interactive-listening-introduction.svg';
      } else if (index == 1 || title.contains('complete')) {
        return 'assets/images/07-duolingo-english-test/lessons/3-2-2-interactive-listening-listen-and-complete.svg';
      } else if (index == 2 || title.contains('respond')) {
        return 'assets/images/07-duolingo-english-test/lessons/3-2-3-interactive-listening-listen-and-respond.svg';
      } else {
        return 'assets/images/07-duolingo-english-test/lessons/3-2-4-interactive-listening-summarize-the-conversation.svg';
      }
    }

    // Unit 4 (Reading)
    if (title.contains('read and complete') ||
        title.contains('read & complete')) {
      if (index == 0) {
        return 'assets/images/07-duolingo-english-test/lessons/4-1-1-read-and-complete-introduction.svg';
      }
      if (index == 1) {
        return 'assets/images/07-duolingo-english-test/lessons/4-1-2-essential-tips-and-strategies.svg';
      }
      return 'assets/images/07-duolingo-english-test/lessons/4-1-3-mastering-context-and-grammar.svg';
    }
    if (title.contains('read and select') ||
        title.contains('read & select')) {
      if (index == 0) {
        return 'assets/images/07-duolingo-english-test/lessons/4-2-1-read-and-select-introduction.svg';
      }
      if (index == 1) {
        return 'assets/images/07-duolingo-english-test/lessons/4-2-2-mastering-your-vocabulary.svg';
      }
      return 'assets/images/07-duolingo-english-test/lessons/4-2-3-how-to-spot-fake-words.svg';
    }
    if (title.contains('fill in the blank') ||
        title.contains('fill-in-the-blank')) {
      if (index == 0) {
        return 'assets/images/07-duolingo-english-test/lessons/4-3-1-fill-in-the-blanks-introduction.svg';
      }
      return 'assets/images/07-duolingo-english-test/lessons/4-3-2-essential-tips-and-strategies.svg';
    }
    if (title.contains('interactive reading')) {
      final arr = [
        'assets/images/07-duolingo-english-test/lessons/4-4-1-interactive-reading-introduction.svg',
        'assets/images/07-duolingo-english-test/lessons/4-4-2-interactive-reading-complete-the-sentence.svg',
        'assets/images/07-duolingo-english-test/lessons/4-4-3-interactive-reading-complete-the-passage.svg',
        'assets/images/07-duolingo-english-test/lessons/4-4-4-interactive-reading-highlight-the-answer.svg',
        'assets/images/07-duolingo-english-test/lessons/4-4-5-interactive-reading-identify-the-idea.svg',
        'assets/images/07-duolingo-english-test/lessons/4-4-6-interactive-reading-title-the-passage.svg',
      ];
      return arr[index % arr.length];
    }

    // Unit 5 (Writing)
    if (title.contains('follow-up') ||
        title.contains('follow up') ||
        title.contains('followup') ||
        (modName.contains('interactive writing') && (index == 2 || title.contains('follow')))) {
      return 'assets/images/07-duolingo-english-test/lessons/5-3-3-the-follow-up-task.svg';
    }
    if (title.contains('mastering part 1') ||
        title.contains('part 1') ||
        (modName.contains('interactive writing') && index == 1)) {
      return 'assets/images/07-duolingo-english-test/lessons/5-3-2-mastering-part-1.svg';
    }
    if (modName.contains('interactive writing')) {
      return 'assets/images/07-duolingo-english-test/lessons/5-3-1-introduction.svg';
    }
    if (title.contains('write about the photo') || modName.contains('write about the photo') || modName.contains('photo') && modName.contains('write')) {
      if (index == 0 || title.contains('intro')) {
        return 'assets/images/07-duolingo-english-test/lessons/5-1-1-introduction.svg';
      }
      return 'assets/images/07-duolingo-english-test/lessons/5-1-2-essential-tips-and-strategies.svg';
    }
    if (title.contains('writing sample') || modName.contains('writing sample')) {
      if (index == 0 || title.contains('intro')) {
        return 'assets/images/07-duolingo-english-test/lessons/5-2-1-introduction.svg';
      }
      return 'assets/images/07-duolingo-english-test/lessons/5-2-2-essential-tips-and-strategies.svg';
    }

    // Unit 6 (Speaking)
    if (modName.contains('interactive speaking')) {
      if (index == 0 || title.contains('intro')) {
        return 'assets/images/07-duolingo-english-test/lessons/6-4-1-introduction.svg';
      } else if (index == 1 || title.contains('35-second') || title.contains('35 second') || title.contains('formula')) {
        return 'assets/images/07-duolingo-english-test/lessons/6-4-2-the-35-second-answer-formula.svg';
      } else {
        return 'assets/images/07-duolingo-english-test/lessons/6-4-3-boosting-your-score-and-handling-mistakes.svg';
      }
    }
    if (modName.contains('speaking sample')) {
      if (index == 0 || title.contains('intro') || title.contains('basic')) {
        return 'assets/images/07-duolingo-english-test/lessons/6-3-1-introduction-and-basics.svg';
      }
      return 'assets/images/07-duolingo-english-test/lessons/6-3-2-tips-and-strategies.svg';
    }
    if (modName.contains('read then speak') || modName.contains('read & speak') || modName.contains('read and speak')) {
      if (index == 0 || title.contains('intro')) {
        return 'assets/images/07-duolingo-english-test/lessons/6-2-1-introduction.svg';
      }
      return 'assets/images/07-duolingo-english-test/lessons/6-2-2-essential-tips-and-strategies.svg';
    }
    if (modName.contains('speak about the photo')) {
      if (index == 0 || title.contains('intro')) {
        return 'assets/images/07-duolingo-english-test/lessons/6-1-1-introduction.svg';
      }
      return 'assets/images/07-duolingo-english-test/lessons/6-1-2-common-mistakes-and-high-scoring-tips.svg';
    }
    if (title.contains('35-second') || title.contains('35 second')) {
      return 'assets/images/07-duolingo-english-test/lessons/6-4-2-the-35-second-answer-formula.svg';
    }
    if (title.contains('boosting your score') || title.contains('handling mistakes')) {
      return 'assets/images/07-duolingo-english-test/lessons/6-4-3-boosting-your-score-and-handling-mistakes.svg';
    }

    // 4. Try key using unitSortOrder and moduleSortOrder + (index + 1)
    final key = '$unitSortOrder-$moduleSortOrder-${index + 1}';
    if (_kLessonAssets.containsKey(key)) {
      return _kLessonAssets[key]!;
    }

    // 5. Fallback deterministic per index
    return _kFallbackAssets[index % _kFallbackAssets.length];
  }

  String _getIeltsThumbnailAsset(String title, String modName) {
    // 1. Direct Regex match on lesson title (e.g. "1.1.1", "1.2.1", etc.)
    final titleMatch =
        RegExp(r'(\\d+)[\\.\\-_](\\d+)[\\.\\-_](\\d+)').firstMatch(title);
    if (titleMatch != null) {
      final u = int.tryParse(titleMatch.group(1)!) ?? 1;
      final m = int.tryParse(titleMatch.group(2)!) ?? 1;
      final l = int.tryParse(titleMatch.group(3)!) ?? 1;
      final key = '$u-$m-$l';
      if (_kIeltsLessonAssets.containsKey(key)) {
        return _kIeltsLessonAssets[key]!;
      }
    }

    // 2. Direct Regex match on module name + index
    final modMatch = RegExp(r'(\\d+)[\\.\\-_](\\d+)').firstMatch(modName);
    if (modMatch != null) {
      final u = int.tryParse(modMatch.group(1)!) ?? 1;
      final m = int.tryParse(modMatch.group(2)!) ?? 1;
      final l = index + 1;
      final key = '$u-$m-$l';
      if (_kIeltsLessonAssets.containsKey(key)) {
        return _kIeltsLessonAssets[key]!;
      }
    }

    // 3. Keyword matching for IELTS lessons
    // Unit 1
    if (title.contains('instructor') || title.contains('1.1.1')) {
      return _kIeltsLessonAssets['1-1-1']!;
    }
    if (title.contains('overview') || title.contains('1.1.2')) {
      return _kIeltsLessonAssets['1-1-2']!;
    }
    if (title.contains('academic vs general') || title.contains('academic')) {
      return _kIeltsLessonAssets['1-2-1']!;
    }
    if (title.contains('paper vs computer')) {
      return _kIeltsLessonAssets['1-2-2']!;
    }
    if (title.contains('bands') || title.contains('band should i aim')) {
      return _kIeltsLessonAssets['1-2-3']!;
    }
    if (title.contains('registration walkthrough')) {
      return _kIeltsLessonAssets['1-3-1']!;
    }
    if (title.contains('book your ielts') || title.contains('test with yimaru')) {
      return _kIeltsLessonAssets['1-3-2']!;
    }

    // Unit 2 (Speaking)
    if (modName.contains('speaking') || modName.contains('2.')) {
      if (title.contains('test format')) {
        return _kIeltsLessonAssets['2-1-1']!;
      }
      if (title.contains('what are they testing')) {
        return _kIeltsLessonAssets['2-1-2']!;
      }
      if (title.contains('simulate the test')) {
        return _kIeltsLessonAssets['2-1-3']!;
      }
      if (title.contains('what to expect in part 1')) {
        return _kIeltsLessonAssets['2-2-1']!;
      }
      if (title.contains('dos') && modName.contains('part 1')) {
        return _kIeltsLessonAssets['2-2-2']!;
      }
      if (title.contains('frameworks for part 1')) {
        return _kIeltsLessonAssets['2-2-3']!;
      }
      if (title.contains('example for part 1')) {
        return _kIeltsLessonAssets['2-2-4']!;
      }
      if (title.contains('what to expect in part 2')) {
        return _kIeltsLessonAssets['2-3-1']!;
      }
      if (title.contains('dos') && modName.contains('part 2')) {
        return _kIeltsLessonAssets['2-3-2']!;
      }
      if (title.contains('frameworks for part 2')) {
        return _kIeltsLessonAssets['2-3-3']!;
      }
      if (title.contains('example for part 2')) {
        return _kIeltsLessonAssets['2-3-4']!;
      }
      if (title.contains('what to expect in part 3')) {
        return _kIeltsLessonAssets['2-4-1']!;
      }
      if (title.contains('dos') && modName.contains('part 3')) {
        return _kIeltsLessonAssets['2-4-2']!;
      }
      if (title.contains('frameworks for part 3')) {
        return _kIeltsLessonAssets['2-4-3']!;
      }
      if (title.contains('example for part 3')) {
        return _kIeltsLessonAssets['2-4-4']!;
      }
      if (title.contains('vocabulary')) {
        return _kIeltsLessonAssets['2-5-1']!;
      }
      if (title.contains('idiom')) {
        return _kIeltsLessonAssets['2-5-2']!;
      }
      if (title.contains('tips for a band 7')) {
        return _kIeltsLessonAssets['2-6-1']!;
      }
    }

    // Unit 3 (Listening)
    if (modName.contains('listening') || modName.contains('3.')) {
      if (title.contains('question types') || title.contains('3.2.1')) {
        return _kIeltsLessonAssets['3-2-1']!;
      }
      if (modName.contains('section 2') || modName.contains('3.4')) {
        if (title.contains('what to expect') || title.contains('3.4.1')) return _kIeltsLessonAssets['3-4-1']!;
        if (title.contains('strategies') || title.contains('3.4.2')) return _kIeltsLessonAssets['3-4-2']!;
        if (title.contains('multiple choice') || title.contains('3.4.3')) return _kIeltsLessonAssets['3-4-3']!;
        if (title.contains('plan') || title.contains('map') || title.contains('diagram') || title.contains('3.4.4')) return _kIeltsLessonAssets['3-4-4']!;
        if (title.contains('information completion') || title.contains('3.4.5')) return _kIeltsLessonAssets['3-4-5']!;
        if (title.contains('example') || title.contains('3.4.6')) return _kIeltsLessonAssets['3-4-6']!;
      }
      if (modName.contains('section 3') || modName.contains('3.5')) {
        if (title.contains('what to expect') || title.contains('3.5.1')) return _kIeltsLessonAssets['3-5-1']!;
        if (title.contains('strategies') || title.contains('3.5.2')) return _kIeltsLessonAssets['3-5-2']!;
        if (title.contains('complex') || title.contains('multiple choice') || title.contains('3.5.3')) return _kIeltsLessonAssets['3-5-3']!;
        if (title.contains('matching') || title.contains('3.5.4')) return _kIeltsLessonAssets['3-5-4']!;
        if (title.contains('example') || title.contains('3.5.5')) return _kIeltsLessonAssets['3-5-5']!;
      }
      if (modName.contains('section 4') || modName.contains('3.6')) {
        if (title.contains('what to expect') || title.contains('3.6.1')) return _kIeltsLessonAssets['3-6-1']!;
        if (title.contains('strategies') || title.contains('3.6.2')) return _kIeltsLessonAssets['3-6-2']!;
        if (title.contains('completion tasks') || title.contains('3.6.3')) return _kIeltsLessonAssets['3-6-3']!;
        if (title.contains('sentence completion') || title.contains('3.6.4')) return _kIeltsLessonAssets['3-6-4']!;
        if (title.contains('example') || title.contains('3.6.5')) return _kIeltsLessonAssets['3-6-5']!;
      }
      if (title.contains('tips for a band 7') || (title.contains('tips') && modName.contains('3.7')) || title.contains('3.7.1')) {
        return _kIeltsLessonAssets['3-7-1']!;
      }
    }

    // Unit 4 (Reading)
    if (modName.contains('reading') || modName.contains('4.')) {
      if (modName.contains('4.1') || title.contains('4.1.1') || (title.contains('test format') && !title.contains('speaking'))) {
        return _kIeltsLessonAssets['4-1-1']!;
      }
      if (title.contains('skills to work on') || title.contains('4.2.1') || modName.contains('4.2')) {
        return _kIeltsLessonAssets['4-2-1']!;
      }
      if (modName.contains('passage 1') || modName.contains('4.3')) {
        if (title.contains('strategies') || title.contains('4.3.1')) return _kIeltsLessonAssets['4-3-1']!;
        if (title.contains('short-answer') || title.contains('short answer') || title.contains('4.3.2')) return _kIeltsLessonAssets['4-3-2']!;
        if (title.contains('true') || title.contains('false') || title.contains('not given') || title.contains('4.3.3')) return _kIeltsLessonAssets['4-3-3']!;
        if (title.contains('sentence completion') || title.contains('4.3.4')) return _kIeltsLessonAssets['4-3-4']!;
        if (title.contains('labelling') || title.contains('diagram') || title.contains('4.3.5')) return _kIeltsLessonAssets['4-3-5']!;
      }
      if (modName.contains('passage 3') || modName.contains('4.5')) {
        if (title.contains('strategies') || title.contains('4.5.1')) return _kIeltsLessonAssets['4-5-1']!;
        if (title.contains('yes') || title.contains('no') || title.contains('4.5.2')) return _kIeltsLessonAssets['4-5-2']!;
        if (title.contains('summary completion') || title.contains('summary') || title.contains('4.5.3')) return _kIeltsLessonAssets['4-5-3']!;
        if (title.contains('matching sentences') || title.contains('4.5.4')) return _kIeltsLessonAssets['4-5-4']!;
        if (title.contains('one answer') || title.contains('4.5.5')) return _kIeltsLessonAssets['4-5-5']!;
        if (title.contains('two answers') || title.contains('two answer') || title.contains('4.5.6')) return _kIeltsLessonAssets['4-5-6']!;
      }
      if (title.contains('tips to get a band 7') || modName.contains('4.6') || title.contains('4.6.1')) {
        return _kIeltsLessonAssets['4-6-1']!;
      }
    }

    // Unit 5 (Writing)
    if (modName.contains('writing') || modName.contains('5.')) {
      if (modName.contains('5.1')) {
        if (title.contains('test format') || title.contains('5.1.1')) return _kIeltsLessonAssets['5-1-1']!;
        if (title.contains('what are they testing') || title.contains('5.1.2')) return _kIeltsLessonAssets['5-1-2']!;
      }
      if (modName.contains('task 1') && !modName.contains('tips')) {
        if (title.contains('part 1') || title.contains('5.2.1')) return _kIeltsLessonAssets['5-2-1']!;
        if (title.contains('part 2') || title.contains('5.2.2')) return _kIeltsLessonAssets['5-2-2']!;
        if (title.contains('framework') || title.contains('5.2.3')) return _kIeltsLessonAssets['5-2-3']!;
        if (title.contains('before you start') || title.contains('5.2.4')) return _kIeltsLessonAssets['5-2-4']!;
        if (title.contains('introduction') || title.contains('5.2.5')) return _kIeltsLessonAssets['5-2-5']!;
        if (title.contains('overview') || title.contains('5.2.6')) return _kIeltsLessonAssets['5-2-6']!;
        if (title.contains('detail paragraphs') || title.contains('5.2.7')) return _kIeltsLessonAssets['5-2-7']!;
        if (title.contains('example') || title.contains('5.2.8')) return _kIeltsLessonAssets['5-2-8']!;
        if (title.contains('vocabulary') || title.contains('5.2.9')) return _kIeltsLessonAssets['5-2-9']!;
      }
      if (modName.contains('5.3') || title.contains('5.3.1')) {
        return _kIeltsLessonAssets['5-3-1']!;
      }
      if (modName.contains('task 2') && !modName.contains('tips')) {
        if (title.contains('part 1') || title.contains('5.4.1')) return _kIeltsLessonAssets['5-4-1']!;
        if (title.contains('part 2') || title.contains('5.4.2')) return _kIeltsLessonAssets['5-4-2']!;
        if (title.contains('essay structure') || title.contains('structure') || title.contains('5.4.3')) return _kIeltsLessonAssets['5-4-3']!;
        if (title.contains('before you start') || title.contains('5.4.4')) return _kIeltsLessonAssets['5-4-4']!;
        if (title.contains('introduction') || title.contains('5.4.5')) return _kIeltsLessonAssets['5-4-5']!;
        if (title.contains('body paragraphs') || title.contains('5.4.6')) return _kIeltsLessonAssets['5-4-6']!;
        if (title.contains('conclusion') || title.contains('5.4.7')) return _kIeltsLessonAssets['5-4-7']!;
        if (title.contains('example') || title.contains('5.4.8')) return _kIeltsLessonAssets['5-4-8']!;
        if (title.contains('vocabulary') || title.contains('5.4.9')) return _kIeltsLessonAssets['5-4-9']!;
      }
      if (modName.contains('5.5') || title.contains('5.5.1')) {
        return _kIeltsLessonAssets['5-5-1']!;
      }
    }

    // Unit 6 (Test Day & Beyond)
    if (modName.contains('test day') || modName.contains('6.')) {
      if (title.contains('bring on test day') || title.contains('6.1.1') || modName.contains('6.1')) return _kIeltsLessonAssets['6-1-1']!;
      if (title.contains('answer sheets') || title.contains('6.2.1') || modName.contains('6.2')) return _kIeltsLessonAssets['6-2-1']!;
      if (title.contains('farewell') || title.contains('results') || title.contains('6.3.1') || modName.contains('6.3')) return _kIeltsLessonAssets['6-3-1']!;
    }

    // 4. Try key using unitSortOrder and moduleSortOrder + (index + 1)
    final key = '$unitSortOrder-$moduleSortOrder-${index + 1}';
    if (_kIeltsLessonAssets.containsKey(key)) {
      return _kIeltsLessonAssets[key]!;
    }

    // 5. Fallback deterministic per index
    return _kIeltsFallbackAssets[index % _kIeltsFallbackAssets.length];
  }

  @override
  Widget build(BuildContext context, CourseModuleViewModel viewModel) {
    if (_isProfessionals) {
      return _buildProfessionalsCard();
    }
    return _buildCard();
  }

  Widget _buildProfessionalsCard() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEEEEF0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top illustration banner
              Container(
                width: double.infinity,
                height: 145,
                color: const Color(0xFFF7F2F8),
                child: Center(
                  child: SvgPicture.asset(
                    _profThumbnailAsset,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _profAmharicTitle,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Aeonik',
                                  color: Color(0xFF1A1A2E),
                                  height: 1.25,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _profEnglishSubtitle,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Aeonik',
                                  color: Color(0xFF888899),
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_rounded,
                                    size: 13,
                                    color: Color(0xFF888899),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '4 ደቂቃ',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Aeonik',
                                      color: Color(0xFF888899),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        _buildRadioIndicator(),
                      ],
                    ),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: onVideoTap,
                      child: Container(
                        width: double.infinity,
                        height: 44,
                        decoration: BoxDecoration(
                          color: _themeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.play_arrow_rounded,
                                color: Colors.white, size: 20),
                            const SizedBox(width: 6),
                            Text(
                              LocaleKeys.play_video.tr(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Aeonik',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildCard() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEEEEF0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTopRow(),
              _buildButtons(),
            ],
          ),
        ),
      );

  Widget _buildTopRow() => Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThumbnail(),
            const SizedBox(width: 12),
            Expanded(child: _buildTextColumn()),
            const SizedBox(width: 8),
            _buildRadioIndicator(),
          ],
        ),
      );

  Widget _buildThumbnail() => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 76,
          height: 68,
          child: SvgPicture.asset(
            _thumbnailAsset,
            fit: BoxFit.contain,
            placeholderBuilder: (_) => _placeholder(),
          ),
        ),
      );

  Widget _placeholder() => Container(
        color: _isIelts ? const Color(0xFFFFEBEE) : const Color(0xFFE8F5E9),
        child: Icon(
          Icons.play_circle_outline_rounded,
          color: _themeColor,
          size: 28,
        ),
      );

  Widget _buildTextColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            lesson.title ?? '',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Aeonik',
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.access_time_rounded,
                  size: 13, color: Color(0xFF888899)),
              const SizedBox(width: 3),
              Text(
                '${((lesson.id ?? 0) / 50).toInt()} ${LocaleKeys.min.tr()}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Aeonik',
                  color: Color(0xFF888899),
                ),
              ),
            ],
          ),
        ],
      );

  Widget _buildRadioIndicator() => Container(
        width: 22,
        height: 22,
        margin: const EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFDDDDEE), width: 1.5),
        ),
      );

  bool get _hasPractice {
    if (lesson.hasPractice ?? false) return true;
    if ((lesson.practicesCount ?? 0) > 0) return true;
    final title = (lesson.title ?? '').toLowerCase();
    final modName = (module?.name ?? '').toLowerCase();
    if (_isIelts) {
      // Unit 2 (Speaking)
      if (title.contains('2.2.4') ||
          (title.contains('example') && modName.contains('part 1'))) {
        return true;
      }
      if (title.contains('2.3.4') ||
          (title.contains('example') && modName.contains('part 2'))) {
        return true;
      }
      if (title.contains('2.4.4') ||
          (title.contains('example') && modName.contains('part 3'))) {
        return true;
      }
      // Unit 3 (Listening)
      if (title.contains('3.4.6') ||
          (title.contains('example') && modName.contains('section 2'))) {
        return true;
      }
      if (title.contains('3.5.5') ||
          (title.contains('example') && modName.contains('section 3'))) {
        return true;
      }
      if (title.contains('3.6.5') ||
          (title.contains('example') && modName.contains('section 4'))) {
        return true;
      }
      if (title.contains('3.7.1') ||
          (title.contains('tips') && (modName.contains('listening') || modName.contains('3.7')))) {
        return true;
      }
      // Unit 4 (Reading)
      if (title.contains('4.3.5') ||
          title.contains('labelling a diagram') ||
          (title.contains('diagram') && modName.contains('passage 1'))) {
        return true;
      }
      // Unit 5 (Writing)
      if (modName.contains('task 1') || modName.contains('5.2')) {
        if (title.contains('5.2.5') ||
            title.contains('5.2.6') ||
            title.contains('5.2.7') ||
            title.contains('5.2.8') ||
            (title.contains('introduction') && !modName.contains('5.1')) ||
            title.contains('overview') ||
            title.contains('detail paragraphs') ||
            (title.contains('example') && modName.contains('task 1'))) {
          return true;
        }
      }
      if (modName.contains('task 2') || modName.contains('5.4')) {
        if (title.contains('5.4.5') ||
            title.contains('5.4.6') ||
            title.contains('5.4.7') ||
            title.contains('5.4.8') ||
            title.contains('body paragraphs') ||
            title.contains('conclusion') ||
            (title.contains('introduction') && modName.contains('task 2')) ||
            (title.contains('example') && modName.contains('task 2'))) {
          return true;
        }
      }
      if (title.contains('5.2.5') ||
          title.contains('5.2.6') ||
          title.contains('5.2.7') ||
          title.contains('5.2.8') ||
          title.contains('5.4.5') ||
          title.contains('5.4.6') ||
          title.contains('5.4.7') ||
          title.contains('5.4.8')) {
        return true;
      }
      return false;
    }
    return _isKnownPracticeLesson(title, modName);
  }

  bool _isKnownPracticeLesson(String title, String modName) {
    // Unit 3
    if (title.contains('3.1.2') ||
        (title.contains('essential tips') &&
            modName.contains('listen and type'))) {
      return true;
    }
    if (title.contains('3.2.2') || title.contains('listen and complete')) {
      return true;
    }
    if (title.contains('3.2.3') || title.contains('listen and respond')) {
      return true;
    }
    if (title.contains('3.2.4') ||
        title.contains('summarize the conversation')) {
      return true;
    }
    // Unit 4
    if (title.contains('4.1.1') ||
        (title.contains('introduction') &&
            modName.contains('read and complete'))) {
      return true;
    }
    if (title.contains('4.2.2') ||
        title.contains('mastering your vocabulary')) {
      return true;
    }
    if (title.contains('4.2.3') || title.contains('how to spot fake words')) {
      return true;
    }
    if (title.contains('4.3.2') ||
        (title.contains('essential tips') &&
            modName.contains('fill in the blank'))) {
      return true;
    }
    if (title.contains('4.4.1') ||
        (title.contains('introduction') &&
            modName.contains('interactive reading'))) {
      return true;
    }
    if (title.contains('4.4.2') ||
        title.contains('complete the sentence')) {
      return true;
    }
    // Unit 5
    if (title.contains('5.1.2') ||
        (title.contains('essential tips') &&
            modName.contains('photo'))) {
      return true;
    }
    if (title.contains('5.2.1') ||
        (title.contains('introduction') &&
            modName.contains('writing sample'))) {
      return true;
    }
    if (title.contains('5.2.2') ||
        (title.contains('essential tips') &&
            modName.contains('writing sample'))) {
      return true;
    }
    if (title.contains('5.3.2') ||
        title.contains('mastering part 1')) {
      return true;
    }
    // Unit 6
    if (title.contains('6.1.2') ||
        title.contains('common mistakes') ||
        title.contains('high-scoring')) {
      return true;
    }
    if (title.contains('6.2.1') ||
        (title.contains('introduction') &&
            modName.contains('read then speak'))) {
      return true;
    }
    if (title.contains('6.2.2') ||
        (title.contains('essential tips') &&
            modName.contains('read then speak'))) {
      return true;
    }
    if (title.contains('6.3.1') ||
        title.contains('introduction and basics') ||
        (title.contains('introduction') &&
            modName.contains('speaking sample'))) {
      return true;
    }
    if (title.contains('6.3.2') ||
        (title.contains('tips and strategies') &&
            modName.contains('speaking sample'))) {
      return true;
    }
    if (title.contains('6.4.2') ||
        title.contains('35-second') ||
        title.contains('formula')) {
      return true;
    }
    if (title.contains('6.4.3') ||
        title.contains('boosting your score') ||
        title.contains('handling mistakes')) {
      return true;
    }
    return false;
  }

  Widget _buildButtons() {
    if (!_hasPractice) {
      return _buildSinglePlayButton();
    }
    return _buildDualButtons();
  }

  Widget _buildSinglePlayButton() => GestureDetector(
        onTap: onVideoTap,
        child: Container(
          width: double.infinity,
          height: 44,
          margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          decoration: BoxDecoration(
            color: _themeColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 6),
              Text(
                LocaleKeys.play_video.tr(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Aeonik',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildDualButtons() => Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onVideoTap,
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: _themeColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.play_arrow_rounded,
                          color: Colors.white, size: 18),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          LocaleKeys.play_video.tr(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Aeonik',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: onPracticeTap,
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFDDDDEE)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        color: _themeColor,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          LocaleKeys.practice_test.tr(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Aeonik',
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
