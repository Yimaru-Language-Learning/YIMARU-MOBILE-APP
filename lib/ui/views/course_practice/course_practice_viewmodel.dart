import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:waveform_recorder/waveform_recorder.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/course_practice.dart';

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
      'intro_title': 'Speak About the Photo',
      'outro_title': 'Speaking Practice Completed',
      'outro_subtitle': 'You’ve finished this speaking session. Great work!',
      'intro_subtitle':
          'Prepare to speak for at least 30 seconds about the photo you are shown'
    },
    {
      'label': 'Duolingo Speaking 02',
      'intro_title': 'Read, Then Speak',
      'type': CoursePracticeType.speaking,
      'outro_title': 'Speaking Practice Completed',
      'intro_subtitle': 'You will speak about the given topic',
      'outro_subtitle': 'You’ve finished this speaking session. Great work!',
    },
    {
      'label': 'Duolingo Speaking 03',
      'intro_title': 'Speaking Sample',
      'type': CoursePracticeType.speaking,
      'outro_title': 'Speaking Practice Completed',
      'intro_subtitle': 'You’ll speak for 1–3 minutes about a given topic.',
      'outro_subtitle': 'You’ve finished this speaking session. Great work!',
    },
    {
      'label': 'Duolingo Speaking 04',
      'type': CoursePracticeType.speaking,
      'intro_title': 'Interactive Speaking',
      'outro_title': 'Speaking Practice Completed',
      'intro_subtitle': ' You’ll answer a series of short questions.',
      'outro_subtitle': 'You’ve finished this speaking session. Great work!',
    },
    {
      'label': 'Duolingo Writing 05',
      'type': CoursePracticeType.writing,
      'intro_title': 'Write About the Photo',
      'outro_title': 'Writing Practice Completed',
      'outro_subtitle': 'You’ve finished this writing session. Great work!',
      'intro_subtitle':
          'You will see a picture and write a short description based on what you observe. Focus on clear, simple sentences.'
    },
    {
      'label': 'Duolingo Writing 06',
      'intro_title': 'Writing Sample',
      'type': CoursePracticeType.writing,
      'outro_title': 'Writing Practice Completed',
      'outro_subtitle': 'You’ve finished this writing session. Great work!',
      'intro_subtitle':
          'You will write a longer response based on a given question. Your writing will be shared with institutions as part of your score.'
    },
    {
      'label': 'Duolingo Writing 07',
      'type': CoursePracticeType.writing,
      'outro_title': 'Writing Practice Completed',
      'intro_title': 'Interactive Writing Part 1',
      'outro_subtitle': 'You’ve finished this writing session. Great work!',
      'intro_subtitle':
          ' You will write short and simple sentences.  Focus on basic ideas and clear meaning.  Write naturally and manage your time.'
    },
    {
      'label': 'Duolingo Writing 08',
      'type': CoursePracticeType.writing,
      'intro_title': 'Interactive Writing Part 2',
      'outro_title': 'Writing Practice Completed',
      'outro_subtitle': 'You’ve finished this writing session. Great work!',
      'intro_subtitle':
          ' You will continue writing on a related idea.  Add more details using clear sentences.  Stay focused and complete your response within the time.'
    },
    {
      'label': 'Duolingo Listening 09',
      'intro_title': 'Listen and Type',
      'type': CoursePracticeType.listening,
      'outro_title': 'Listening Practice Completed',
      'intro_subtitle':
          'You will hear a short audio clip. Type exactly what you hear.',
      'outro_subtitle': 'You’ve finished this Listening session. Great work!',
    },
    {
      'label': 'Duolingo Listening 10',
      'type': CoursePracticeType.listening,
      'outro_title': 'Listening Practice Completed',
      'intro_title': 'Interactive Listening - Part 1',
      'intro_subtitle': ' Listen carefully and complete the missing words.',
      'outro_subtitle': 'You’ve finished this Listening session. Great work!',
    },
    {
      'label': 'Duolingo Listening 11',
      'type': CoursePracticeType.listening,
      'outro_title': 'Listening Practice Completed',
      'intro_title': 'Interactive Listening - Part 2',
      'intro_subtitle': 'Listen and choose the correct option.',
      'outro_subtitle': 'You’ve finished this Listening session. Great work!',
    },
    {
      'label': 'Duolingo Listening 12',
      'type': CoursePracticeType.listening,
      'outro_title': 'Listening Practice Completed',
      'intro_title': 'Interactive Listening - Part 3',
      'intro_subtitle': 'Write a summary of the conversation you just had',
      'outro_subtitle': 'You’ve finished this Listening session. Great work!',
    },
    {
      'label': 'Duolingo Reading 13',
      'intro_title': 'Read and Select',
      'type': CoursePracticeType.reading,
      'outro_title': 'Reading Practice Completed',
      'outro_subtitle': 'You’ve finished this Reading session. Great work!',
      'intro_subtitle':
          'Read the sentence and select the option that correctly completes the meaning.',
    },
    {
      'label': 'Duolingo Reading 14',
      'intro_title': 'Fill in the blank',
      'type': CoursePracticeType.reading,
      'outro_title': 'Reading Practice Completed',
      'intro_subtitle':
          'Complete the sentences by filling in the missing words',
      'outro_subtitle': 'You’ve finished this Reading session. Great work!',
    },
    {
      'label': 'Duolingo Reading 15',
      'type': CoursePracticeType.reading,
      'outro_title': 'Reading Practice Completed',
      'intro_title': 'Interactive Reading Complete the Sentence',
      'intro_subtitle':
          'Read the passage and complete the interactive activities.',
      'outro_subtitle': 'You’ve finished this Reading session. Great work!',
    },
    {
      'label': 'Duolingo Reading 16',
      'type': CoursePracticeType.reading,
      'outro_title': 'Reading Practice Completed',
      'intro_title': 'Interactive Reading Complete the Passage',
      'intro_subtitle':
          'Read the passage and complete the interactive activities.',
      'outro_subtitle': 'You’ve finished this Reading session. Great work!',
    },
    {
      'label': 'Duolingo Reading 17',
      'type': CoursePracticeType.reading,
      'outro_title': 'Reading Practice Completed',
      'intro_title': 'Interactive Reading Identify the Idea',
      'intro_subtitle':
          'Read the passage and complete the interactive activities.',
      'outro_subtitle': 'You’ve finished this Reading session. Great work!',
    },
    {
      'label': 'Duolingo Reading 18',
      'type': CoursePracticeType.reading,
      'outro_title': 'Reading Practice Completed',
      'intro_title': 'Interactive Reading Title the Passage',
      'intro_subtitle':
          'Read the passage and complete the interactive activities.',
      'outro_subtitle': 'You’ve finished this Reading session. Great work!',
    },
    {
      'label': 'Duolingo Reading 19',
      'type': CoursePracticeType.reading,
      'outro_title': 'Reading Practice Completed',
      'intro_title': 'Interactive Reading Highlight the Answer',
      'intro_subtitle':
          'Read the passage and complete the interactive activities.',
      'outro_subtitle': 'You’ve finished this Reading session. Great work!',
    },
    {
      'label': 'Duolingo Reading 20',
      'type': CoursePracticeType.reading,
      'intro_title': 'Read and Complete',
      'outro_title': 'Reading Practice Completed',
      'intro_subtitle':
          'Read the passage and complete the interactive activities.',
      'outro_subtitle': 'You’ve finished this Reading session. Great work!',
    },
    {
      'subtitle': '4–5 minutes',
      'label': 'IELTS Speaking 21',
      'type': CoursePracticeType.ielts,
      'instruction_title': 'What to expect:',
      'title': 'IELTS Speaking – Interview',
      'instruction_subtitle':
          ' You’ll answer simple questions about everyday topics',
    },
    {
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Speaking 22',
      'type': CoursePracticeType.ielts,
      'title': 'IELTS Speaking – Cue Card Part 1',
      'subtitle':
          '1 minute to prepare and make notes. Then you speak for 1–2 minutes on the topic.',
    },
    {
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Speaking 23',
      'type': CoursePracticeType.ielts,
      'title': 'IELTS Speaking – Cue Card Part 2',
      'subtitle':
          'The examiner asks related questions. You answer with more detail and opinions.',
    },
    {
      'label': 'IELTS Speaking 24',
      'type': CoursePracticeType.ielts,
      'title': 'IELTS Speaking – Discussion',
      'instruction_title': 'What to expect:',
      'subtitle': 'The discussion lasts about 4–5 minutes.',
      'instruction_subtitle':
          'This is a two-way discussion with the examiner, linked to your Part 2 topic. You’ll talk about more abstract ideas and opinions.',
    },
    {
      'subtitle': '',
      'label': 'IELTS Writing 25',
      'type': CoursePracticeType.ielts,
      'title': 'IELTS Writing – Part 1',
      'instruction_title': 'What to expect:',
      'instruction_subtitle':
          'Summarize a graph or chart in ~150 words with a formal style.',
    },
    {
      'subtitle': '',
      'label': 'IELTS Writing 26',
      'type': CoursePracticeType.ielts,
      'title': 'IELTS Writing – Part 2',
      'instruction_title': 'What to expect:',
      'instruction_subtitle':
          'Give your opinion with reasons.  Write ~ 250 words.',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'title': 'Form Completion',
      'label': 'IELTS Listening 27',
      'type': CoursePracticeType.ielts,
      'outro_title': 'Part 1 completed!',
      'outro_subtitle':
          'You have finished part 1 , click next to proceed to part 2',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'title': 'Note Completion',
      'label': 'IELTS Listening 28',
      'type': CoursePracticeType.ielts,
      'outro_title': 'Part 1 completed!',
      'outro_subtitle':
          'You have finished part 1 , click next to proceed to part 2',
    },
    {
      'subtitle': '',
      'title': 'Short Answer',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 29',
      'type': CoursePracticeType.ielts,
      'outro_title': 'Part 1 completed!',
      'outro_subtitle':
          'You have finished part 1 , click next to proceed to part 2',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'title': 'Table completion',
      'label': 'IELTS Listening 30',
      'type': CoursePracticeType.ielts,
      'outro_title': 'Part 1 completed!',
      'outro_subtitle':
          'You have finished part 1 , click next to proceed to part 2',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 31',
      'type': CoursePracticeType.ielts,
      'outro_title': 'Part 2 completed!',
      'title': 'Map/Plan/Diagram Completion',
      'outro_subtitle':
          'You have finished part 3 , click next to proceed to part 3',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'title': 'Diagram labeling',
      'label': 'IELTS Listening 32',
      'type': CoursePracticeType.ielts,
      'outro_title': 'Part 2 completed!',
      'outro_subtitle':
          'You have finished part 3 , click next to proceed to part 3',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 33',
      'type': CoursePracticeType.ielts,
      'outro_title': 'Part 3 completed!',
      'title': 'IELTS Listening Multiple choice',
      'outro_subtitle':
          'You have finished part 3 , click next to proceed to part 4',
    },
    {
      'subtitle': '',
      'title': 'Matching',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 34',
      'type': CoursePracticeType.ielts,
      'outro_title': 'Part 3 completed!',
      'outro_subtitle':
          'You have finished part 3 , click next to proceed to part 4',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 35',
      'type': CoursePracticeType.ielts,
      'outro_title': 'Part 4 completed!',
      'outro_subtitle': 'You have finished part 4',
      'title': 'IELTS Listening - Summary Completion',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 36',
      'title': 'Sentence Completion',
      'type': CoursePracticeType.ielts,
      'outro_title': 'Part 4 completed!',
      'outro_subtitle': 'You have finished part 4',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'title': 'Paragraph Choice',
      'label': 'IELTS Listening 37',
      'type': CoursePracticeType.ielts,
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 38',
      'type': CoursePracticeType.ielts,
      'title': 'IELTS Reading - Diagram Labeling',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 39',
      'type': CoursePracticeType.ielts,
      'title': 'IELTS Reading - Sentence Completion',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 40',
      'type': CoursePracticeType.ielts,
      'title': 'Sentence Ending Matching',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 41',
      'type': CoursePracticeType.ielts,
      'title': 'True / False / Not Given',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 42',
      'type': CoursePracticeType.ielts,
      'title': 'IELTS Reading -Multiple choice',
    },
    {
      'subtitle': '',
      'instruction_title': '',
      'instruction_subtitle': '',
      'label': 'IELTS Listening 43',
      'title': 'Yes / No / Not Given',
      'type': CoursePracticeType.ielts,
    },
  ];

  List<Map<String, dynamic>> get questionParams => _questionParams;

  // Selected question param
  Map<String, dynamic> _selectedQuestionParam = {
    'label': 'Duolingo Speaking 01',
    'intro_title': 'Speak About the Photo',
    'type': CoursePracticeType.speaking,
    'outro_title': 'Speaking Practice Completed',
    'outro_subtitle': 'You’ve finished this speaking session. Great work!',
    'intro_subtitle':
        'Prepare to speak for at least 30 seconds about the photo you are shown',
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
    if (id == 12 /*Speak about the photo*/) {
      // await refreshQuestionUrl(_questions[_currentQuestion]);
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (id == 13 /*Read then speak*/) {
      _selectedQuestionParam = _questionParams.elementAt(1);
    } else if (id == 36 /*Speaking sample*/) {
      _selectedQuestionParam = _questionParams.elementAt(2);
    } else if (id == 14 /*Interactive speaking*/) {
      _selectedQuestionParam = _questionParams.elementAt(3);
    } else if (id == 22 /*Speak about the photo*/) {
      _selectedQuestionParam = _questionParams.elementAt(4);
    } else if (id == 23 /*Writing sample*/) {
      _selectedQuestionParam = _questionParams.elementAt(5);
    } else if (id == 24 /*Interactive writing part 1*/) {
      _selectedQuestionParam = _questionParams.elementAt(6);
    } else if (id == 25 /*Interactive writing part 2*/) {
      _selectedQuestionParam = _questionParams.elementAt(7);
    } else if (id == 28 /*Listen and type*/) {
      _selectedQuestionParam = _questionParams.elementAt(8);
    } else if (id == 56 /*Interactive listening part 1*/) {
      _selectedQuestionParam = _questionParams.elementAt(9);
    } else if (id == 29 /*Interactive listening part 2*/) {
      _selectedQuestionParam = _questionParams.elementAt(10);
    } else if (id == 57 /*Interactive listening part 3*/) {
      _selectedQuestionParam = _questionParams.elementAt(11);
    } else if (id == 49 /*Read and select*/) {
      _selectedQuestionParam = _questionParams.elementAt(12);
    } else if (id == 3 /*Fill in the blank*/) {
      _selectedQuestionParam = _questionParams.elementAt(13);
    } else if (id == 51 /*Interactive reading - complete the sentence*/) {
      _selectedQuestionParam = _questionParams.elementAt(14);
    } else if (id == 52 /*Interactive reading - complete the passage*/) {
      _selectedQuestionParam = _questionParams.elementAt(15);
    } else if (id == 53 /*Interactive reading - identify the idea*/) {
      _selectedQuestionParam = _questionParams.elementAt(16);
    } else if (id == 54 /*Interactive reading - title the passage*/) {
      _selectedQuestionParam = _questionParams.elementAt(17);
    } else if (id == 55 /*Interactive reading - highlight the answer*/) {
      _selectedQuestionParam = _questionParams.elementAt(18);
    } else if (id == 50 /*Read and complete*/) {
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
    if (id == 40 /*Form Completion*/) {
      _selectedQuestionParam = _questionParams.elementAt(26);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 42 /*Note Completion*/) {
      _selectedQuestionParam = _questionParams.elementAt(27);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 4 /*Short Answer*/) {
      _selectedQuestionParam = _questionParams.elementAt(28);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 0 /*Table completion*/) {
      _selectedQuestionParam = _questionParams.elementAt(29);
    } else if (id == 61 /*Map/Plan/Diagram Completion*/) {
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
    } else if (id == 31 /*Diagram labeling*/) {
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
    } else if (id == 33 /*Matching*/) {
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
    } else if (id == 35 /*Sentence completion*/) {
      _selectedQuestionParam = _questionParams.elementAt(35);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 46 /*Paragraph choice*/) {
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
    } else if (id == 47 /*Sentence Ending Matching*/) {
      _selectedQuestionParam = _questionParams.elementAt(39);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 48 /*True / False / Not Given*/) {
      _selectedQuestionParam = _questionParams.elementAt(40);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 64 /*IELTS Reading - Multiple choice*/) {
      _selectedQuestionParam = _questionParams.elementAt(41);
      int responseFirstSec = _questions[_currentQuestion]
          .dynamicPayload
          ?.response
          ?.first
          .value['seconds'];
      setCountdown(responseFirstSec);
    } else if (id == 59 /*Yes / No / Not Given*/) {
      _selectedQuestionParam = _questionParams.elementAt(42);
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
    print(_selectedOption);

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
  Future<bool?> showAbortDialog() async {
    DialogResponse? response = await _dialogService.showDialog(
      cancelTitle: 'No',
      title: 'Recording',
      buttonTitle: 'Yes',
      barrierDismissible: true,
      cancelTitleColor: kcDarkGrey,
      buttonTitleColor: kcPrimaryColor,
      description: 'Are you sure you want to stop recording?',
    );
    return response?.confirmed;
  }

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
    required String audio,
    required int duration,
    required String sample,
    required String question,
  }) async =>
      await runBusyFuture(
          _setIeltsSpeakingAnswer1(
              audio: audio,
              sample: sample,
              duration: duration,
              question: question),
          busyObject: StateObjects.ieltsSpeaking1Variant);

  Future<void> _setIeltsSpeakingAnswer1(
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
    required String audio,
    required int duration,
    required String sample,
    required String question,
  }) async =>
      await runBusyFuture(
          _setIeltsSpeakingAnswer4(
              audio: audio,
              sample: sample,
              duration: duration,
              question: question),
          busyObject: StateObjects.ieltsSpeaking4Variant);

  Future<void> _setIeltsSpeakingAnswer4(
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
    if (_variants == 7) {
      nextScreen();
    } else {
      _variants++;
      _variant = 0;
      _isSpeaking = true;
      setCountdown(duration);
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
      print('HERE: 1');
      await setSectionQuestionIntros(
          context: context,
          id: _questions[_currentQuestion].questionTypeDefinitionId ?? 0);
    } else {
      print('HERE: 2');
      print(_questions[_currentQuestion].questionTypeDefinitionId);
      await setSingleQuestionIntros(
          context: context,
          id: _questions[_currentQuestion].questionTypeDefinitionId ?? 0);
    }

    _currentPage = 1;
  }

  // Finish practice
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
