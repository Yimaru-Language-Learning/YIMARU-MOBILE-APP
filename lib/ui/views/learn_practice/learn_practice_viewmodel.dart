import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:waveform_recorder/waveform_recorder.dart';
import 'package:yimaru_app/models/practice_question.dart';
import 'package:yimaru_app/models/learn_practice.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/voice_recorder_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/api_service.dart';
import '../../../services/audio_player_service.dart';
import '../../../services/learn_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/app_colors.dart';

class LearnPracticeViewModel extends ReactiveViewModel {
  // Dependency injection

  final _apiService = locator<ApiService>();

  final _learnService = locator<LearnService>();

  final _dialogService = locator<DialogService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _audioPlayerService = locator<AudioPlayerService>();

  final _voiceRecorderService = locator<VoiceRecorderService>();

  final _authenticationService = locator<AuthenticationService>();

  LearnPracticeViewModel() {
    _listenToAudio();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _learnService,
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
    print('DURATION: ${_duration.inMilliseconds}');
    if (_duration.inMilliseconds == 0) return 0;
    return _position.inMilliseconds / _duration.inMilliseconds;
  }

  // Voice recorder
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

  // Learn practices

  List<LearnPractice> _practices = [];

  List<LearnPractice> get practices => _practices;

  final Map<int, String> _refreshedImages = {};

  Map<int, String> get refreshedImages => _refreshedImages;

  // Practice questions
  List<PracticeQuestion> _questions = [];

  List<PracticeQuestion> get questions => _questions;

  // Practice answers

  final List<Map<String, dynamic>> _answers = [];

  List<Map<String, dynamic>> get answers => _answers;

  // In-app navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  final PageController _questionSetController = PageController();

  PageController get questionSetController => _questionSetController;

  final PageController _questionController = PageController();

  PageController get questionController => _questionController;

  // Voice recorder
  Future<void> stopRecording() async {
    await _voiceRecorderService.stopRecording();
  }

  Future<bool> startRecording() async => await runBusyFuture(
        _startRecording(),
        busyObject: StateObjects.recordLearnPracticeAnswer,
      );

  Future<bool> _startRecording() async =>
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

  Future<void> playVoicePrompt(PracticeQuestion question) async =>
      await runBusyFuture(_playVoicePrompt(question),
          busyObject: StateObjects.learnPracticeQuestion);

  Future<void> _playVoicePrompt(PracticeQuestion question) async {
    _questionController.jumpToPage(1);
    await _audioPlayerService
        .playUrl(question.dynamicPayload?.stimulus?[1].value ?? '');
  }

  Future<void> replayVoicePrompt(PracticeQuestion question) async {
    await _audioPlayerService
        .playUrl(question.dynamicPayload?.stimulus?[1].value ?? '');
  }

  Future<void> playResult(
      {required Map<String, dynamic> answer, required Voice voice}) async {
    setBusyObject(playing: voice, object: answer['busy_object']);
    await playAudio(voice: voice, answer: answer);
  }

  Future<void> playAudio(
          {required Map<String, dynamic> answer, required Voice voice}) async =>
      await runBusyFuture(_playAudio(voice: voice, answer: answer),
          busyObject: answer['busy_object']);

  Future<void> _playAudio(
      {required Map<String, dynamic> answer, required Voice voice}) async {
    if (voice == Voice.recorded) {
      print(answer['recorded_voice_answer']);
      await _audioPlayerService.playLocal(answer['recorded_voice_answer']);
    } else {
      await _audioPlayerService.playUrl(answer['sample_voice_answer']);
    }
  }

  Future<void> pauseAudio() async {
    await _audioPlayerService.pause();
  }

  Future<void> stopAudio() async {
    await _audioPlayerService.stop();
  }

  // Set busy object
  void setBusyObject({required String object, required Voice playing}) {
    _playing = playing;
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

  // In-app navigation
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
          {required int index, required PracticeQuestion question}) async =>
      await runBusyFuture(_nextQuestion(index: index, question: question),
          busyObject: StateObjects.finishLearnPracticeQuestion);

  Future<void> _nextQuestion(
      {required int index, required PracticeQuestion question}) async {
    await stopRecording();
    _answers.add({
      'busy_object': question.id.toString(),
      'question_text': question.dynamicPayload?.stimulus?.first.value,
      'sample_voice_answer': question.dynamicPayload?.response?.first.value,
      'recorded_voice_answer': await _voiceRecorderService.getRecordedAudio(),
    });
    if (index != _questions.length) {
      _questionSetController.nextPage(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 350),
      );
      print('PROMPT: ${_questions[index].dynamicPayload?.stimulus?[1].value}');
      await playVoicePrompt(_questions[index]);
    } else {
      goTo(3);
    }
  }

  // Reset
  Future<void> reset() async {
    goTo(0);
    _answers.clear();
    questionSetController.jumpToPage(0);
  }

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnSubscription() async => await _navigationService
      .navigateToSubscriptionView(type: SubscriptionType.learn);

  // Remote api call

  // Refresh url
  /*Future<String?> refreshUrl(String url) async =>
      await _learnService.refreshObject(url);*/

  // Learn practice
  Future<void> getLearnPractices(
          {required int id, required LearnPractices practice}) async =>
      await runBusyFuture(_getLearnPractices(id: id, practice: practice),
          busyObject: StateObjects.learnPractice);

  Future<void> _getLearnPractices(
      {required int id, required LearnPractices practice}) async {
    if (await _statusChecker.checkConnection()) {
      if (practice == LearnPractices.course) {
        _practices = await _apiService.getLearnCoursePractices(id);
        //  await refreshPracticeImages(_practices);
        await _getLearnPracticeQuestions(_practices.first.questionSetId ?? 0);
      } else if (practice == LearnPractices.module) {
        _practices = await _apiService.getLearnModulePractices(id);
        //  await refreshPracticeImages(_practices);
        await _getLearnPracticeQuestions(_practices.first.questionSetId ?? 0);
      } else {
        _practices = await _apiService.getLearnLessonPractices(id);
        await _getLearnPracticeQuestions(_practices.first.questionSetId ?? 0);
      }
    }
  }

  Future<void> _getLearnPracticeQuestions(int id) async {
    _questions = await _apiService.getLearnQuestions(id);
  }

  // Complete practice
  Future<void> completeLearnPractice() async =>
      await runBusyFuture(_completeLearnPractice(),
          busyObject: StateObjects.completeLearnPractice);

  Future<void> _completeLearnPractice() async {
    if (await _statusChecker.checkConnection()) {
      await stopAudio();
      await _apiService.completePractice(_practices.first.id ?? 0);
      await _learnService.getLearnProgress();
    }
  }

  //Refresh image
  /*Future<void> refreshPracticeImages(List<LearnPractice> practices) async {
    for (final practice in practices) {
      final image = practice.storyImage;

      if (practice.id == null || image == null || image.isEmpty) {
        continue;
      }

      final String? refreshedUrl = await _learnService.refreshObject(image);

      if (refreshedUrl != null) {
        _refreshedImages[practice.id!] = refreshedUrl;
      }
    }
  }

  String getPracticeImage(LearnPractice practice) =>
      getReadableUrl(_refreshedImages[practice.id] ?? '') ?? '';*/
}
