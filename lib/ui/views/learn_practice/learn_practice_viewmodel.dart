import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:waveform_recorder/waveform_recorder.dart';
import 'package:yimaru_app/models/learn_practice.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/voice_recorder_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../models/learn_question.dart';
import '../../../services/api_service.dart';
import '../../../services/audio_player_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/app_colors.dart';

class LearnPracticeViewModel extends ReactiveViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

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
  List<ListenableServiceMixin> get listenableServices =>
      [_audioPlayerService, _voiceRecorderService, _authenticationService];

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

  // Practice questions
  List<LearnQuestion> _questions = [];

  List<LearnQuestion> get questions => _questions;

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
    if (_voiceRecorderService.waveController.isRecording) {
      await _voiceRecorderService.stopRecording();
    }
  }

  Future<void> startRecording() async => await runBusyFuture(_startRecording(),
      busyObject: StateObjects.recordLearnPracticeAnswer);

  Future<void> _startRecording() async =>
      await _voiceRecorderService.startRecording();

  // Play practice audio
  void _listenToAudio() {
    _audioPlayerService.durationStream.listen((dur) {
      _duration = dur;
      print('DURATION: $_duration');
      rebuildUi();
    });

    _audioPlayerService.positionStream.listen((pos) {
      _position = pos;
      print('POSITION: $_position');
      rebuildUi();
    });
  }

  Future<void> playVoicePrompt(LearnQuestion question) async =>
      await runBusyFuture(_playVoicePrompt(question),
          busyObject: StateObjects.learnPracticeQuestion);

  Future<void> _playVoicePrompt(LearnQuestion question) async {
    _questionController.jumpToPage(1);
    await _audioPlayerService.playUrl(question.voicePrompt ?? '');
  }

  Future<void> replayVoicePrompt(LearnQuestion question) async {
    await _audioPlayerService.playUrl(question.voicePrompt ?? '');
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
      await _audioPlayerService.playLocal(answer['recorded_voice_answer']);
    } else {
      await _audioPlayerService.playUrl(answer['sample_voice_answer']);
    }
  }

  Future<void> pauseAudio() async {
    await _audioPlayerService.pause();
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
      {required int index, required LearnQuestion question}) async {
    await stopRecording();
    _answers.add({
      'busy_object': question.id.toString(),
      'sample_text_answer': question.audioCorrectAnswerText,
      'sample_voice_answer': question.sampleAnswerVoicePrompt,
      'recorded_voice_answer': _voiceRecorderService.getRecordedAudio(),
    });
    if (index != _questions.length) {
      _questionSetController.nextPage(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutCubic);
      await playVoicePrompt(_questions[index]);
    } else {
      goTo(3);
    }
  }

  // Navigation
  void pop() => _navigationService.back();

  // Remote api call

  // Learn practice
  Future<void> getLearnPractices(
          {required int id, required LearnPractices practice}) async =>
      await runBusyFuture(_getLearnPractices(id: id, practice: practice),
          busyObject: StateObjects.learnPractices);

  Future<void> _getLearnPractices(
      {required int id, required LearnPractices practice}) async {
    if (await _statusChecker.checkConnection()) {
      if (practice == LearnPractices.course) {
        _practices = await _apiService.getLearnCoursePractices(id);
        await _getLearnPracticeQuestions(_practices.first.questionSetId ?? 0);
      } else if (practice == LearnPractices.module) {
        _practices = await _apiService.getLearnModulePractices(id);
        await _getLearnPracticeQuestions(_practices.first.questionSetId ?? 0);
      } else {
        _practices = await _apiService.getLearnLessonPractices(id);
        print('PRACTICE LENGTH: ${_practices.length}');
        await _getLearnPracticeQuestions(_practices.first.questionSetId ?? 0);
      }
    }
  }

  Future<void> _getLearnPracticeQuestions(int id) async {
    _questions = await _apiService.getLearnQuestions(id);
  }
}
