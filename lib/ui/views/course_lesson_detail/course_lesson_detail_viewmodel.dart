import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_player/video_player.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/vimeo_service.dart';
import '../../../services/course_service.dart';
import '../../../models/course_lesson.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';

class CourseLessonDetailViewmodel extends ReactiveViewModel {
  // Dependency injection

  final _vimeoService = locator<VimeoService>();

  final _navigationService = locator<NavigationService>();

  final _courseService = locator<CourseService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_courseService];

  CourseLesson? _lesson;
  CourseLesson? get currentLesson => _lesson;
  bool _closed = false;
  bool _leaving = false;

  void bindLesson(CourseLesson lesson) {
    _lesson = lesson;
    _courseService.addListener(_updateLesson);
    _updateLesson();
  }

  void _updateLesson() {
    final previous = _lesson;
    if (_closed ||
        previous == null ||
        _courseService.lessonSync.loadedModuleId != previous.unitModuleId) {
      return;
    }
    final matches =
        _courseService.lessons.where((item) => item.id == previous.id);
    if (matches.isEmpty || matches.first.access?.isAccessible == false) {
      if (_leaving) return;
      _leaving = true;
      if (_chewieController?.isFullScreen == true) {
        _chewieController!.exitFullScreen();
      }
      // Stacked iterates its listeners directly; dispose after notification ends.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (disposed || _closed) return;
        close();
        pop();
      });
      WidgetsBinding.instance.scheduleFrame();
      return;
    }
    _lesson = matches.first;
    notifyListeners();
  }

  // Video player config
  bool _lessonCompleted = false;

  ChewieController? _chewieController;

  ChewieController? get chewieController => _chewieController;

  VideoPlayerController? _videoPlayerController;

  VideoPlayerController? get videoPlayerController => _videoPlayerController;

  // Video player
  void close() {
    if (_closed) return;
    _closed = true;
    _courseService.removeListener(_updateLesson);
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    _chewieController = null;
    _videoPlayerController = null;
  }

  @override
  void dispose() {
    close();
    super.dispose();
  }

  Future<void> pause() async {
    await _chewieController?.pause();
  }

  Future<void> initializePlayer(
          {required String url,
          required int lessonId,
          required int moduleId}) async =>
      await runBusyFuture(
          _initializePlayer(url: url, moduleId: moduleId, lessonId: lessonId),
          busyObject: StateObjects.loadLessonVideo);

  Future<void> _initializePlayer(
      {required String url,
      required int lessonId,
      required int moduleId}) async {
    final playableUrl = await _vimeoService.getVideoUrl(url);

    if (_closed || _leaving) return;

    if (playableUrl == null) {
      throw Exception("Unable to load video");
    }

    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(playableUrl));

    try {
      await _videoPlayerController?.initialize();
    } catch (_) {
      if (_closed) return;
      rethrow;
    }

    if (_closed || _leaving) return;

    // Listen for video completion
    _videoPlayerController?.addListener(() async {
      final controller = _videoPlayerController;

      if (controller == null || _lessonCompleted) return;

      final position = controller.value.position.inSeconds;
      final duration = controller.value.duration.inSeconds;

      if (duration <= 0) return;

      // Calculate watched percentage
      final progress = position / duration;

      // Mark complete at 95%
      if (progress >= 0.95) {
        _lessonCompleted = true;

        /*  await completeLearnLesson(
          lessonId: lessonId,
          moduleId: moduleId,
        );*/
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

  Future<void> replaceWithCoursePractice(
          {required int id, required SubscriptionType type}) async =>
      await _navigationService.replaceWithCoursePracticeView(
          id: id, type: type, practice: CoursePractices.lesson);
}
