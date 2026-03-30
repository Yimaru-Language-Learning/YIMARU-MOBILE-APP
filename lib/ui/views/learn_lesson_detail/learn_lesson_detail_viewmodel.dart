import 'package:chewie/chewie.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_player/video_player.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../../../app/app.locator.dart';
import '../../../services/status_checker_service.dart';

class LearnLessonDetailViewModel extends BaseViewModel {
  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Video player config
  ChewieController? _chewieController;

  ChewieController? get chewieController => _chewieController;

  VideoPlayerController? _videoPlayerController;

  VideoPlayerController? get videoPlayerController => _videoPlayerController;

  // Video player
  Future<void> initializePlayer() async =>
      await runBusyFuture(_initializePlayer(),
          busyObject: StateObjects.loadLessonVideo);

  Future<void> _initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(kSampleVideoUrl));

    await _videoPlayerController?.initialize();

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
          materialProgressColors: buildChewieProgressIndicator);
    }

    //  rebuildUi();
  }

  Future<void> pause() async {
    await _chewieController?.pause();
  }

  void close() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
  }

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnPractice(
          List<Map<String, dynamic>> practices) async =>
      await _navigationService.navigateToLearnPracticeView(
        practices: practices,
        buttonLabel: 'Start Practice',
        title: 'Let \'s practice what you just learnt!',
        subtitle:
            'I’ll ask you a few questions, and you can respond naturally.',
      );
}
