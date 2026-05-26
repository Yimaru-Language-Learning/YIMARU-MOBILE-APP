import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_lesson.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_lesson/learn_lesson_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/mini_thumbnail.dart';

import '../common/app_colors.dart';
import '../common/helper_functions.dart';

import '../common/ui_helpers.dart';
import 'custom_container_shader.dart';
import 'custom_elevated_button.dart';
import 'custom_linear_progress_indicator.dart';

class LearnLessonTile extends ViewModelWidget<LearnLessonViewModel> {
  final int index;
  final LearnLesson lesson;
  final GestureTapCallback? onLessonTap;
  final GestureTapCallback? onPracticeTap;

  const LearnLessonTile(
      {super.key,
      this.onLessonTap,
      this.onPracticeTap,
      required this.index,
      required this.lesson});

  @override
  Widget build(BuildContext context, LearnLessonViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(LearnLessonViewModel viewModel) => Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: (lesson.access?.isCompleted ?? false)
                ? kcGreen.withOpacity(0.1)
                : kcPrimaryColor.withOpacity(0.1),
          ),
        ),
        child: _buildTileStack(viewModel),
      );

  Widget _buildTileStack(LearnLessonViewModel viewModel) => Stack(
        children: [
          _buildExpansionTile(viewModel),
          _buildContainerShaderState()
        ],
      );

  Widget _buildExpansionTile(LearnLessonViewModel viewModel) => ExpansionTile(
        title: _buildTitle(),
        textColor: kcDarkGrey,
        showTrailingIcon: true,
        trailing: _buildIconState(),
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        leading: _buildLeadingWrapper(),
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        enabled: (lesson.access?.isAccessible ?? false),
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        backgroundColor: (lesson.access?.isCompleted ?? false)
            ? kcGreen.withOpacity(0.1)
            : kcPrimaryColor.withOpacity(0.1),
        childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
       initiallyExpanded: (lesson.access?.isAccessible ?? false) &&
            !(lesson.access?.isCompleted ?? false),
        collapsedBackgroundColor: (lesson.access?.isCompleted ?? false)
            ? kcGreen.withOpacity(0.1)
            : kcPrimaryColor.withOpacity(0.1),
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

  Widget _buildIconState() => (lesson.access?.isCompleted ?? false)
      ? _buildCompleteIcon()
      : _buildPendingIcon();

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

  Widget _buildProgress() => CustomLinearProgressIndicator(
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
        progress: (lesson.access?.progressPercent ?? 0) / 100,
      );

  Widget _buildProgressText() => Text(
        (lesson.access?.isCompleted ?? false)
            ? LocaleKeys.completed.tr()
            : LocaleKeys.in_progress.tr(),
        style: style14P600,
      );

  Widget _buildActionButtonWrapper(LearnLessonViewModel viewModel) => SizedBox(
        height: 40,
        child: _buildActionButtons(viewModel),
      );

  Widget _buildActionButtons(LearnLessonViewModel viewModel) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _buildActionButtonChildren(viewModel),
      );

  List<Widget> _buildActionButtonChildren(LearnLessonViewModel viewModel) => [
        if (index != viewModel.lessons.length - 1)
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
        borderRadius: 12,
        onTap: onPracticeTap,
        trailingIcon: Icons.mic,
        width: double.maxFinite,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        text: LocaleKeys.practice.tr(),
        foregroundColor: kcPrimaryColor,
      );

  Widget _buildLessonButtonWrapper(LearnLessonViewModel viewModel) => SizedBox(
        width: 125,
        child: _buildLessonButton(viewModel),
      );

  Widget _buildLessonButton(LearnLessonViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        onTap: onLessonTap,
        width: double.maxFinite,
        foregroundColor: kcWhite,
        text: LocaleKeys.start.tr(),
        trailingIcon: Icons.play_arrow,
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildContainerShaderState() => !(lesson.access?.isAccessible ?? false)
      ? _buildContainerShader()
      : Container();

  Widget _buildContainerShader() => const CustomContainerShader();
}
