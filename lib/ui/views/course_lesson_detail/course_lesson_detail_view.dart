import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/course_lesson.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/empty_video_player.dart';
import '../../widgets/small_app_bar.dart';
import 'course_lesson_detail_viewmodel.dart';

class CourseLessonDetailView extends StackedView<CourseLessonDetailViewModel> {
  final CourseLesson lesson;

  const CourseLessonDetailView({Key? key, required this.lesson})
      : super(key: key);

  @override
  void onViewModelReady(CourseLessonDetailViewModel viewModel) async {
    await viewModel.initializePlayer(lesson);
    super.onViewModelReady(viewModel);
  }

  @override
  CourseLessonDetailViewModel viewModelBuilder(BuildContext context) =>
      CourseLessonDetailViewModel();

  @override
  Widget builder(
    BuildContext context,
    CourseLessonDetailViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CourseLessonDetailViewModel viewModel) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CourseLessonDetailViewModel viewModel) =>
      SafeArea(child: _buildColumn(viewModel));

  Widget _buildColumn(CourseLessonDetailViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBarWrapper(viewModel),
          _buildBodyColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBarWrapper(CourseLessonDetailViewModel viewModel) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: _buildAppBar(viewModel));

  Widget _buildAppBar(CourseLessonDetailViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        showBackButton: true,
        title: lesson.title ?? '',
      );

  Widget _buildBodyColumnWrapper(CourseLessonDetailViewModel viewModel) =>
      Expanded(
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(CourseLessonDetailViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(
          CourseLessonDetailViewModel viewModel) =>
      [
        _buildLevelsColumnWrapper(viewModel),
        //  _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildLevelsColumnWrapper(CourseLessonDetailViewModel viewModel) =>
      Expanded(child: _buildLevelsColumnScrollView(viewModel));

  Widget _buildLevelsColumnScrollView(CourseLessonDetailViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildLevelsColumn(viewModel),
      );

  Widget _buildLevelsColumn(CourseLessonDetailViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildLevelsColumnChildren(viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(
          CourseLessonDetailViewModel viewModel) =>
      [
        verticalSpaceLarge,
        _buildVideoPlayerWrapper(viewModel),
        verticalSpaceMedium,
        _buildDescriptionWrapper(),
      ];

  Widget _buildVideoPlayerWrapper(CourseLessonDetailViewModel viewModel) =>
      Container(
        height: 200,
        color: kcBlack,
        width: double.maxFinite,
        child: _buildVideoPlayerState(viewModel),
      );

  Widget _buildVideoPlayerState(CourseLessonDetailViewModel viewModel) =>
      viewModel.chewieController != null &&
              viewModel.videoPlayerController != null &&
              !viewModel.busy(StateObjects.loadCourseVideo)
          ? _buildVideoPlayer(viewModel)
          : _buildEmptyVideoPlayer();

  Widget _buildVideoPlayer(CourseLessonDetailViewModel viewModel) =>
      _buildChewiePlayer(viewModel);

  Widget _buildChewiePlayer(CourseLessonDetailViewModel viewModel) =>
      Chewie(controller: viewModel.chewieController!);

  Widget _buildEmptyVideoPlayer() => const EmptyVideoPlayer();

  Widget _buildDescriptionWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildDescription(),
      );

  Widget _buildDescription() => Text(
        lesson.description ?? '',
        style: style14DG600,
      );

  Widget _buildPracticeButtonWrapper(CourseLessonDetailViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 50,
        ),
        child: _buildPracticeButton(viewModel),
      );

  Widget _buildPracticeButton(CourseLessonDetailViewModel viewModel) =>
       CustomElevatedButton(
        height: 55,
        text: 'Practice',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async =>
            await viewModel.navigateToCoursePractice(lesson.courseId ?? 0),
      );
}
