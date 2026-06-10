import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:waveform_recorder/waveform_recorder.dart';
import 'package:yimaru_app/models/course_practice.dart';

import '../../../app/app.locator.dart';
import '../../../models/course_question.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/audio_player_service.dart';
import '../../../services/authentication_service.dart';
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

  // Voice recorder
  String? _recordedAudio;

  String? get recordedAudio => _recordedAudio;

  WaveformRecorderController get _waveController =>
      _voiceRecorderService.waveController;

  WaveformRecorderController get waveController => _waveController;

  // Voice recorder state
  VoiceRecordingState get _recordingState =>
      _voiceRecorderService.recordingState;

  VoiceRecordingState get recordingState => _recordingState;

  // Busy object
  String? _busyObject;

  String? get busyObject => _busyObject;

  Voice? _playing;

  Voice? get playing => _playing;

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

  int _currentQuestion = 0;

  int get currentQuestion => _currentQuestion;

  List<CourseQuestion> _questions = [];

  List<CourseQuestion> get questions => _questions;

  final List<Map<String, dynamic>> _questionParams = [
    {
      'label': 'Speaking 01',
      'type': DuolingoAssessments.speaking,
      'intro_title': 'Speak About the Photo',
      'outro_title': 'Speaking Practice Completed',
      'outro_subtitle': 'You’ve finished this speaking session. Great work!',
      'intro_subtitle':
          'Prepare to speak for at least 30 seconds about the photo you are shown'
    },
    {
      'label': 'Speaking 02',
      'intro_title': 'Read, Then Speak',
      'type': DuolingoAssessments.speaking,
      'outro_title': 'Speaking Practice Completed',
      'intro_subtitle': 'You will speak about the given topic',
      'outro_subtitle': 'You’ve finished this speaking session. Great work!',
    },
    {
      'label': 'Speaking 03',
      'intro_title': 'Speaking Sample',
      'type': DuolingoAssessments.speaking,
      'outro_title': 'Speaking Practice Completed',
      'intro_subtitle': 'You’ll speak for 1–3 minutes about a given topic.',
      'outro_subtitle': 'You’ve finished this speaking session. Great work!',
    },
    {
      'label': 'Speaking 04',
      'type': DuolingoAssessments.speaking,
      'intro_title': 'Interactive Speaking',
      'outro_title': 'Speaking Practice Completed',
      'intro_subtitle': ' You’ll answer a series of short questions.',
      'outro_subtitle': 'You’ve finished this speaking session. Great work!',
    },
    {
      'label': 'Writing 05',
      'type': DuolingoAssessments.writing,
      'intro_title': 'Write About the Photo',
      'outro_title': 'Writing Practice Completed',
      'outro_subtitle': 'You’ve finished this writing session. Great work!',
      'intro_subtitle':
          'You will see a picture and write a short description based on what you observe. Focus on clear, simple sentences.'
    },
    {
      'label': 'Writing 06',
      'intro_title': 'Writing Sample',
      'type': DuolingoAssessments.writing,
      'outro_title': 'Writing Practice Completed',
      'outro_subtitle': 'You’ve finished this writing session. Great work!',
      'intro_subtitle':
          'You will write a longer response based on a given question. Your writing will be shared with institutions as part of your score.'
    },
    {
      'label': 'Writing 07',
      'type': DuolingoAssessments.writing,
      'outro_title': 'Writing Practice Completed',
      'intro_title': 'Interactive Writing Part 1',
      'outro_subtitle': 'You’ve finished this writing session. Great work!',
      'intro_subtitle':
          ' You will write short and simple sentences.  Focus on basic ideas and clear meaning.  Write naturally and manage your time.'
    },
    {
      'label': 'Writing 08',
      'type': DuolingoAssessments.writing,
      'intro_title': 'Interactive Writing Part 2',
      'outro_title': 'Writing Practice Completed',
      'outro_subtitle': 'You’ve finished this writing session. Great work!',
      'intro_subtitle':
          ' You will continue writing on a related idea.  Add more details using clear sentences.  Stay focused and complete your response within the time.'
    },
    {
      'label': 'Listening 09',
      'intro_title': 'Listen and Type',
      'type': DuolingoAssessments.listening,
      'outro_title': 'Listening Practice Completed',
      'intro_subtitle':
          'You will hear a short audio clip. Type exactly what you hear.',
      'outro_subtitle': 'You’ve finished this Listening session. Great work!',
    },
    {
      'label': 'Listening 10',
      'type': DuolingoAssessments.listening,
      'outro_title': 'Listening Practice Completed',
      'intro_title': 'Interactive Listening - Part 1',
      'intro_subtitle': ' Listen carefully and complete the missing words.',
      'outro_subtitle': 'You’ve finished this Listening session. Great work!',
    },
    {
      'label': 'Listening 11',
      'type': DuolingoAssessments.listening,
      'outro_title': 'Listening Practice Completed',
      'intro_title': 'Interactive Listening - Part 2',
      'intro_subtitle': 'Listen and choose the correct option.',
      'outro_subtitle': 'You’ve finished this Listening session. Great work!',
    },
    {
      'label': 'Assessment 12',
      'type': DuolingoAssessments.listening,
      'title': 'Interactive Listening - Part 3',
      'outro_title': 'Listening Practice Completed',
      'subtitle': 'Write a summary of the conversation you just had',
      'outro_subtitle': 'You’ve finished this Listening session. Great work!',
    },
    {
      'label': 'Reading 13',
      'intro_title': 'Read and Select',
      'type': DuolingoAssessments.reading,
      'intro_subtitle':
          'Read the sentence and select the option that correctly completes the meaning.'
    },
    {
      'label': 'Reading 14',
      'intro_title': 'Fill in the blank',
      'type': DuolingoAssessments.reading,
      'intro_subtitle': 'Complete the sentences by filling in the missing words'
    },
  ];

  List<Map<String, dynamic>> get questionParams => _questionParams;

  // Selected question param
  Map<String, dynamic> _selectedQuestionParam = {
    'label': 'Speaking 01',
    'intro_title': 'Speak About the Photo',
    'type': DuolingoAssessments.speaking,
    'outro_title': 'Speaking Practice Completed',
    'outro_subtitle': 'You’ve finished this speaking session. Great work!',
    'intro_subtitle':
        'Prepare to speak for at least 30 seconds about the photo you are shown',
  };

  Map<String, dynamic> get selectedQuestionParam => _selectedQuestionParam;

  // Practice answers
  final List<Map<String, dynamic>> _answers = [];

  List<Map<String, dynamic>> get answers => _answers;

  // Next button state
  bool _buttonActive = false;

  bool get buttonActive => _buttonActive;

  // In-app navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  final PageController _practiceController = PageController();

  PageController get practiceController => _practiceController;

  final PageController _questionController = PageController();

  PageController get questionController => _questionController;

  // Practice
  void setPracticeFocus() {
    _focusPractice = true;
    rebuildUi();
  }

  // Speaking state
  void setSpeakingState() {
    _isSpeaking = !_isSpeaking;
    rebuildUi();
  }

  // Next button
  void setNextButton() {
    _buttonActive = true;
    rebuildUi();
  }

  // Question param
  Future<void> setQuestionParam(String type) async {
    print('FIRST QUESTION: $type');
    if (type == '636') {
      // await refreshQuestionUrl(_questions[_currentQuestion]);
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (type == '') {
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (type == '') {
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (type == '') {
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (type == '') {
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (type == '') {
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (type == '') {
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (type == '') {
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (type == '') {
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (type == '') {
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (type == '') {
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (type == '') {
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else if (type == '') {
      _selectedQuestionParam = _questionParams.elementAt(0);
    } else {
      _selectedQuestionParam = _questionParams.elementAt(0);
    }
  }

  // Voice recorder
  Future<void> stopRecording() async {
    if (_voiceRecorderService.waveController.isRecording) {
      await _voiceRecorderService.stopRecording();
      _recordedAudio = await _voiceRecorderService.getRecordedAudio();
    }
  }

  Future<void> startRecording() async => await runBusyFuture(_startRecording(),
      busyObject: StateObjects.recordCoursePracticeAnswer);

  Future<void> _startRecording() async =>
      await _voiceRecorderService.startRecording();

  // Play practice audio
  void _listenToAudio() {
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

  Future<void> playVoicePrompt(CourseQuestion question) async =>
      await runBusyFuture(_playVoicePrompt(question),
          busyObject: StateObjects.coursePracticeQuestion);

  Future<void> _playVoicePrompt(CourseQuestion question) async {
    _questionController.jumpToPage(1);
    await _audioPlayerService
        .playUrl(question.dynamicPayload?.stimulus?.first.value ?? '');
  }

  Future<void> replayVoicePrompt(CourseQuestion question) async {
    await _audioPlayerService
        .playUrl(question.dynamicPayload?.stimulus?.first.value ?? '');
  }

  Future<void> playResult(Voice voice) async {
    setBusyObject(voice);
    await playAudio(voice);
  }

  Future<void> playAudio(Voice voice) async =>
      await runBusyFuture(_playAudio(voice),
          busyObject: StateObjects.coursePracticeReview);

  Future<void> _playAudio(Voice voice) async {
    if (voice == Voice.recorded) {
      print('RECORDED: ${_recordedAudio ?? ''}');
      await _audioPlayerService.playLocal(_recordedAudio ?? '');
    } else {
      String url = await getRefreshedUrl(_questions[currentQuestion]
                  .dynamicPayload
                  ?.response
                  ?.last
                  .value ??
              '') ??
          '';
      print('REFRESHED: ${_questions[currentQuestion]
          .dynamicPayload
          ?.response
          ?.last
          .value ??
          ''}');
      await _audioPlayerService.playUrl(url);
    }
  }

  Future<void> pauseAudio() async {
    await _audioPlayerService.pause();
  }

  // Set busy object
  void setBusyObject(Voice playing) {
    _playing = playing;
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

  // In-app navigation
  void nextScreen() {
    _questionController.nextPage(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 350),
    );
  }

  void nextPage() {
    _currentPage++;
    rebuildUi();
  }

  void goTo(int page) {
    _currentPage = page;
    rebuildUi();
  }

  void goBack() {
    if (_currentPage == 0) {
      pop();
    } else {
      _currentPage--;
      rebuildUi();
    }
  }

  Future<void> nextQuestion(
          {required int index, required CourseQuestion question}) async =>
      await runBusyFuture(_nextQuestion(index: index, question: question),
          busyObject: StateObjects.finishCoursePracticeQuestion);

  Future<void> _nextQuestion(
      {required int index, required CourseQuestion question}) async {
    await stopRecording();
    _answers.add({
      'busy_object': question.id.toString(),
      'recorded_voice_answer': await _voiceRecorderService.getRecordedAudio(),
      'sample_text_answer':
          question.dynamicPayload?.response?.first.value ?? '',
      'sample_voice_answer':
          question.dynamicPayload?.stimulus?.first.value ?? '',
    });
    if (index != _questions.length) {
      _practiceController.nextPage(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 350),
      );
      await playVoicePrompt(_questions[index]);
    } else {
      goTo(3);
    }
  }

  // Navigation
  void pop() => _navigationService.back();

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
        _practices = await _apiService.getCoursePractices(id);
        //  await _getLearnPracticeQuestions(_practices.first.questionSetId ?? 0);
      } else if (practice == CoursePractices.unit) {
        _practices = await _apiService.getCoursePractices(id);
        // await _getLearnPracticeQuestions(_practices.first.questionSetId ?? 0);
      } else {
        _practices = await _apiService.getCoursePractices(id);
        await _getLearnPracticeQuestions(_practices.first.questionSetId ?? 0);
        await setQuestionParam(
            _questions[_currentQuestion].id.toString() ?? '');
      }
    }
  }

  Future<void> _getLearnPracticeQuestions(int id) async {
    _questions = await _apiService.getCourseQuestions(id);
  }

  // Refresh url
  Future<String?> getRefreshedUrl(String value) async {
    final String? refreshedUrl = await _courseService.refreshObject(value);

    if (refreshedUrl != null) {
      return refreshedUrl;
    } else {
      return null;
    }
  }

  String getReadableImage(String image)=> getReadableUrl(image) ?? '';
}
