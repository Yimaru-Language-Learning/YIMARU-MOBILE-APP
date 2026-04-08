import 'package:audioplayers/audioplayers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:waveform_recorder/waveform_recorder.dart';
import 'package:yimaru_app/models/user_model.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/voice_recorder_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../services/audio_player_service.dart';
import '../../common/app_colors.dart';

class LearnPracticeViewModel extends ReactiveViewModel {
  // Dependency injection
  final _dialogService = locator<DialogService>();

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
  UserModel? get _user => _authenticationService.user;

  UserModel? get user => _user;

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
  StateObjects _busyObject = StateObjects.none;

  StateObjects get busyObject => _busyObject;

  // In-app navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  // Practice
  Map<String, dynamic> _selectedPractice = {};

  Map<String, dynamic> get selectedPractice => _selectedPractice;

  // Practice
  void setPractice(Map<String, dynamic> practice) {
    _selectedPractice = practice;
    goTo(1);
  }

  // Play practice audio
  Future<void> playQuestionAudio() async =>
      await runBusyFuture(_playQuestionAudio(),
          busyObject: StateObjects.learnPracticeQuestion);

  Future<void> _playQuestionAudio() async {
    goTo(3);
    await _audioPlayerService.playUrl(_selectedPractice['question_audio_url']);
  }

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

  // Set busy object

  void setBusyObject(StateObjects object) {
    _busyObject = object;
    notifyListeners();
  }

  // Sample audio
  Future<void> playSampleAudio() async =>
      await runBusyFuture(_playSampleAudio(),
          busyObject: StateObjects.learnPracticeSample);
  Future<void> _playSampleAudio() async {
    setBusyObject(StateObjects.learnPracticeSample);
    await _audioPlayerService.playUrl(_selectedPractice['sample_answer']);
  }

  Future<void> pauseSampleAudio() async =>
      await runBusyFuture(_pauseSampleAudio(),
          busyObject: StateObjects.learnPracticeSample);

  Future<void> _pauseSampleAudio() async {
    setBusyObject(StateObjects.learnPracticeSample);
    await _audioPlayerService.pause();
  }

  // Recorded audio
  Future<void> playRecordedAudio() async =>
      await runBusyFuture(_playRecordedAudio(),
          busyObject: StateObjects.learnPracticeAnswer);

  Future<void> _playRecordedAudio() async {
    setBusyObject(StateObjects.learnPracticeAnswer);
    await _audioPlayerService
        .playLocal(await _voiceRecorderService.getRecordedAudio() ?? '');
  }

  Future<void> pauseRecordedAudio() async =>
      await runBusyFuture(_pauseRecordedAudio(),
          busyObject: StateObjects.learnPracticeAnswer);

  Future<void> _pauseRecordedAudio() async {
    setBusyObject(StateObjects.learnPracticeAnswer);
    await _audioPlayerService.pause();
  }

  // Voice recorder
  Future<void> startRecording() async => await runBusyFuture(_startRecording(),
      busyObject: StateObjects.recordLearnPracticeAnswer);

  Future<void> _startRecording() async =>
      await _voiceRecorderService.startRecording();

  Future<void> stopRecording() async =>
      await _voiceRecorderService.stopRecording();

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

  // Navigation
  void pop() => _navigationService.back();
}
