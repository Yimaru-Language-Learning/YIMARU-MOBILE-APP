import 'package:chewie/chewie.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_player/video_player.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/learn_lesson.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/authentication_service.dart';
import '../../../services/learn_service.dart';
import '../../../services/status_checker_service.dart';
import '../../../services/vimeo_service.dart';
import '../../common/ui_helpers.dart';

class LearnLessonDetailViewModel extends ReactiveViewModel {
  // Dependency injection

  final _apiService = locator<ApiService>();

  final _learnService = locator<LearnService>();

  final _vimeoService = locator<VimeoService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_learnService, _authenticationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // Learn lessons
  List<LearnLesson> get _lessons => _learnService.lessons;

  List<LearnLesson> get lessons => _lessons;

  // Video player config
  int _lastCheckpoint = 0;

  bool _lessonCompleted = false;

  bool _isUpdatingProgress = false;

  ChewieController? _chewieController;

  ChewieController? get chewieController => _chewieController;

  VideoPlayerController? _videoPlayerController;

  VideoPlayerController? get videoPlayerController => _videoPlayerController;

  // Video player
  void close() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
  }

  Future<void> pause() async {
    await _chewieController?.pause();
  }

  Future<void> initializePlayer({
    required String url,
    required int lessonId,
  }) async {
    // Reset tracking state
    _lessonCompleted = false;
    _isUpdatingProgress = false;
    _lastCheckpoint = 0;

    final playableUrl = await _vimeoService.getVideoUrl(url);

    if (playableUrl == null) {
      throw Exception("Unable to load video");
    }

    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(playableUrl));

    await _videoPlayerController!.initialize();

    _videoPlayerController!.addListener(() async {
      final controller = _videoPlayerController;

      if (controller == null || !controller.value.isInitialized) {
        return;
      }

      final position = controller.value.position.inSeconds;
      final duration = controller.value.duration.inSeconds;

      if (duration <= 0) return;

      // ===========================
      // Every 10 seconds
      // ===========================
      final checkpoint = position ~/ 10;

      if (checkpoint > 0 &&
          checkpoint > _lastCheckpoint &&
          !_isUpdatingProgress) {
        _isUpdatingProgress = true;
        _lastCheckpoint = checkpoint;

        try {
          Map<String, dynamic> data = {
            "ended": false,
            "content_id": lessonId,
            "position_sec": position,
            "duration_sec": duration,
            "content_kind": "lms_lesson",
          };
          await markLessonProgress(data);
        } finally {
          _isUpdatingProgress = false;
        }
      }

      // ===========================
      // Video completed
      // ===========================
      final isCompleted =
          position >= duration - 1 && !controller.value.isPlaying;

      if (isCompleted && !_lessonCompleted && !_isUpdatingProgress) {
        _lessonCompleted = true;
        _isUpdatingProgress = true;

        try {
          Map<String, dynamic> data = {
            "ended": true,
            "content_id": lessonId,
            "position_sec": position,
            "duration_sec": duration,
            "content_kind": "lms_lesson",
          };
          await markLessonProgress(data);
        } finally {
          _isUpdatingProgress = false;
        }
      }
    });

    _chewieController = ChewieController(
      looping: false,
      autoPlay: true,
      showOptions: true,
      showControls: true,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      allowedScreenSleep: false,
      videoPlayerController: _videoPlayerController!,
      materialProgressColors: buildChewieProgressIndicator,
    );

    notifyListeners();
  }

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnSubscription() async =>
      await _navigationService.navigateToLearnSubscriptionView();

  Future<void> replaceWithLearnPractice(int id) async =>
      await _navigationService.replaceWithLearnPracticeView(
        id: id,
        label: 'Start Practice',
        practice: LearnPractices.lesson,
        title: 'Let\'s practice what you just learnt!',
        subtitle:
            'I’ll ask you a few questions, and you can respond naturally.',
      );

  // Remote api call

  // Mark lesson
  Future<void> markLessonProgress(Map<String, dynamic> data) async =>
      await runBusyFuture(_markVideoProgress(data),
          busyObject: StateObjects.learnLessons);

  Future<void> _markVideoProgress(Map<String, dynamic> data) async {
    if (await _statusChecker.checkConnection()) {
      await _apiService.markLessonProgress(data);
    }
  }
}
