import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';

import '../common/app_colors.dart';
import 'custom_circular_progress_indicator.dart';

class ListenableReviewPracticeCard
    extends ViewModelWidget<CoursePracticeViewModel> {
  final String audio;
  final String busyObject;

  const ListenableReviewPracticeCard(
      {super.key, required this.audio, required this.busyObject});

  Widget _getButtonState(CoursePracticeViewModel viewModel) {
    if (busyObject == viewModel.busyObject) {
      if (viewModel.busy(busyObject)) {
        return _buildProgressIndicatorWrapper();
      } else if (viewModel.player.state == PlayerState.playing) {
        return _buildPauseIcon();
      }
      return _buildPlayIcon();
    }

    return _buildPlayIcon();
  }

  Widget _getProgressState(CoursePracticeViewModel viewModel) {
    if (busyObject == viewModel.busyObject) {
      if (viewModel.busy(busyObject)) {
        return _buildColumnWrapper(active: true, viewModel: viewModel);
      } else if (viewModel.player.state == PlayerState.playing) {
        return _buildColumnWrapper(active: true, viewModel: viewModel);
      }
      return _buildColumnWrapper(active: false, viewModel: viewModel);
    }

    return _buildColumnWrapper(active: false, viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(CoursePracticeViewModel viewModel) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: kcPrimaryColor.withValues(alpha: 0.1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: _buildRow(viewModel),
      );

  Widget _buildRow(CoursePracticeViewModel viewModel) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildRowChildren(viewModel),
      );

  List<Widget> _buildRowChildren(CoursePracticeViewModel viewModel) => [
        _buildPlayButton(viewModel),
        horizontalSpaceTiny,
        _getProgressState(viewModel)
      ];

  Widget _buildPlayButton(CoursePracticeViewModel viewModel) => ElevatedButton(
        onPressed: () async => viewModel.player.state == PlayerState.playing
            ? await viewModel.pauseAudio()
            : await viewModel.playReview(audio: audio, busyObject: busyObject),
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(CircleBorder()),
          padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
          shadowColor: WidgetStatePropertyAll(kcPrimaryColor),
          backgroundColor: WidgetStatePropertyAll(kcPrimaryColor),
        ),
        child: _buildButtonState(viewModel),
      );

  Widget _buildButtonState(CoursePracticeViewModel viewModel) =>
      _getButtonState(viewModel);

  Widget _buildProgressIndicatorWrapper() => Center(
        child: _buildProgressIndicator(),
      );

  Widget _buildProgressIndicator() =>
      const CustomCircularProgressIndicator(color: kcWhite);

  Widget _buildPlayIcon() => const Icon(
        Icons.play_arrow_rounded,
        size: 25,
        color: kcWhite,
      );

  Widget _buildPauseIcon() => const Icon(
        Icons.pause,
        size: 25,
        color: kcWhite,
      );

  Widget _buildColumnWrapper(
          {required bool active, required CoursePracticeViewModel viewModel}) =>
      Expanded(
        child: _buildColumn(active: active, viewModel: viewModel),
      );

  Widget _buildColumn(
          {required bool active, required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(active: active, viewModel: viewModel),
      );

  List<Widget> _buildColumnChildren(
          {required bool active, required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceTiny,
        _buildLinearProgressIndicator(active: active, viewModel: viewModel),
        verticalSpaceTiny,
        _buildSubtitle(active: active, viewModel: viewModel)
      ];

  Widget _buildSubtitle(
          {required bool active, required CoursePracticeViewModel viewModel}) =>
      Text(
        active ? 'Playing' : 'Stopped',
        style: active ? style14P400 : style14MG400,
      );

  Widget _buildLinearProgressIndicator(
          {required bool active, required CoursePracticeViewModel viewModel}) =>
      CustomLinearProgressIndicator(
        activeColor: kcPrimaryColor,
        progress: active ? viewModel.progress : 0,
        backgroundColor: kcPrimaryColor.withValues(alpha: 0.1),
      );
}
