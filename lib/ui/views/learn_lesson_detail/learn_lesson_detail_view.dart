import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:yimaru_app/ui/widgets/empty_video_player.dart';

import '../../../models/lesson.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_lesson_detail_viewmodel.dart';

class LearnLessonDetailView extends StackedView<LearnLessonDetailViewModel> {
  final Lesson lesson;

  const LearnLessonDetailView({Key? key, required this.lesson})
      : super(key: key);

  Future<void> _navigate(LearnLessonDetailViewModel viewModel) async {
    await viewModel.pause();
  //   await viewModel.navigateToLearnPractice(practices);
  }

  @override
  void onDispose(LearnLessonDetailViewModel viewModel) {
    print('DISPOSED');
    viewModel.close();
    super.onDispose(viewModel);
  }

  @override
  LearnLessonDetailViewModel viewModelBuilder(BuildContext context) =>
      LearnLessonDetailViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnLessonDetailViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnLessonDetailViewModel viewModel) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnLessonDetailViewModel viewModel) =>
      SafeArea(child: _buildColumn(viewModel));

  Widget _buildColumn(LearnLessonDetailViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBarWrapper(viewModel),
          _buildBodyColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBarWrapper(LearnLessonDetailViewModel viewModel) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: _buildAppBar(viewModel));

  Widget _buildAppBar(LearnLessonDetailViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildBodyColumnWrapper(LearnLessonDetailViewModel viewModel) =>
      Expanded(
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(LearnLessonDetailViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(LearnLessonDetailViewModel viewModel) =>
      [
        _buildLevelsColumnWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildLevelsColumnWrapper(LearnLessonDetailViewModel viewModel) =>
      Expanded(child: _buildLevelsColumnScrollView(viewModel));

  Widget _buildLevelsColumnScrollView(LearnLessonDetailViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildLevelsColumn(viewModel),
      );

  Widget _buildLevelsColumn(LearnLessonDetailViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildLevelsColumnChildren(viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(
          LearnLessonDetailViewModel viewModel) =>
      [
        verticalSpaceMedium,
        _buildTitleWrapper(),
        verticalSpaceLarge,
        _buildVideoPlayerWrapper(viewModel),
        verticalSpaceMedium,
        _buildDescriptionWrapper(),
      ];

  Widget _buildTitleWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildTitle(),
      );

  Widget _buildTitle() => Text(
        lesson.title ?? '',
        style: style16DG600,
      );

  Widget _buildVideoPlayerWrapper(LearnLessonDetailViewModel viewModel) =>
      Container(
        height: 200,
        color: kcBlack,
        width: double.maxFinite,
        child: _buildVideoPlayer(viewModel),
      );



  Widget _buildVideoPlayer(LearnLessonDetailViewModel viewModel) =>
      _buildVimeoPlayer(viewModel);

  Widget _buildVimeoPlayer(LearnLessonDetailViewModel viewModel) =>
      VimeoVideoPlayer(
        isAutoPlay: true,
        onInAppWebViewCreated: (controller) =>
            viewModel.initializePlayer(controller),
        videoId: lesson.teachingVideoUrl?.split('/').last ?? '',
      );

  Widget _buildEmptyVideoPlayer() => const EmptyVideoPlayer();

  Widget _buildDescriptionWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildDescription(),
      );

  Widget _buildDescription() => Text(
        lesson.description ?? '',
        style: style14DG600,
      );

  Widget _buildContinueButtonWrapper(LearnLessonDetailViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 50,
        ),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(LearnLessonDetailViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Lessons',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _navigate(viewModel),
      );
}
