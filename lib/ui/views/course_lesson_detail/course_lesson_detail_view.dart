import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course_lesson.dart';
import 'package:yimaru_app/ui/views/course_lesson_detail/course_lesson_detail_viewmodel.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/empty_video_player.dart';
import '../../widgets/small_app_bar.dart';

class CourseLessonDetailView extends StackedView<CourseLessonDetailViewmodel> {
  final CourseLesson lesson;

  const CourseLessonDetailView({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  Future<void> _navigate(CourseLessonDetailViewmodel viewModel) async {
    viewModel.close();
    await viewModel.replaceWithCoursePractice(lesson.id ?? 0);
  }

  @override
  void onViewModelReady(CourseLessonDetailViewmodel viewModel) async {
    await viewModel.initializePlayer(
      lessonId: 0,
      moduleId: 0,
      url: lesson.videoUrl ?? '',
    );
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(CourseLessonDetailViewmodel viewModel) {
    super.onDispose(viewModel);
    viewModel.close();

  }

  @override
  CourseLessonDetailViewmodel viewModelBuilder(BuildContext context) =>
      CourseLessonDetailViewmodel();

  @override
  Widget builder(
    BuildContext context,
    CourseLessonDetailViewmodel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CourseLessonDetailViewmodel viewModel) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(CourseLessonDetailViewmodel viewModel) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CourseLessonDetailViewmodel viewModel) =>
      SafeArea(child: _buildColumn(viewModel));

  Widget _buildColumn(CourseLessonDetailViewmodel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBarWrapper(viewModel),
          _buildBodyColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBarWrapper(CourseLessonDetailViewmodel viewModel) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: _buildAppBar(viewModel));

  Widget _buildAppBar(CourseLessonDetailViewmodel viewModel) => SmallAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildBodyColumnWrapper(CourseLessonDetailViewmodel viewModel) =>
      Expanded(
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(CourseLessonDetailViewmodel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(
          CourseLessonDetailViewmodel viewModel) =>
      [
        _buildLevelsColumnWrapper(viewModel),
        if (lesson.hasPractice ?? false) _buildPracticeButtonWrapper(viewModel)
      ];

  Widget _buildLevelsColumnWrapper(CourseLessonDetailViewmodel viewModel) =>
      Expanded(child: _buildLevelsColumnScrollView(viewModel));

  Widget _buildLevelsColumnScrollView(CourseLessonDetailViewmodel viewModel) =>
      SingleChildScrollView(
        child: _buildLevelsColumn(viewModel),
      );

  Widget _buildLevelsColumn(CourseLessonDetailViewmodel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildLevelsColumnChildren(viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(
          CourseLessonDetailViewmodel viewModel) =>
      [
        verticalSpaceMedium,
        _buildVideoPlayerWrapper(viewModel),
        verticalSpaceMedium,
        _buildTitleWrapper(),
        verticalSpaceMedium,
        _buildDescriptionWrapper(),
      ];

  Widget _buildVideoPlayerWrapper(CourseLessonDetailViewmodel viewModel) =>
      Container(
        height: 200,
        color: kcBlack,
        width: double.maxFinite,
        child: _buildVideoPlayerState(viewModel),
      );

  Widget _buildVideoPlayerState(CourseLessonDetailViewmodel viewModel) =>
      viewModel.chewieController != null &&
              viewModel.videoPlayerController != null &&
              !viewModel.busy(StateObjects.loadLessonVideo)
          ? _buildVideoPlayer(viewModel)
          : _buildEmptyVideoPlayer();

  Widget _buildVideoPlayer(CourseLessonDetailViewmodel viewModel) =>
      _buildChewiePlayer(viewModel);

  Widget _buildChewiePlayer(CourseLessonDetailViewmodel viewModel) => Chewie(
        controller: viewModel.chewieController!,
      );

  Widget _buildEmptyVideoPlayer() => const EmptyVideoPlayer();

  Widget _buildTitleWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildTitle(),
      );

  Widget _buildTitle() => Text(
        lesson.title ?? '',
        style: style16DG600,
      );

  Widget _buildDescriptionWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildDescription(),
      );

  Widget _buildDescription() => Text(
        lesson.description ?? '',
        style: style14DG400,
      );

  Widget _buildPracticeButtonWrapper(CourseLessonDetailViewmodel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 50,
        ),
        child: _buildPracticeButton(viewModel),
      );

  Widget _buildPracticeButton(CourseLessonDetailViewmodel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Start Assessment',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _navigate(viewModel),
      );
}
