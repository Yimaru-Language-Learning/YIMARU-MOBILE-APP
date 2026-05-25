import 'package:chewie/chewie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_lesson.dart';
import 'package:yimaru_app/models/learn_module.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/empty_video_player.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_lesson_detail_viewmodel.dart';

class LearnLessonDetailView extends StackedView<LearnLessonDetailViewModel> {
  final bool hasPractice;
  final LearnModule module;
  final LearnLesson lesson;

  const LearnLessonDetailView(
      {Key? key,
      required this.lesson,
      required this.module,
      required this.hasPractice})
      : super(key: key);

  Future<void> _navigate(LearnLessonDetailViewModel viewModel) async {
    await viewModel.pause();
    await viewModel.navigateToLearnPractice(lesson.id ?? 0);
  }

  @override
  void onViewModelReady(LearnLessonDetailViewModel viewModel) async {
    await viewModel.initializePlayer(
      lessonId: lesson.id ?? 0,
      moduleId: module.id ?? 0,
      url: lesson.videoUrl ?? '',
    );
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(LearnLessonDetailViewModel viewModel) {
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
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(LearnLessonDetailViewModel viewModel) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
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
        onPop: viewModel.pop,
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
        if (hasPractice) _buildPracticeButtonWrapper(viewModel)
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
        child: _buildVideoPlayerState(viewModel),
      );

  Widget _buildVideoPlayerState(LearnLessonDetailViewModel viewModel) =>
      viewModel.chewieController != null &&
              viewModel.videoPlayerController != null &&
              !viewModel.busy(StateObjects.loadLessonVideo)
          ? _buildVideoPlayer(viewModel)
          : _buildEmptyVideoPlayer();

  Widget _buildVideoPlayer(LearnLessonDetailViewModel viewModel) =>
      _buildChewiePlayer(viewModel);

  Widget _buildChewiePlayer(LearnLessonDetailViewModel viewModel) => Chewie(
        controller: viewModel.chewieController!,
      );

  Widget _buildEmptyVideoPlayer() => const EmptyVideoPlayer();

  Widget _buildDescriptionWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildDescription(),
      );

  Widget _buildDescription() => Text(
        lesson.description ?? '',
        style: style14DG400,
      );

  Widget _buildPracticeButtonWrapper(LearnLessonDetailViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 50,
        ),
        child: _buildPracticeButton(viewModel),
      );

  Widget _buildPracticeButton(LearnLessonDetailViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        text:LocaleKeys.take_practice.tr() ,
        onTap: () async => await _navigate(viewModel),
      );
}
