import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course_lesson.dart';
import 'package:yimaru_app/models/course_module.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/course_module/course_module_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/course_lesson_tile.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';
import 'package:yimaru_app/ui/widgets/finish_practice_sheet.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class CourseModuleTileLarge extends ViewModelWidget<CourseModuleViewModel> {
  final bool first;
  final CourseModule? module;
  final List<CourseLesson> lessons;
  final GestureTapCallback? onContinueTap;

  const CourseModuleTileLarge(
      {super.key,
      this.onContinueTap,
      required this.first,
      required this.module,
      required this.lessons});

  Future<void> _onPractice(
      {required int index,
      required CourseLesson lesson,
      required BuildContext context,
      required CourseModuleViewModel viewModel}) async {
    await viewModel.navigateToCoursePractice(lesson.id ?? 0);

    /* if (viewModel.user?.subscriptionStatus?.toLowerCase() == 'active') {
      if (lesson.access?.isAccessible ?? false) {
        await viewModel.navigateToCoursePractice(lesson.id ?? 0);
      } else {
        await _showSheet(context: context, viewModel: viewModel);
      }
    } else {
      if (first && index < 3) {
        await viewModel.navigateToCoursePractice(lesson.id ?? 0);
      } else {
        await _showSheet(context: context, viewModel: viewModel);
      }
    }*/
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required CourseModuleViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        backgroundColor: kcTransparent,
        builder: (_) => _buildSheet(viewModel),
      );

  @override
  Widget build(BuildContext context, CourseModuleViewModel viewModel) =>
      _buildExpansionTileCard(context: context, viewModel: viewModel);

  Widget _buildExpansionTileCard(
          {required BuildContext context,
          required CourseModuleViewModel viewModel}) =>
      Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kcVeryLightGrey),
        ),
        child: _buildTileStack(context: context, viewModel: viewModel),
      );

  Widget _buildTileStack(
          {required BuildContext context,
          required CourseModuleViewModel viewModel}) =>
      Stack(
        children: [
          _buildExpansionTile(context: context, viewModel: viewModel),
          // _buildContainerShaderState()
        ],
      );

  Widget _buildExpansionTile(
          {required BuildContext context,
          required CourseModuleViewModel viewModel}) =>
      ExpansionTile(
        enabled: true,
        title: _buildTitle(),
        textColor: kcDarkGrey,
        showTrailingIcon: true,
        initiallyExpanded: true,
        subtitle: _buildSubtitle(),
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        leading: _buildLeadingWrapper(),
        backgroundColor: kcBackgroundColor,
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        collapsedBackgroundColor: kcBackgroundColor,
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: const EdgeInsets.symmetric(horizontal: 15),
        // enabled: status != ProgressStatuses.pending,
        // showTrailingIcon: status != ProgressStatuses.pending ? true : false,
        //initiallyExpanded: status == ProgressStatuses.started ? true : false,
        children:
            _buildExpansionTileChildren(context: context, viewModel: viewModel),
      );

  Widget _buildTitle() => Text(
        module?.name ?? '',
        maxLines: 1,
        softWrap: false,
        style: style16P600,
        overflow: TextOverflow.ellipsis,
      );

  Widget _buildLeadingWrapper() => CircleAvatar(
        backgroundColor: kcVeryLightGrey.withValues(alpha: 0.5),
        child: _buildLeading(),
      );

  Widget _buildLeading() => const Icon(
        Icons.book,
        color: kcLightGrey,
      );

  Widget _buildSubtitle() => Text(
        '0% completed',
        style: style14DG500,
      );

  List<Widget> _buildExpansionTileChildren(
          {required BuildContext context,
          required CourseModuleViewModel viewModel}) =>
      [_buildExpansionTileItem(context: context, viewModel: viewModel)];

  Widget _buildExpansionTileItem(
          {required BuildContext context,
          required CourseModuleViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildExpansionTileItemChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildExpansionTileItemChildren(
          {required BuildContext context,
          required CourseModuleViewModel viewModel}) =>
      [
        _buildProgressRowWrapper(),
        verticalSpaceSmall,
        // _buildActionButtonWrapper(context: context, viewModel: viewModel),
        // verticalSpaceMedium,
        _buildCourseModules(viewModel)
      ];

  Widget _buildProgressRowWrapper() => Padding(
        padding: const EdgeInsets.only(left: 75, right: 15),
        child: _buildProgressRow(),
      );

  Widget _buildProgressRow() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildProgressChildren(),
      );

  List<Widget> _buildProgressChildren() =>
      [_buildProgressStatusWrapper(), horizontalSpaceSmall, _buildProgress()];

  Widget _buildProgressStatusWrapper() => Expanded(
        child: _buildProgressStatus(),
      );

  Widget _buildProgressStatus() => const CustomLinearProgressIndicator(
      progress: 0,
      activeColor: kcPrimaryColor,
      backgroundColor: kcVeryLightGrey);

  Widget _buildProgress() => const Text(
        '0/0',
        style: TextStyle(color: kcDarkGrey),
      );

  Widget _buildActionButtonWrapper(
          {required BuildContext context,
          required CourseModuleViewModel viewModel}) =>
      Container(
        width: 175,
        height: 40,
        margin: const EdgeInsets.only(left: 75, right: 15),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CourseModuleViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        onTap: onContinueTap,
        text: 'Continue Module',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildSheet(CourseModuleViewModel viewModel) => FinishPracticeSheet(
        onTap: viewModel.pop,
        practice: PracticeReason.lesson,
      );

  Widget _buildCourseModules(CourseModuleViewModel viewModel) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: lessons.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildCourseLessonTile(
            lesson: lessons[index],
            onVideoTap: () async =>
                await viewModel.navigateToCourseLessonDetail(lessons[index]),
            onPracticeTap: () async => await _onPractice(
              index: index,
              context: context,
              viewModel: viewModel,
              lesson: viewModel.lessons[index],
            )),
      );

  Widget _buildCourseLessonTile({
    required CourseLesson lesson,
    required GestureTapCallback onVideoTap,
    required GestureTapCallback onPracticeTap,
  }) =>
      CourseLessonTile(
        lesson: lesson,
        onVideoTap: onVideoTap,
        onPracticeTap: onPracticeTap,
      );


}
