import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/progress_status.dart';

import '../../models/learn_course.dart';
import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import '../views/learn_course/learn_course_viewmodel.dart';
import 'custom_elevated_button.dart';

class LearnCourseTile extends ViewModelWidget<LearnCourseViewModel> {
  final LearnCourse course;
  final GestureTapCallback? onViewTap;
  final GestureTapCallback? onPracticeTap;

  const LearnCourseTile({
    super.key,
    this.onViewTap,
    this.onPracticeTap,
    required this.course,
  });

  @override
  Widget build(BuildContext context, LearnCourseViewModel viewModel) =>
      _buildExpansionTileCard(viewModel);

  Widget _buildExpansionTileCard(LearnCourseViewModel viewModel) => Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kcPrimaryColor.withOpacity(0.1)),
        ),
        child: _buildExpansionTile(viewModel),
      );

  Widget _buildExpansionTile(LearnCourseViewModel viewModel) => ExpansionTile(
        textColor: kcDarkGrey,
        subtitle: _buildContent(),
        title: _buildTitleWrapper(),
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        enabled: (course.access?.isAccessible ?? false),
        backgroundColor: kcPrimaryColor.withOpacity(0.1),
        controlAffinity: ListTileControlAffinity.trailing,
        tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        showTrailingIcon: (course.access?.isAccessible ?? false),
        initiallyExpanded: (course.access?.isAccessible ?? false),
        collapsedBackgroundColor: (course.access?.isAccessible ?? false)
            ? kcPrimaryColor.withOpacity(0.1)
            : kcBackgroundColor,
        children: _buildExpansionTileChildren(viewModel),
      );

  List<Widget> _buildExpansionTileChildren(LearnCourseViewModel viewModel) => [
        _buildDivider(),
        verticalSpaceSmall,
        _buildActionButtonsWrapper(viewModel),
        verticalSpaceSmall,
      ];

  Widget _buildTitleWrapper() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: _buildTitleState(),
      );

  Widget _buildTitleState() => (course.access?.isAccessible ?? false)
      ? _buildActiveTitleWrapper()
      : _buildInactiveTitleWrapper();

  Widget _buildInactiveTitleWrapper() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildInactiveTitleChildren(),
      );

  List<Widget> _buildInactiveTitleChildren() => [
        _buildLockIcon(),
        verticalSpaceSmall,
        _buildTitle(),
      ];

  Widget _buildLockIcon() => const Icon(
        Icons.lock_outline_rounded,
        color: kcLightGrey,
      );

  Widget _buildActiveTitleWrapper() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildActiveTitleChildren(),
      );

  List<Widget> _buildActiveTitleChildren() =>
      [_buildTitle(), horizontalSpaceSmall, _buildProgressStatusState()];

  Widget _buildTitle() => Text(
        course.name ?? '',
        style:
            (course.access?.isAccessible ?? false) ? style16P600 : style16DG600,
      );

  Widget _buildProgressStatusState() =>
      !(course.access?.isCompleted ?? false) &&
              course.access?.progressPercent != 0
          ? _buildProgressStatus()
          : Container();

  Widget _buildProgressStatus() => const ProgressStatus(
        color: kcPrimaryColor,
        status: 'Current Level',
      );

  Widget _buildContent() => Text(
        course.description ?? '',
        style: style14DG400,
      );

  Widget _buildDivider() => const Divider(color: kcVeryLightGrey);

  Widget _buildActionButtonsWrapper(LearnCourseViewModel viewModel) =>
      Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildActionButtons(viewModel),
      );

  Widget _buildActionButtons(LearnCourseViewModel viewModel) => Row(
        children: [
          _buildViewButtonWrapper(viewModel),
          horizontalSpaceSmall,
          _buildPracticeButtonWrapper(viewModel)
        ],
      );

  Widget _buildViewButtonWrapper(LearnCourseViewModel viewModel) => Expanded(
        child: _buildModuleButton(viewModel),
      );

  Widget _buildModuleButton(LearnCourseViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        onTap: onViewTap,
        text: 'View Courses',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildPracticeButtonWrapper(LearnCourseViewModel viewModel) =>
      Expanded(
        child: _buildPracticeButton(viewModel),
      );

  Widget _buildPracticeButton(LearnCourseViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        onTap: onPracticeTap,
        text: 'Take Practices',
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
      );
}
