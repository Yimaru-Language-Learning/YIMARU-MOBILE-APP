import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/api_service.dart';
import '../../../services/audio_player_service.dart';
import '../../../services/learn_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';

class LearnPracticeViewModel extends ReactiveViewModel
    with FormStateHelper
    implements FormViewModel {
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
    if (_duration.inMilliseconds == 0) return 0;
    return _position.inMilliseconds / _duration.inMilliseconds;
  }

  // Phone number
  bool _focusPhoneNumber = false;

  bool get focusPhoneNumber => _focusPhoneNumber;

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

  int? _practiceParentId;
  LearnPractices? _practiceKind;
  int? _practiceSessionGeneration;
  bool _completionInFlight = false;
  bool _completionSaved = false;
  bool _completionFailed = false;

  bool get completionSaved => _completionSaved;
  bool get completionFailed => _completionFailed;

  bool get _hasActivePractice =>
      !disposed &&
      _practiceParentId != null &&
      _practiceKind != null &&
      _practiceSessionGeneration == _authenticationService.sessionGeneration;

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

  // Phone number
  void setPhoneNumberFocus() {
    _focusPhoneNumber = true;
    rebuildUi();
  }

  // Voice recorder
  Future<void> stopRecording() async {
    await _voiceRecorderService.stopRecording();
  }

  Future<void> startRecording() async => await runBusyFuture(_startRecording(),
      busyObject: StateObjects.recordLearnPracticeAnswer);

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
  Future<void> showPurchaseDialog() async => await _dialogService.showDialog(
        barrierDismissible: true,
        cancelTitleColor: kcDarkGrey,
        title: LocaleKeys.notice.tr(),
        buttonTitleColor: kcPrimaryColor,
        buttonTitle: LocaleKeys.close.tr(),
        description: LocaleKeys.ios_purchase.tr(),
      );

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
      await playVoicePrompt(_questions[index]);
    } else {
      goTo(3);
    }
  }

  // Reset
  Future<void> reset() async {
    if (_completionInFlight || disposed) return;
    _completionSaved = false;
    _completionFailed = false;
    goTo(0);
    _answers.clear();
    if (questionSetController.hasClients) questionSetController.jumpToPage(0);
  }

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnSubscription() async => await _navigationService
      .navigateToSubscriptionView(type: SubscriptionType.learn);

  // Remote api call

  // Refresh url
  /*Future<String?> refreshUrl(String url) async =>
      await _learnService.refreshObject(url);*/

  // Update payment status

  Future<void> _updatePaymentStatus() async {
    final generation = _authenticationService.sessionGeneration;
    Map<String, dynamic> response = {};

    response = await _apiService.getProfileData(_user?.userId);

    if (!disposed &&
        generation == _authenticationService.sessionGeneration &&
        response['status'] == ResponseStatus.success) {
      User user = response['data'] as User;
      await _authenticationService.saveUserData(user);
    }
  }

  // Learn practice
  Future<void> getLearnPractices(
      {required int id, required LearnPractices practice}) async {
    if (disposed || _completionInFlight || busy(StateObjects.learnPractice)) {
      return;
    }
    await runBusyFuture(
        Future<void>.sync(() => _getLearnPractices(id: id, practice: practice)),
        busyObject: StateObjects.learnPractice);
  }

  Future<void> _getLearnPractices(
      {required int id, required LearnPractices practice}) async {
    final generation = _authenticationService.sessionGeneration;
    _practiceParentId = null;
    _practiceKind = null;
    _practiceSessionGeneration = null;
    _completionSaved = false;
    _completionFailed = false;
    _practices = [];
    _questions = [];
    if (id <= 0 || !await _statusChecker.checkConnection() || disposed) return;

    await _updatePaymentStatus();
    if (disposed || generation != _authenticationService.sessionGeneration) {
      return;
    }

    final List<LearnPractice> practices;
    if (practice == LearnPractices.course) {
      practices = await _apiService.getLearnCoursePractices(id);
    } else if (practice == LearnPractices.module) {
      practices = await _apiService.getLearnModulePractices(id);
    } else {
      practices = await _apiService.getLearnLessonPractices(id);
    }
    if (disposed ||
        generation != _authenticationService.sessionGeneration ||
        practices.isEmpty ||
        (practices.first.id ?? 0) <= 0 ||
        (practices.first.questionSetId ?? 0) <= 0) {
      return;
    }

    final questions =
        await _apiService.getLearnQuestions(practices.first.questionSetId!);
    if (disposed || generation != _authenticationService.sessionGeneration) {
      return;
    }
    _practices = practices;
    _questions = questions;
    // Bind completion to the navigation location, never parents.first: one
    // practice may be reused in a different lesson, module, or course.
    _practiceParentId = id;
    _practiceKind = practice;
    _practiceSessionGeneration = generation;
  }

  // Complete practice
  Future<bool> completeLearnPractice() async {
    if (disposed || _completionInFlight) return false;
    _completionInFlight = true;
    _completionFailed = false;
    setBusyForObject(StateObjects.completeLearnPractice, true);
    var success = false;
    try {
      if (!_hasActivePractice ||
          _practices.isEmpty ||
          _questions.isEmpty ||
          !await _statusChecker.checkConnection() ||
          !_hasActivePractice) {
        return false;
      }
      if (!_completionSaved) {
        await stopAudio();
        if (!_hasActivePractice) return false;
        final response = await _apiService.completePractice(
          id: _practices.first.id!,
          data: {
            'parent_id': _practiceParentId,
            'parent_kind': _practiceKind!.name.toUpperCase(),
          },
        );
        if (!_hasActivePractice ||
            response['status'] != ResponseStatus.success) {
          return false;
        }
        _completionSaved = true;
      }
      // A failed refresh must not turn a confirmed save into another POST.
      await _learnService.getLearnProgress();
      success = _hasActivePractice;
      return success;
    } catch (_) {
      // Keep answers on the results screen; never expose raw server details.
      return false;
    } finally {
      _completionInFlight = false;
      if (!disposed) {
        _completionFailed = !success;
        setBusyForObject(StateObjects.completeLearnPractice, false);
      }
    }
  }

  // Update  profile
  Future<void> updateProfile(String phoneNumber) async =>
      await runBusyFuture(_updateProfile(phoneNumber),
          busyObject: StateObjects.profileUpdate);

  Future<void> _updateProfile(String phoneNumber) async {
    Map<String, dynamic> data = {
      'gender': user?.gender,
      'region': user?.region,
      'country': user?.country,
      'phone_number': phoneNumber,
      'last_name': user?.lastName,
      'first_name': user?.firstName,
      'occupation': user?.occupation,
      'birth_day': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    };

    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response = await _apiService.completeProfile(data);
      if (response['status'] == ResponseStatus.success) {
        await _authenticationService.updateUserData(data);
        pop();
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }

  // Ios checkout
  Future<void> iosCheckout(Map<String, dynamic> data) async {
    if (await _statusChecker.checkConnection()) {
      await _apiService.iosCheckout(data);
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
