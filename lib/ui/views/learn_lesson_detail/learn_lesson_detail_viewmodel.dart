import 'package:chewie/chewie.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_player/video_player.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
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
      print('Initialized');
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

  Future<void> pause()async{
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

  Future<void> navigateToLearnPractice() async=>await _navigationService.navigateToLearnPracticeView();

}
