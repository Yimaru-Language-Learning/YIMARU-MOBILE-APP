import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_lesson.dart';
import 'package:yimaru_app/ui/views/learn_lesson/learn_lesson_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/mini_thumbnail.dart';

import '../common/app_colors.dart';
import '../common/helper_functions.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';
import 'custom_linear_progress_indicator.dart';

class LearnLessonTile extends ViewModelWidget<LearnLessonViewModel> {
  final LearnLesson lesson;
  final GestureTapCallback? onLessonTap;
  final GestureTapCallback? onPracticeTap;

  const LearnLessonTile(
      {super.key, this.onLessonTap, this.onPracticeTap, required this.lesson});

  @override
  Widget build(BuildContext context, LearnLessonViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(LearnLessonViewModel viewModel) => Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: kcPrimaryColor.withOpacity(0.1),
            // color: ProgressStatuses.pending == status
            //     ? kcPrimaryColor.withOpacity(0.1)
            //     : kcGreen.withOpacity(0.1),
          ),
        ),
        child: _buildExpansionTile(viewModel),
      );

  Widget _buildExpansionTile(LearnLessonViewModel viewModel) => ExpansionTile(
        enabled: true,
        title: _buildTitle(),
        textColor: kcDarkGrey,
        showTrailingIcon: true,
        initiallyExpanded: false,
        trailing: _buildPendingIcon(),
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        leading: _buildLeadingWrapper(),
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        backgroundColor: kcPrimaryColor.withOpacity(0.1),
        controlAffinity: ListTileControlAffinity.trailing,
        tilePadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        collapsedBackgroundColor: kcPrimaryColor.withOpacity(0.1),
        childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        // enabled: status != ProgressStatuses.pending,
        // backgroundColor: ProgressStatuses.pending == status
        //     ? kcPrimaryColor.withOpacity(0.1)
        //     : kcGreen.withOpacity(0.1),
        // collapsedBackgroundColor: ProgressStatuses.pending == status
        //     ? kcPrimaryColor.withOpacity(0.1)
        //     : kcGreen.withOpacity(0.1),
        // initiallyExpanded: status != ProgressStatuses.completed ? true : false,
        children: _buildExpansionTileChildren(viewModel),
      );

  Widget _buildLeadingWrapper() => MiniThumbnail(
      thumbnail:
          getReadableUrl(lesson.thumbnail ?? 'assets/images/image_1.png') ??
              'assets/images/image_1.png');

  Widget _buildTitle() => Text(
        lesson.title ?? '',
        maxLines: 1,
        softWrap: false,
        style: style16DG600,
      );

  // Widget _buildIconState() => ProgressStatuses.pending == status
  //     ? _buildPendingIcon()
  //     : _buildCompleteIcon();

  Widget _buildCompleteIcon() => const Icon(
        Icons.check,
        color: kcGreen,
      );

  Widget _buildPendingIcon() => const Icon(
        Icons.access_time_rounded,
        color: kcPrimaryColor,
      );

  List<Widget> _buildExpansionTileChildren(LearnLessonViewModel viewModel) =>
      [_buildExpansionTileItem(viewModel)];

  Widget _buildExpansionTileItem(LearnLessonViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildExpansionTileItemChildren(viewModel),
      );

  List<Widget> _buildExpansionTileItemChildren(
          LearnLessonViewModel viewModel) =>
      [
        _buildProgress(),
        horizontalSpaceSmall,
        _buildProgressText(),
        verticalSpaceSmall,
        _buildActionButtonWrapper(viewModel)
      ];

  Widget _buildProgress() => const CustomLinearProgressIndicator(
        progress: 0,
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
      );

  Widget _buildProgressText() => Text(
        'In Progress',
        style: style14P600,
      );

  Widget _buildActionButtonWrapper(LearnLessonViewModel viewModel) => SizedBox(
        height: 40,
        child: _buildActionButtons(viewModel),
      );

  Widget _buildActionButtons(LearnLessonViewModel viewModel) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: __buildActionButtonChildren(viewModel),
      );

  List<Widget> __buildActionButtonChildren(LearnLessonViewModel viewModel) => [
        _buildPracticeButtonWrapper(viewModel),
        horizontalSpaceSmall,
        _buildLessonButtonWrapper(viewModel)
      ];

  Widget _buildPracticeButtonWrapper(LearnLessonViewModel viewModel) =>
      SizedBox(
        width: 125,
        child: _buildPracticeButton(viewModel),
      );

  Widget _buildPracticeButton(LearnLessonViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        text: 'Practice',
        borderRadius: 12,
        onTap: onPracticeTap,
        trailingIcon: Icons.mic,
        width: double.maxFinite,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
      );

  Widget _buildLessonButtonWrapper(LearnLessonViewModel viewModel) => SizedBox(
        width: 125,
        child: _buildLessonButton(viewModel),
      );

  Widget _buildLessonButton(LearnLessonViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        text: 'Start',
        borderRadius: 12,
        onTap: onLessonTap,
        width: double.maxFinite,
        foregroundColor: kcWhite,
        trailingIcon: Icons.play_arrow,
        backgroundColor: kcPrimaryColor,
      );
}
