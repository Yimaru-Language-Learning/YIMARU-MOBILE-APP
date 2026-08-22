import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:waveform_recorder/waveform_recorder.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/course_practice.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../../../app/app.locator.dart';
import '../../../models/practice_question.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/audio_player_service.dart';
import '../../../services/authentication_service.dart';
import '../../../services/cache_image_service.dart';
import '../../../services/course_service.dart';
import '../../../services/status_checker_service.dart';
import '../../../services/voice_recorder_service.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/helper_functions.dart';

class CoursePracticeViewModel extends ReactiveViewModel
    with FormStateHelper
    implements FormViewModel {
  // Dependency injection

  final _apiService = locator<ApiService>();

  final _dialogService = locator<DialogService>();

  final _courseService = locator<CourseService>();

  final _cacheImageService = locator<CacheImageService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _audioPlayerService = locator<AudioPlayerService>();

  final _voiceRecorderService = locator<VoiceRecorderService>();

  final _authenticationService = locator<AuthenticationService>();

  CoursePracticeViewModel() {
    _listenToAudio();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _courseService,
        _audioPlayerService,
        _voiceRecorderService,
        _authenticationService
      ];

  // User
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // AudioPlayer
  AudioPlayer get _player => _audioPlayerService.player;

  AudioPlayer get player => _player;

  Duration _duration = Duration.zero;

  Duration _position = Duration.zero;

  Duration get position => _position;

  Duration get duration => _duration;

  double get progress {
    if (_duration.inMilliseconds == 0) return 0;
    return _position.inMilliseconds / _duration.inMilliseconds;
  }

  WaveformRecorderController get _waveController =>
      _voiceRecorderService.waveController;

  WaveformRecorderController get waveController => _waveController;

  // Voice recorder state
  VoiceRecordingState get _recordingState =>
      _voiceRecorderService.recordingState;

  VoiceRecordingState get recordingState => _recordingState;

  // Counter time
  DateTime? _countdown;

  DateTime? get countdown => _countdown;

  // Draggable
  bool _isDrag = false;

  bool get isDrag => _isDrag;

  List<int> _usedHeadingIds = [];

  List<int> get usedHeadingIds => _usedHeadingIds;

  List<dynamic> _matchedAnswers = [];

  List<dynamic> get matchedAnswers => _matchedAnswers;

  // Busy object
  String? _busyObject;

  String? get busyObject => _busyObject;

  Voice? _playing;

  Voice? get playing => _playing;

  // Text field controllers
  final Map<String, String> _controllers = {};

  Map<String, String> get controllers => _controllers;

  void updateAnswer(String id, String value) {
    _controllers[id] = value;
    notifyListeners();
  }

  // Speaking state
  bool _isSpeaking = false;

  bool get isSpeaking => _isSpeaking;

// Course practices
  bool _focusPractice = false;

  bool get focusPractice => _focusPractice;

  List<CoursePractice> _practices = [];

  List<CoursePractice> get practices => _practices;

  // Practice questions
  String? _refreshedUrl;

  String? get refreshedUrl => _refreshedUrl;

  bool _isSectionStart = false;

  bool get isSectionStart => _isSectionStart;

  bool _isSectionEnd = false;

  bool get isSectionEnd => _isSectionEnd;

  String? _stimulusBlockKey;

  String? get stimulusBlockKey => _stimulusBlockKey;

  int _currentPractice = 0;

  int get currentPractice => _currentPractice;

  int _currentQuestion = 0;

  int get currentQuestion => _currentQuestion;

  List<PracticeQuestion> _questions = [];

  List<PracticeQuestion> get questions => _questions;

  final List<Map<String, dynamic>> _questionParams = [
    {
      'label': 'Duolingo Speaking 01',
      'type': CoursePracticeType.speaking,
      'intro_title': LocaleKeys.speak_about_photo.tr(),
      'outro_title': LocaleKeys.practice_completed.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
      'intro_subtitle': LocaleKeys.prepare_speak_30s.tr()
    },
    {
      'label': 'Duolingo Speaking 02',
      'intro_title': LocaleKeys.read_then_speak.tr(),
      'type': CoursePracticeType.speaking,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_subtitle': LocaleKeys.speak_given_topic.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'label': 'Duolingo Speaking 03',
      'intro_title': LocaleKeys.speaking_sample.tr(),
      'type': CoursePracticeType.speaking,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_subtitle': LocaleKeys.speak_1_3m.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'label': 'Duolingo Speaking 04',
      'type': CoursePracticeType.speaking,
      'intro_title': LocaleKeys.interactive_speaking.tr(),
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_subtitle': LocaleKeys.answer_short_questions.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'label': 'Duolingo Writing 05',
      'type': CoursePracticeType.writing,
      'intro_title': LocaleKeys.write_about_photo.tr(),
      'outro_title': LocaleKeys.practice_completed.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
      'intro_subtitle': LocaleKeys.write_short_description_photo.tr()
    },
    {
      'label': 'Duolingo Writing 06',
      'intro_title': LocaleKeys.writing_sample.tr(),
      'type': CoursePracticeType.writing,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
      'intro_subtitle': LocaleKeys.write_longer_response_shared.tr()
    },
    {
      'label': 'Duolingo Writing 07',
      'type': CoursePracticeType.writing,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_title': LocaleKeys.interactive_writing_part1.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
      'intro_subtitle': LocaleKeys.write_short_simple_sentences.tr()
    },
    {
      'label': 'Duolingo Writing 08',
      'type': CoursePracticeType.writing,
      'intro_title': LocaleKeys.interactive_writing_part2.tr(),
      'outro_title': LocaleKeys.practice_completed.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
      'intro_subtitle': LocaleKeys.continue_writing_related.tr()
    },
    {
      'label': 'Duolingo Listening 09',
      'intro_title': LocaleKeys.listen_and_type.tr(),
      'type': CoursePracticeType.listening,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_subtitle': LocaleKeys.hear_short_audio_type.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'label': 'Duolingo Listening 10',
      'type': CoursePracticeType.listening,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_title': LocaleKeys.interactive_listening_part1.tr(),
      'intro_subtitle': LocaleKeys.listen_complete_missing.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'label': 'Duolingo Listening 11',
      'type': CoursePracticeType.listening,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_title': LocaleKeys.interactive_listening_part2.tr(),
      'intro_subtitle': LocaleKeys.listen_choose_correct.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'label': 'Duolingo Listening 12',
      'type': CoursePracticeType.listening,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_title': LocaleKeys.interactive_listening_part3.tr(),
      'intro_subtitle': LocaleKeys.write_summary_conversation.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'label': 'Duolingo Reading 13',
      'intro_title': LocaleKeys.read_and_select.tr(),
      'type': CoursePracticeType.reading,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
      'intro_subtitle': LocaleKeys.read_select_correct.tr(),
    },
    {
      'label': 'Duolingo Reading 14',
      'intro_title': LocaleKeys.fill_in_blank.tr(),
      'type': CoursePracticeType.reading,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_subtitle': LocaleKeys.complete_sentences_filling.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'label': 'Duolingo Reading 15',
      'type': CoursePracticeType.reading,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_title': LocaleKeys.interactive_reading_complete_sentence.tr(),
      'intro_subtitle': LocaleKeys.read_passage_complete_interactive.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'label': 'Duolingo Reading 16',
      'type': CoursePracticeType.reading,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_title': LocaleKeys.interactive_reading_complete_passage.tr(),
      'intro_subtitle': LocaleKeys.read_passage_complete_interactive.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'label': 'Duolingo Reading 17',
      'type': CoursePracticeType.reading,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_title': LocaleKeys.interactive_reading_identify_idea.tr(),
      'intro_subtitle': LocaleKeys.read_passage_complete_interactive.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'label': 'Duolingo Reading 18',
      'type': CoursePracticeType.reading,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_title': LocaleKeys.interactive_reading_title_passage.tr(),
      'intro_subtitle': LocaleKeys.read_passage_complete_interactive.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'label': 'Duolingo Reading 19',
      'type': CoursePracticeType.reading,
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_title': LocaleKeys.interactive_reading_highlight_answer.tr(),
      'intro_subtitle': LocaleKeys.read_passage_complete_interactive.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'label': 'Duolingo Reading 20',
      'type': CoursePracticeType.reading,
      'intro_title': LocaleKeys.read_and_complete.tr(),
      'outro_title': LocaleKeys.practice_completed.tr(),
      'intro_subtitle': LocaleKeys.read_passage_complete_interactive.tr(),
      'outro_subtitle': LocaleKeys.great_work_session.tr(),
    },
    {
      'subtitle': '4–5 minutes',
      'label': 'IELTS Speaking 21',
      'type': CoursePracticeType.ielts,
      'instruction_title': 'What to expect:',
      'title': LocaleKeys.ielts_speaking_interview.tr(),
      'instruction_subtitle':
          ' You’ll answer simple questions about everyday topics',
    },
    {
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Speaking 22',
      'type': CoursePracticeType.ielts,
      'title': LocaleKeys.ielts_speaking_cue_card_part1.tr(),
      'subtitle':
          '1 minute to prepare and make notes. Then you speak for 1–2 minutes on the topic.',
    },
    {
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Speaking 23',
      'type': CoursePracticeType.ielts,
      'title': LocaleKeys.ielts_speaking_cue_card_part2.tr(),
      'subtitle':
          'The examiner asks related questions. You answer with more detail and opinions.',
    },
    {
      'label': 'IELTS Speaking 24',
      'type': CoursePracticeType.ielts,
      'title': LocaleKeys.ielts_speaking_discussion.tr(),
      'instruction_title': 'What to expect:',
      'subtitle': 'The discussion lasts about 4–5 minutes.',
      'instruction_subtitle':
          'This is a two-way discussion with the examiner, linked to your Part 2 topic. You’ll talk about more abstract ideas and opinions.',
    },
    {
      'subtitle': '',
      'label': 'IELTS Writing 25',
      'type': CoursePracticeType.ielts,
      'title': LocaleKeys.ielts_writing_part1.tr(),
      'instruction_title': 'What to expect:',
      'instruction_subtitle':
          'Summarize a graph or chart in ~150 words with a formal style.',
    },
    {
      'subtitle': '',
      'label': 'IELTS Writing 26',
      'type': CoursePracticeType.ielts,
      'title': LocaleKeys.ielts_writing_part2.tr(),
      'instruction_title': 'What to expect:',
      'instruction_subtitle':
          'Give your opinion with reasons.  Write ~ 250 words.',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'title': LocaleKeys.form_completion.tr(),
      'label': 'IELTS Listening 27',
      'type': CoursePracticeType.ielts,
      'outro_title': LocaleKeys.part_completed.tr(args: ['1']),
      'outro_subtitle':
          LocaleKeys.finished_part_click_next.tr(args: ['1', '2']),
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'title': LocaleKeys.note_completion.tr(),
      'label': 'IELTS Listening 28',
      'type': CoursePracticeType.ielts,
      'outro_title': LocaleKeys.part_completed.tr(args: ['1']),
      'outro_subtitle':
          LocaleKeys.finished_part_click_next.tr(args: ['1', '2']),
    },
    {
      'subtitle': '',
      'title': LocaleKeys.short_answer.tr(),
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 29',
      'type': CoursePracticeType.ielts,
      'outro_title': LocaleKeys.part_completed.tr(args: ['1']),
      'outro_subtitle':
          LocaleKeys.finished_part_click_next.tr(args: ['1', '2']),
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 30',
      'type': CoursePracticeType.ielts,
      'outro_title': LocaleKeys.part_completed.tr(args: ['1']),
      'title': 'IELTS Listening - Table completion',
      'outro_subtitle':
          LocaleKeys.finished_part_click_next.tr(args: ['1', '2']),
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 31',
      'type': CoursePracticeType.ielts,
      'outro_title': LocaleKeys.part_completed.tr(args: ['2']),
      'title': LocaleKeys.map_plan_diagram_completion.tr(),
      'outro_subtitle':
          LocaleKeys.finished_part_click_next.tr(args: ['2', '3']),
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'title': LocaleKeys.diagram_labeling.tr(),
      'label': 'IELTS Listening 32',
      'type': CoursePracticeType.ielts,
      'outro_title': LocaleKeys.part_completed.tr(args: ['2']),
      'outro_subtitle':
          LocaleKeys.finished_part_click_next.tr(args: ['2', '3']),
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 33',
      'type': CoursePracticeType.ielts,
      'outro_title': LocaleKeys.part_completed.tr(args: ['3']),
      'title': 'IELTS Listening Multiple choice',
      'outro_subtitle':
          LocaleKeys.finished_part_click_next.tr(args: ['3', '4']),
    },
    {
      'subtitle': '',
      'title': LocaleKeys.matching.tr(),
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 34',
      'type': CoursePracticeType.ielts,
      'outro_title': LocaleKeys.part_completed.tr(args: ['3']),
      'outro_subtitle':
          LocaleKeys.finished_part_click_next.tr(args: ['3', '4']),
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 35',
      'type': CoursePracticeType.ielts,
      'outro_title': LocaleKeys.part_completed.tr(args: ['4']),
      'outro_subtitle': LocaleKeys.part_completed.tr(args: ['4']),
      'title': 'IELTS Listening - Summary Completion',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Reading 36',
      'title': LocaleKeys.form_completion.tr(),
      'type': CoursePracticeType.ielts,
      'outro_title': LocaleKeys.part_completed.tr(args: ['4']),
      'outro_subtitle': LocaleKeys.part_completed.tr(args: ['4']),
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'title': LocaleKeys.paragraph_choice.tr(),
      'label': 'IELTS Reading 37',
      'type': CoursePracticeType.ielts,
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Reading 38',
      'type': CoursePracticeType.ielts,
      'title': LocaleKeys.diagram_labeling.tr(),
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Reading 39',
      'type': CoursePracticeType.ielts,
      'title': LocaleKeys.form_completion.tr(),
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Reading 40',
      'type': CoursePracticeType.ielts,
      'title': 'Sentence Ending Matching',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Reading 41',
      'type': CoursePracticeType.ielts,
      'title': LocaleKeys.true_false_not_given.tr(),
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Reading 42',
      'type': CoursePracticeType.ielts,
      'title': 'IELTS Reading -Multiple choice',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Reading 43',
      'title': LocaleKeys.yes_no_not_given.tr(),
      'type': CoursePracticeType.ielts,
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'title': LocaleKeys.heading_matching.tr(),
      'label': 'IELTS Reading 44',
      'type': CoursePracticeType.ielts,
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'title': LocaleKeys.feature_matching.tr(),
      'label': 'IELTS Reading 45',
      'type': CoursePracticeType.ielts,
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Reading 46',
      'type': CoursePracticeType.ielts,
      'title': 'IELTS Reading - Table completion',
    }
  ];

  List<Map<String, dynamic>> get questionParams => _questionParams;

  // Selected question param
  Map<String, dynamic> _selectedQuestionParam = {
    'label': '${LocaleKeys.speaking_practice.tr()} 01',
    'intro_title': LocaleKeys.speak_about_photo.tr(),
    'type': CoursePracticeType.speaking,
    'outro_title': LocaleKeys.practice_completed.tr(),
    'outro_subtitle': LocaleKeys.great_work_session.tr(),
    'intro_subtitle': LocaleKeys.prepare_speak_30s.tr(),
  };

  Map<String, dynamic> get selectedQuestionParam => _selectedQuestionParam;

  // Practice answers
  final List<Map<String, dynamic>> _answers = [];

  List<Map<String, dynamic>> get answers => _answers;

  Map<String, dynamic> _selectedOption = {};

  Map<String, dynamic> get selectedOption => _selectedOption;

  //
  int _start = 0;

  int get start => _start;

  int _end = 0;

  int get end => _end;

  // Play count
  int _playCount = 2;

  int get playCount => _playCount;

  // Show answer
  bool _showAnswer = false;

  bool get showAnswer => _showAnswer;

  // In-app navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  final PageController _questionsController = PageController();

  PageController get questionsController => _questionsController;

  final PageController _questionController = PageController();

  PageController get questionController => _questionController;

  int _variants = 0;

  int get variants => _variants;

  int _variant = 0;

  int get variant => _variant;



  // Counter time
  void setCountdown(int durationInSeconds) {
    _countdown = DateTime.now().add(
      Duration(
        minutes: getMinutes(durationInSeconds),
        seconds: getSeconds(durationInSeconds),
      ),
    );
    // rebuildUi();
  }

  void resetCountdown() {
    _countdown = null;
  }

  // Play count
  void setPlayCount({int? count}) {
    if (count != null) {
      _playCount = count;
    } else {
      _playCount--;
    }
    rebuildUi();
  }

  void resetPlayCount(int count) {
    _playCount = count;
    rebuildUi();
  }

  //Is drag
  void setIsDrag(bool value) {
    _isDrag = value;
    rebuildUi();
  }

  // Practice
  void setPracticeFocus() {
    _focusPractice = true;
    rebuildUi();
  }

  void resetPracticeFocus() {
    _focusPractice = false;
    rebuildUi();
  }

  void setSpeakingState() {
    _isSpeaking = true;
    rebuildUi();
  }

  void resetSpeakingState() {
    _isSpeaking = false;
    rebuildUi();
  }

  // Show answer
  void setShowAnswer() {
    _showAnswer = true;
    rebuildUi();
  }

  // Reset values
  void resetValues() {
    _end = 0;
    _start = 0;
    _variant = 0;
    _variants = 0;
    _playCount = 2;
    _answers.clear();
    _countdown = null;
    _isSpeaking = false;
    _controllers.clear();
    _showAnswer = false;
    _focusPractice = false;
    _selectedOption.clear();
    rebuildUi();
  }

  // Question param
  Future<void> setSingleQuestionIntros(
      {required int id, required BuildContext context}) async {
    if (id == 12 /*Duolingo - Speak about the photo*/) {
      // await refreshQuestionUrl(_questions[_currentQuestion]);
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (id == 13 /*Duolingo - Read then speak*/) {
      _selectedQuestionParam = _questionParams.elementAt(1);
    } else if (id == 36 /*Duolingo - Speaking sample*/) {
      _selectedQuestionParam = _questionParams.elementAt(2);
    } else if (id == 14 /*Duolingo - Interactive speaking*/) {
      _selectedQuestionParam = _questionParams.elementAt(3);
    } else if (id == 22 /*Duolingo - Speak about the photo*/) {
      _selectedQuestionParam = _questionParams.elementAt(4);
    } else if (id == 23 /*Duolingo - Writing sample*/) {
      _selectedQuestionParam = _questionParams.elementAt(5);
    } else if (id == 24 /*Duolingo - Interactive writing part 1*/) {
      _selectedQuestionParam = _questionParams.elementAt(6);
    } else if (id == 25 /*Duolingo - Interactive writing part 2*/) {
      _selectedQuestionParam = _questionParams.elementAt(7);
    } else if (id == 28 /*Duolingo - Listen and type*/) {
      _selectedQuestionParam = _questionParams.elementAt(8);
    } else if (id == 56 /*Duolingo - Interactive listening part 1*/) {
      _selectedQuestionParam = _questionParams.elementAt(9);
    } else if (id == 29 /*Duolingo - Interactive listening part 2*/) {
      _selectedQuestionParam = _questionParams.elementAt(10);
    } else if (id == 57 /*Duolingo - Interactive listening part 3*/) {
      _selectedQuestionParam = _questionParams.elementAt(11);
    } else if (id == 49 /*Duolingo - Read and select*/) {
      _selectedQuestionParam = _questionParams.elementAt(12);
    } else if (id == 3 /*Duolingo - Fill in the blank*/) {
      _selectedQuestionParam = _questionParams.elementAt(13);
    } else if (id ==
        51 /*Duolingo - Interactive reading - complete the sentence*/) {
      _selectedQuestionParam = _questionParams.elementAt(14);
    } else if (id ==
        52 /*Duolingo - Interactive reading - complete the passage*/) {
      _selectedQuestionParam = _questionParams.elementAt(15);
    } else if (id ==
        53 /*Duolingo - Interactive reading - identify the idea*/) {
      _selectedQuestionParam = _questionParams.elementAt(16);
    } else if (id ==
        54 /*Duolingo - Interactive reading - title the passage*/) {
      _selectedQuestionParam = _questionParams.elementAt(17);
    } else if (id ==
        55 /*Duolingo - Interactive reading - highlight the answer*/) {
      _selectedQuestionParam = _questionParams.elementAt(18);
    } else if (id == 50 /*Duolingo - Read and complete*/) {
      _selectedQuestionParam = _questionParams.elementAt(19);
    } else if (id == 17 /*IELTS Speaking – Interview*/) {
      _selectedQuestionParam = _questionParams.elementAt(20);
    } else if (id == 18 /*IELTS Speaking – Cue Card Part 1*/) {
      _selectedQuestionParam = _questionParams.elementAt(21);
    } else if (id == 20 /*IELTS Speaking – Cue Card Part 2*/) {
      _selectedQuestionParam = _questionParams.elementAt(22);
    } else if (id == 21 /*IELTS Speaking – Discussion*/) {
      _selectedQuestionParam = _questionParams.elementAt(23);
    } else if (id == 26 /*IELTS Writing – Part 1*/) {
      _selectedQuestionParam = _questionParams.elementAt(24);
    } else if (id == 27 /*IELTS Writing – Part 2*/) {
      _selectedQuestionParam = _questionParams.elementAt(25);
    }

    // Test
    /*else if (id == 61 */ /*Map/Plan/Diagram Completion*/ /*) {
      _selectedQuestionParam = _questionParams.elementAt(30);
      int responseLastSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      String image =
          _questions[_currentQuestion].dynamicPayload?.stimulus?.first.value;
      await cacheNetworkImage(image: image, context: context);
      setCountdown(responseLastSec);
    }*/
  }

  Future<void> setSectionQuestionIntros(
      {required int id, required BuildContext context}) async {
    if (id == 40 /*IELTS Listening - Form Completion*/) {
      _selectedQuestionParam = _questionParams.elementAt(26);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 42 /*IELTS Listening - Note Completion*/) {
      _selectedQuestionParam = _questionParams.elementAt(27);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 69 /*IELTS Listening - Short Answer*/) {
      _selectedQuestionParam = _questionParams.elementAt(28);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 43 /*IELTS Listening - Table completion*/) {
      _selectedQuestionParam = _questionParams.elementAt(29);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 61 /*IELTS Listening - Map/Plan/Diagram Completion*/) {
      _selectedQuestionParam = _questionParams.elementAt(30);
      int responseLastSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      String image =
          _questions[_currentQuestion].dynamicPayload?.stimulus?.first.value;
      await cacheNetworkImage(image: image, context: context);
      setCountdown(responseLastSec);
    } else if (id == 31 /*IELTS Listening - Diagram labeling*/) {
      _selectedQuestionParam = _questionParams.elementAt(31);
      int responseLastSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.last
          .value['seconds'];
      String image =
          _questions[_currentQuestion].dynamicPayload?.stimulus?.first.value;
      await cacheNetworkImage(image: image, context: context);
      setCountdown(responseLastSec);
    } else if (id == 62 /*IELTS Listening - Multiple choice*/) {
      _selectedQuestionParam = _questionParams.elementAt(32);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 33 /*IELTS Listening - Matching*/) {
      _selectedQuestionParam = _questionParams.elementAt(33);
      int responseLastSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.last
          .value['seconds'];
      setCountdown(responseLastSec);
    } else if (id == 34 /*IELTS Listening - Summary completion*/) {
      _selectedQuestionParam = _questionParams.elementAt(34);
      int responseLastSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseLastSec);
    } else if (id == 35 /*IELTS Listening - Sentence completion*/) {
      _selectedQuestionParam = _questionParams.elementAt(35);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 46 /*IELTS Reading - Paragraph choice*/) {
      _selectedQuestionParam = _questionParams.elementAt(36);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 58 /*IELTS Reading - Diagram Labeling*/) {
      _selectedQuestionParam = _questionParams.elementAt(37);
      int responseLastSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      String image =
          _questions[_currentQuestion].dynamicPayload?.stimulus?[1].value;
      await cacheNetworkImage(image: image, context: context);
      setCountdown(responseLastSec);
    } else if (id == 63 /*IELTS Reading - Summary completion*/) {
      _selectedQuestionParam = _questionParams.elementAt(38);
      int responseLastSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseLastSec);
    } else if (id == 47 /*IELTS Reading - Sentence Ending Matching*/) {
      _selectedQuestionParam = _questionParams.elementAt(39);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 48 /*IELTS Reading - True / False / Not Given*/) {
      _selectedQuestionParam = _questionParams.elementAt(40);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 64 /*IELTS Reading - IELTS Reading - Multiple choice*/) {
      _selectedQuestionParam = _questionParams.elementAt(41);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 59 /*IELTS Reading - Yes / No / Not Given*/) {
      _selectedQuestionParam = _questionParams.elementAt(42);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 60 /*IELTS Reading - Heading Matching*/) {
      _selectedQuestionParam = _questionParams.elementAt(43);
      final count = questions[currentQuestion]
          .dynamicPayload!
          .stimulus![1]
          .value['right']
          .length;

      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];

      _usedHeadingIds.clear();
      _matchedAnswers = List.filled(count, null);

      setCountdown(responseFirstSec);
    } else if (id == 65 /*IELTS Reading - Feature Matching*/) {
      _selectedQuestionParam = _questionParams.elementAt(44);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 68 /*IELTS Reading - Table completion*/) {
      _selectedQuestionParam = _questionParams.elementAt(45);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else {
      // _selectedQuestionParam = _questionParams.elementAt(13);
    }
  }

  // Selected option
  bool isSelectedOption(Map<String, dynamic> value) =>
      _selectedOption['id'] == value['id'];

  void setSelectedOption(Map<String, dynamic> value) {
    _selectedOption = value;
    rebuildUi();
  }

  // Selected option
  bool isSelectedChoice({
    required String number,
    required Map<String, dynamic> answer,
  }) {
    // Single
    return _selectedOption[number] == answer;
  }

  void setSelectedChoice({
    required String number,
    required Map<String, dynamic> answer,
  }) {
    Map<String, dynamic> option = {number: answer};

    _selectedOption.addAll(option);

    rebuildUi();
  }

  void setSelectedDropdown(
    Map<String, dynamic> answer,
  ) {
    _selectedOption.addAll(answer);

    rebuildUi();
  }

  // Voice recorder
  Future<void> stopRecording() async {
    try {
      await _audioPlayerService.stop();
      await _voiceRecorderService.stopRecording();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> stopAudio() async =>
      await runBusyFuture(_stopAudio(), busyObject: StateObjects.stopAudio);

  Future<void> _stopAudio() async => await _audioPlayerService.stop();

  Future<void> startRecording() async => await runBusyFuture(_startRecording(),
      busyObject: StateObjects.recordCoursePracticeAnswer);

  Future<void> _startRecording() async {
    await _audioPlayerService.stop();
    await _voiceRecorderService.startRecording();
  }

  // Play practice audio
  void _listenToAudio() {
    _audioPlayerService.stateStream.listen((state) {
      if (PlayerState.completed == state) {
        if (_isSpeaking) {
          // _isSpeaking = false;

          if (_questions[_currentQuestion].questionTypeDefinitionId == 20) {
            nextScreen();
            startRecording();
          } else if (_questions[_currentQuestion].questionTypeDefinitionId ==
              14) {
            nextDuolingoSpeakingVariantScreen();
          } else if (_questions[_currentQuestion].questionTypeDefinitionId ==
              17) {
            nextIeltsSpeakingVariantScreen();
          } else if (_questions[_currentQuestion].questionTypeDefinitionId ==
              21) {
            nextIeltsSpeakingVariantScreen();
            startRecording();
          }
        }
      }
    });
    _audioPlayerService.durationStream.listen((dur) {
      if (dur.inMilliseconds > 0) {
        _duration = dur;
        rebuildUi();
      }
    });

    _audioPlayerService.positionStream.listen((pos) {
      _position = pos;
      rebuildUi();
    });
  }

  Future<void> playVoicePrompt(String question) async =>
      await runBusyFuture(_playVoicePrompt(question),
          busyObject: StateObjects.coursePracticePrompt);

  Future<void> _playVoicePrompt(String question) async =>
      await _audioPlayerService.playUrl(question);

  Future<void> replayVoicePrompt(PracticeQuestion question) async =>
      await _audioPlayerService
          .playUrl(question.dynamicPayload?.stimulus?.first.value ?? '');

  Future<void> playResult(
      {required Voice voice, required Map<String, dynamic> answer}) async {
    setResultBusyObject(playing: voice, object: answer['busy_object']);

    await playResultAudio(voice: voice, answer: answer);
  }

  Future<void> playResultAudio(
          {required Map<String, dynamic> answer, required Voice voice}) async =>
      await runBusyFuture(_playResultAudio(voice: voice, answer: answer),
          busyObject: answer['busy_object']);

  Future<void> _playResultAudio(
      {required Map<String, dynamic> answer, required Voice voice}) async {
    if (voice == Voice.recorded) {
      await _audioPlayerService.playLocal(answer['recorded_voice_answer']);
    } else {
      await _audioPlayerService.playUrl(answer['sample_voice_answer']);
    }
  }

  Future<void> playReview(
      {required String audio, required String busyObject}) async {
    setReviewBusyObject(busyObject);

    await playReviewAudio(audio: audio, busyObject: busyObject);
  }

  Future<void> playReviewAudio(
          {required String audio, required String busyObject}) async =>
      await runBusyFuture(_playReview(audio), busyObject: busyObject);

  Future<void> _playReview(String audio) async =>
      await _audioPlayerService.playUrl(audio);

  Future<void> pauseAudio() async {
    await _audioPlayerService.pause();
  }

  // Set busy object
  void setResultBusyObject({required String object, required Voice playing}) {
    _playing = playing;
    _busyObject = object;
    rebuildUi();
  }

  void setReviewBusyObject(String object) {
    _busyObject = object;
    rebuildUi();
  }

  // Dialogue
  Future<void> showAbortDialog(String passage) async =>
      await _dialogService.showDialog(
        title: LocaleKeys.passage.tr(),
        buttonTitle: LocaleKeys.close.tr(),
        description: passage,
        barrierDismissible: true,
        cancelTitleColor: kcDarkGrey,
        buttonTitleColor: kcPrimaryColor,
      );

  // Set highlight
  void setHighlight({required int end, required int start}) {
    _end = end;
    _start = start;
  }

  // Cache image
  Future<void> cacheNetworkImage(
          {required String image, required BuildContext context}) async =>
      await runBusyFuture(_cacheNetworkImage(image: image, context: context),
          busyObject: StateObjects.cacheImage);

  Future<void> _cacheNetworkImage(
          {required String image, required BuildContext context}) async =>
      await _cacheImageService.cacheNetworkImage(
          context: context, image: image);

  // In-app navigation

  // Duolingo speaking answer
  Future<void> setSpeakingAnswer(
      {required String sample, required String number}) async {
    await stopRecording();
    _answers.add({
      'number': number,
      'busy_object': number,
      'sample_voice_answer': sample,
      'recorded_voice_answer': await _voiceRecorderService.getRecordedAudio(),
    });
    nextScreen();
  }

  // Duolingo speaking answer 4
  Future<void> setDuolingoSpeakingAnswer4(
          {required String audio,
          required int duration,
          required String sample,
          required String question}) async =>
      await runBusyFuture(
          _setDuolingoSpeakingAnswer4(
            audio: audio,
            sample: sample,
            duration: duration,
            question: question,
          ),
          busyObject: StateObjects.duolingoSpeaking4Variant);

  Future<void> _setDuolingoSpeakingAnswer4(
      {required String audio,
      required int duration,
      required String sample,
      required String question}) async {
    int variants = _variants + 1;
    await stopRecording();
    _answers.add({
      'question': question,
      'number': variants.toString(),
      'sample_voice_answer': sample,
      'busy_object': variants.toString(),
      'recorded_voice_answer': await _voiceRecorderService.getRecordedAudio(),
    });
    if (_variants == 2) {
      nextScreen();
    } else {
      _variants++;
      _variant = 0;
      _isSpeaking = true;
      setCountdown(duration);
      await playVoicePrompt(audio);
    }
  }

  Future<void> setListeningAnswer1(
          {required int duration,
          required String sample,
          required String answer,
          required String question}) async =>
      await runBusyFuture(
          _setListeningAnswer1(
            answer: answer,
            sample: sample,
            duration: duration,
            question: question,
          ),
          busyObject: StateObjects.listening1Variant);

  Future<void> _setListeningAnswer1(
      {required int duration,
      required String sample,
      required String answer,
      required String question}) async {
    await _audioPlayerService.stop();
    _answers.add({
      'sample': sample,
      'response': answer,
      'question': question,
    });
    if (_variants == 4) {
      nextScreen();
    } else {
      _variants++;
      _playCount = 2;
      _focusPractice = false;
      setCountdown(duration);
    }
  }

  Future<void> setListeningAnswer3(
          {required int duration,
          required String sample,
          required String answer,
          required String question,
          required BuildContext context}) async =>
      await runBusyFuture(
          _setListeningAnswer3(
            answer: answer,
            sample: sample,
            context: context,
            duration: duration,
            question: question,
          ),
          busyObject: StateObjects.listening3Variant);

  Future<void> _setListeningAnswer3(
      {required int duration,
      required String sample,
      required String answer,
      required String question,
      required BuildContext context}) async {
    await stopRecording();
    _answers.add({
      'sample': sample,
      'response': answer,
      'question': question,
    });
    if (_variants == 4) {
      if (_currentQuestion == _questions.length - 1) {
        nextScreen();
      } else {
        await nextQuestion(context);
      }
    } else {
      _variants++;
      _playCount = 1;
      _showAnswer = false;
      setCountdown(duration);
      _selectedOption.clear();
    }
  }

  Future<void> setReadingAnswer1({
    required int duration,
    required String sample,
    required String answer,
    required String question,
  }) async =>
      await runBusyFuture(
          _setReadingAnswer1(
            answer: answer,
            sample: sample,
            duration: duration,
            question: question,
          ),
          busyObject: StateObjects.reading1Variant);

  Future<void> _setReadingAnswer1({
    required int duration,
    required String sample,
    required String answer,
    required String question,
  }) async {
    await stopRecording();
    _answers.add({
      'sample': sample,
      'response': answer,
      'question': question,
    });
    if (_variants == 4) {
      nextScreen();
    } else {
      _variants++;
      _playCount = 1;
      setCountdown(duration);
      _selectedOption.clear();
    }
  }

  Future<void> setReadingAnswer7({
    required int end,
    required int start,
    required int duration,
    required String sample,
    required String question,
  }) async =>
      await runBusyFuture(
          _setReadingAnswer7(
            end: end,
            start: start,
            sample: sample,
            duration: duration,
            question: question,
          ),
          busyObject: StateObjects.reading7Variant);

  Future<void> _setReadingAnswer7({
    required int end,
    required int start,
    required int duration,
    required String sample,
    required String question,
  }) async {
    _answers.add({
      'sample': sample,
      'response_end': end,
      'question': question,
      'response_start': start,
    });
    if (_variants == 1) {
      nextScreen();
    } else {
      _end = 0;
      _start = 0;
      _variants++;
      setCountdown(duration);
    }
  }

  Future<void> setReadingAnswer8({
    required int duration,
    required String sample,
    required String answer,
    required String question,
  }) async =>
      await runBusyFuture(
          _setReadingAnswer8(
            answer: answer,
            sample: sample,
            duration: duration,
            question: question,
          ),
          busyObject: StateObjects.reading8Variant);

  Future<void> _setReadingAnswer8({
    required int duration,
    required String sample,
    required String answer,
    required String question,
  }) async {
    _answers.add({
      'sample': sample,
      'response': answer,
      'question': question,
    });
    if (_variants == 1) {
      nextScreen();
    } else {
      _variants++;
      setCountdown(duration);
    }
  }

  Future<void> setListeningAnswer({String? sample, String? response}) async {
    _answers.add({'sample': sample, 'response': response});
  }

  void setAnswer(
          {required String sample,
          required String answer,
          required dynamic question}) =>
      _answers.add({
        'sample': sample,
        'response': answer,
        'question': question,
      });

  Future<void> setReadingAnswer2({
    required int duration,
    required String sample,
    required String answer,
    required dynamic question,
  }) async =>
      await runBusyFuture(
          _setReadingAnswer2(
            answer: answer,
            sample: sample,
            duration: duration,
            question: question,
          ),
          busyObject: StateObjects.reading8Variant);

  Future<void> _setReadingAnswer2({
    required int duration,
    required String sample,
    required String answer,
    required dynamic question,
  }) async {
    _answers.add({
      'sample': sample,
      'response': answer,
      'question': question,
    });
    if (_variants == 4) {
      nextScreen();
    } else {
      _variants++;
      _showAnswer = false;
      setCountdown(duration);
      _selectedOption.clear();
    }
  }

  int parseId(dynamic raw) {
    if (raw is int) return raw;
    if (raw is String) return int.tryParse(raw) ?? -1;
    return -1;
  }

  void onAcceptWithDetails(
      {required int index,
      required dynamic title,
      required Map<String, dynamic> dragged}) {
    _usedHeadingIds.remove(parseId(dragged['id']));

    _matchedAnswers[index] = dragged;

    _usedHeadingIds.add(parseId(dragged['id']));

    rebuildUi();
  }

  void onClearTarget({
    required int index,
    required CoursePracticeViewModel viewModel,
  }) {
    final existing = _matchedAnswers[index];
    if (existing == null) return;

    _usedHeadingIds.remove(parseId(existing['id']));
    _matchedAnswers[index] = null;
    rebuildUi();
  }

  Future<void> setReadingAnswer({String? sample, String? response}) async {
    _answers.add({'sample': sample, 'response': response});
  }

  Future<void> setWritingAnswer(
      {required String sample, required String response}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    _answers.add({'sample': sample, 'response': response});
    nextScreen();
  }

  // Ielts speaking answer 1
  Future<void> setIeltsSpeakingAnswer1({
    required String text,
    required String audio,
    required int duration,
    required String sample,
    required String question,
  }) async =>
      await runBusyFuture(
          _setIeltsSpeakingAnswer1(
              text: text,
              audio: audio,
              sample: sample,
              duration: duration,
              question: question),
          busyObject: StateObjects.ieltsSpeaking1Variant);

  Future<void> _setIeltsSpeakingAnswer1(
      {required String text,
      required String audio,
      required int duration,
      required String sample,
      required String question}) async {
    int variants = _variants + 1;
    await stopRecording();
    _answers.add({
      'question': question,
      'question_text': text,
      'number': variants.toString(),
      'sample_voice_answer': sample,
      'busy_object': variants.toString(),
      'recorded_voice_answer': await _voiceRecorderService.getRecordedAudio(),
    });
    if (_variants == 9) {
      nextScreen();
    } else {
      _variants++;
      _variant = 0;
      _isSpeaking = true;
      setCountdown(duration);
      await playVoicePrompt(audio);
    }
  }

  // Ielts speaking answer 4
  Future<void> setIeltsSpeakingAnswer4({
    required String text,
    required String audio,
    required int duration,
    required String sample,
    required String question,
  }) async =>
      await runBusyFuture(
          _setIeltsSpeakingAnswer4(
              text: text,
              audio: audio,
              sample: sample,
              duration: duration,
              question: question),
          busyObject: StateObjects.ieltsSpeaking4Variant);

  Future<void> _setIeltsSpeakingAnswer4(
      {required String text,
      required String audio,
      required int duration,
      required String sample,
      required String question}) async {
    int variants = _variants + 1;
    await stopRecording();
    _answers.add({
      'question': question,
      'question_text': text,
      'number': variants.toString(),
      'sample_voice_answer': sample,
      'busy_object': variants.toString(),
      'recorded_voice_answer': await _voiceRecorderService.getRecordedAudio(),
    });
    if (_variants == 7) {
      nextScreen();
    } else {
      _variants++;
      _variant = 0;
      _isSpeaking = true;
      setCountdown(duration + 10);
      await playVoicePrompt(audio);
    }
  }

  void nextDuolingoSpeakingVariantScreen() {
    _variant++;
    _isSpeaking = false;
  }

  void nextIeltsSpeakingVariantScreen() {
    _variant++;
    _isSpeaking = false;
    if (_variants == 0) {
      nextScreen();
    }
  }

  void setSectionEnd(bool value) {
    _isSectionEnd = value;
    rebuildUi();
  }

  void clearAnswer() {
    _answers.clear();
  }

  void nextScreen() {
    if (!_questionController.hasClients) return;

    _questionController.nextPage(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 350),
    );
  }

  Future<void> nextQuestion(BuildContext context) async =>
      await runBusyFuture(_nextQuestion(context),
          busyObject: StateObjects.coursePractice);

  Future<void> _nextQuestion(BuildContext context) async {
    if (_currentQuestion == _questions.length - 1) {
      pop();
    } else {
      _currentQuestion++;
      _showAnswer = false;
      _questionsController.nextPage(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 350),
      );
      final hasStimulusBlock =
          _questions.any((q) => q.stimulusBlockKey != null);

      if (hasStimulusBlock) {
        _questions.sort((a, b) {
          final aNum = int.tryParse(
                a.stimulusBlockKey?.replaceAll(RegExp(r'[^0-9]'), '') ?? '0',
              ) ??
              0;

          final bNum = int.tryParse(
                b.stimulusBlockKey?.replaceAll(RegExp(r'[^0-9]'), '') ?? '0',
              ) ??
              0;

          return aNum.compareTo(bNum);
        });

        if (_questions[_currentQuestion].stimulusBlockKey != null) {
          if (_stimulusBlockKey ==
              _questions[_currentQuestion].stimulusBlockKey) {
            _isSectionStart = false;
          } else {
            _isSectionStart = true;
            _stimulusBlockKey = _questions[_currentQuestion].stimulusBlockKey;
          }
        }

        await setSectionQuestionIntros(
            context: context,
            id: _questions[_currentQuestion].questionTypeDefinitionId ?? 0);
      } else {
        await setSingleQuestionIntros(
            context: context,
            id: _questions[_currentQuestion].questionTypeDefinitionId ?? 0);
      }
    }
  }

  void goBack() {
    if (_currentPage == 0) {
      pop();
    } else {
      _currentPage--;
      rebuildUi();
    }
  }

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToPdf(String url) async =>
      await _navigationService.navigateToPdfView(url: url);

  Future<void> navigateToCourseSubscription(SubscriptionType type) async =>
      await _navigationService.navigateToSubscriptionView(type: type);

  // Remote api call

  // Learn practice
  Future<void> getCoursePractices(
          {required int id, required CoursePractices practice}) async =>
      await runBusyFuture(_getCoursePractices(id: id, practice: practice),
          busyObject: StateObjects.coursePractice);

  Future<void> _getCoursePractices(
      {required int id, required CoursePractices practice}) async {
    if (await _statusChecker.checkConnection()) {
      if (practice == CoursePractices.courseCatalog) {
        _practices = await _apiService.getCourseCatalogPractices(id);
      } else if (practice == CoursePractices.unit) {
        _practices = await _apiService.getCourseUnitPractices(id);
      } else {
        _practices = await _apiService.getCourseLessonPractices(id);
      }
    }
  }

  // Course practice questions
  Future<void> getCoursePracticeQuestions(
          {required int id, required BuildContext context}) async =>
      await runBusyFuture(_getCoursePracticeQuestions(id: id, context: context),
          busyObject: StateObjects.coursePractice);

  Future<void> _getCoursePracticeQuestions(
      {required int id, required BuildContext context}) async {
    _currentPractice = 0;
    _currentQuestion = 0;
    _questions = await _apiService.getCourseQuestions(id);

    final hasStimulusBlock = _questions.any((q) => q.stimulusBlockKey != null);
    if (hasStimulusBlock) {
      _questions.sort((a, b) {
        final aNum = int.tryParse(
              a.stimulusBlockKey?.replaceAll(RegExp(r'[^0-9]'), '') ?? '0',
            ) ??
            0;

        final bNum = int.tryParse(
              b.stimulusBlockKey?.replaceAll(RegExp(r'[^0-9]'), '') ?? '0',
            ) ??
            0;

        return aNum.compareTo(bNum);
      });

      if (_questions[_currentQuestion].stimulusBlockKey != null) {
        _isSectionStart = true;
        _stimulusBlockKey = _questions[_currentQuestion].stimulusBlockKey;
      }
      await setSectionQuestionIntros(
          context: context,
          id: _questions[_currentQuestion].questionTypeDefinitionId ?? 0);
    } else {
      await setSingleQuestionIntros(
          context: context,
          id: _questions[_currentQuestion].questionTypeDefinitionId ?? 0);
    }

    _currentPage = 1;
  }

  // Update payment status
  Future<void> updatePaymentStatus() async =>
      await runBusyFuture(_updatePaymentStatus(),
          busyObject: StateObjects.coursePractice);

  Future<void> _updatePaymentStatus() async {
    Map<String, dynamic> response = {};

    response = await _apiService.getProfileData(_user?.userId);

    if (response['status'] == ResponseStatus.success) {
      User user = response['data'] as User;
      await _authenticationService.saveUserData(user);
    }
  }

  // Complete practice
  Future<void> completeCoursePractice(int id) async =>
      await runBusyFuture(_completeCoursePractice(id),
          busyObject: StateObjects.completeCoursePractice);

  Future<void> _completeCoursePractice(int id) async {
    if (await _statusChecker.checkConnection()) {
      await stopAudio();
      /* await _apiService.completePractice(id);
     await _courseService.getCourseProgress();*/
    }
  }

  // Refresh url
  /*Future<String?> getRefreshedUrl(String value) async {
    final String? refreshedUrl = await _courseService.refreshObject(value);

    if (refreshedUrl != null) {
      return refreshedUrl;
    } else {
      return null;
    }
  }*/

  String getReadableImage(String image) => getReadableUrl(image) ?? '';
}
