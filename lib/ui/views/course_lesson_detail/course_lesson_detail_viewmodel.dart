import 'package:chewie/chewie.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_player/video_player.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/course_lesson.dart';
import 'package:yimaru_app/services/api_service.dart';

import '../../../app/app.locator.dart';
import '../../common/app_constants.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';

class CourseLessonDetailViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _navigationService = locator<NavigationService>();

  // Video player config
  bool _isCompleted = false;

  ChewieController? _chewieController;

  ChewieController? get chewieController => _chewieController;

  VideoPlayerController? _videoPlayerController;

  VideoPlayerController? get videoPlayerController => _videoPlayerController;

  // Video player
  Future<void> initializePlayer(CourseLesson lesson) async =>
      await runBusyFuture(_initializePlayer(lesson),
          busyObject: StateObjects.loadCourseVideo);

  Future<void> _initializePlayer(CourseLesson lesson) async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(kSampleVideoUrl));

    await _videoPlayerController?.initialize();

    _videoPlayerController
        ?.addListener(() async => await _videoListener(lesson));

    if (_videoPlayerController != null) {
      _chewieController = ChewieController(
        looping: true,
        autoPlay: true,
        showOptions: true,
        showControls: true,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        allowedScreenSleep: false,
        videoPlayerController: _videoPlayerController!,
        materialProgressColors: buildChewieProgressIndicator,
      );
    }

    rebuildUi();
  }

  Future<void> _videoListener(CourseLesson lesson) async {
    final controller = _videoPlayerController;

    if (controller == null || !controller.value.isInitialized) return;

    final position = controller.value.position;
    final duration = controller.value.duration;

    if (duration.inSeconds == 0) return;

    double progress = position.inSeconds / duration.inSeconds;

    print("Video progress: ${(progress * 100).toStringAsFixed(2)}%");

    // Example: mark completion at 95%
    if (progress >= 0.95) {
      await _onVideoCompleted(lesson);
    }
  }

  Future<void> _onVideoCompleted(CourseLesson lesson) async {
    if (_isCompleted) return;

    _isCompleted = true;

    print("Video completed!");

    await _apiService.completeLesson(lesson.id ?? 0);
  }

  Future<void> pause() async {
    await _chewieController?.pause();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToCoursePractice(int id) =>
      _navigationService.navigateToCoursePracticeView(id: id);
}
