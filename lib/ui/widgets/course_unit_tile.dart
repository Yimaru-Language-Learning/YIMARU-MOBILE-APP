import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course_module.dart';
import 'package:yimaru_app/models/course_unit.dart';
import 'package:yimaru_app/ui/widgets/course_module_tile_small.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';
import 'package:yimaru_app/ui/widgets/finish_practice_sheet.dart';

import '../../models/course_catalog.dart';
import '../common/app_colors.dart';
import '../common/enmus.dart';
import '../common/ui_helpers.dart';
import '../views/course_unit/course_unit_viewmodel.dart';
import 'custom_circular_progress_indicator.dart';
import 'custom_elevated_button.dart';

class CourseUnitTile extends ViewModelWidget<CourseUnitViewModel> {
  final int index;
  final CourseUnit unit;
  final CourseCatalog catalog;

  final GestureTapCallback? onLessonTap;
  final GestureTapCallback? onPracticeTap;

  const CourseUnitTile(
      {super.key,
      this.onLessonTap,
      this.onPracticeTap,
      required this.unit,
      required this.index,
      required this.catalog});

  Future<void> _getCourseModules({
    required bool expanded,
    required CourseUnitViewModel viewModel,
  }) async {
    if (!expanded) return;

    // Prevent duplicate API calls
    if ((unit.modules?.isNotEmpty ?? false)) return;

    await viewModel.getCourseModules(index: index, id: unit.id ?? 0);
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required CourseUnitViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        backgroundColor: kcTransparent,
        builder: (_) => _buildSheet(viewModel),
      );

  @override
  Widget build(BuildContext context, CourseUnitViewModel viewModel) =>
      _buildExpansionTileCard(context: context, viewModel: viewModel);

  Widget _buildExpansionTileCard(
          {required BuildContext context,
          required CourseUnitViewModel viewModel}) =>
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
          required CourseUnitViewModel viewModel}) =>
      Stack(
        children: [
          _buildExpansionTile(context: context, viewModel: viewModel),
          // _buildContainerShaderState()
        ],
      );

  Widget _buildExpansionTile(
          {required BuildContext context,
          required CourseUnitViewModel viewModel}) =>
      ExpansionTile(
        enabled: true,
        title: _buildTitle(),
        textColor: kcDarkGrey,
        showTrailingIcon: true,
        initiallyExpanded: false,
        subtitle: _buildSubtitle(),
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        backgroundColor: kcBackgroundColor,
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        collapsedBackgroundColor: kcBackgroundColor,
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: const EdgeInsets.symmetric(horizontal: 15),
        onExpansionChanged: (bool expanded) async => await _getCourseModules(
          expanded: expanded,
          viewModel: viewModel,
        ),
        // enabled: status != ProgressStatuses.pending,
        // showTrailingIcon: status != ProgressStatuses.pending ? true : false,
        //initiallyExpanded: status == ProgressStatuses.started ? true : false,
        children:
            _buildExpansionTileChildren(context: context, viewModel: viewModel),
      );

  Widget _buildTitle() => Text(
        unit.name ?? '',
        maxLines: 1,
        softWrap: false,
        style: style16P600,
        overflow: TextOverflow.ellipsis,
      );

  Widget _buildSubtitle() => Text(
        '0% completed',
        style: style14DG500,
      );

  List<Widget> _buildExpansionTileChildren(
          {required BuildContext context,
          required CourseUnitViewModel viewModel}) =>
      [_buildExpansionTileItem(context: context, viewModel: viewModel)];

  Widget _buildExpansionTileItem(
          {required BuildContext context,
          required CourseUnitViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildExpansionTileItemChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildExpansionTileItemChildren(
          {required BuildContext context,
          required CourseUnitViewModel viewModel}) =>
      [
        _buildProgressRowWrapper(),
        verticalSpaceSmall,
        _buildActionButtonWrapper(context: context, viewModel: viewModel),
        verticalSpaceMedium,
        _buildCourseModulesState(viewModel)
      ];

  Widget _buildProgressRowWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
          required CourseUnitViewModel viewModel}) =>
      Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildActionButtons(context: context, viewModel: viewModel),
      );

  Widget _buildActionButtons(
          {required BuildContext context,
          required CourseUnitViewModel viewModel}) =>
      Row(
        children: [
          _buildLessonButtonWrapper(viewModel),
          horizontalSpaceSmall,
          _buildPracticeButtonWrapper(context: context, viewModel: viewModel),
        ],
      );

  Widget _buildLessonButtonWrapper(CourseUnitViewModel viewModel) => Expanded(
        child: _buildLessonButton(viewModel),
      );

  Widget _buildLessonButton(CourseUnitViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        onTap: onLessonTap,
        text: 'View Module',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildPracticeButtonWrapper(
          {required BuildContext context,
          required CourseUnitViewModel viewModel}) =>
      Expanded(
        child: _buildPracticeButton(context: context, viewModel: viewModel),
      );

  Widget _buildPracticeButton(
          {required BuildContext context,
          required CourseUnitViewModel viewModel}) =>
      CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        onTap: onPracticeTap,
        text: 'View Practices',
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
      );

  Widget _buildSheet(CourseUnitViewModel viewModel) => FinishPracticeSheet(
        onTap: viewModel.pop,
        practice: PracticeReason.course,
      );

  Widget _buildCourseModulesState(CourseUnitViewModel viewModel) =>
      viewModel.busy(index)
          ? _buildProgressIndicatorWrapper()
          : _buildCourseModules(viewModel);

  Widget _buildProgressIndicatorWrapper() => SizedBox(
        height: 50,
        width: double.maxFinite,
        child: _buildProgressIndicator(),
      );

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildCourseModules(CourseUnitViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: unit.modules?.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildCourseModuleCard(
            module: unit.modules?[index],
            onTap: () async => await viewModel.navigateToCourseModule(
                catalog: catalog, module: unit.modules?[index])),
      );

  Widget _buildCourseModuleCard(
          {required CourseModule? module, required GestureTapCallback onTap}) =>
      CourseModuleTileSmall(onTap: onTap, module: module);

  // Widget _buildContainerShaderState() => status == ProgressStatuses.pending
  //     ? _buildContainerShaderWrapper()
  //     : Container();

  Widget _buildContainerShaderWrapper() => Positioned.fill(
        child: _buildContainerShader(),
      );

  Widget _buildContainerShader() => Container(
        decoration: BoxDecoration(
          color: kcWhite.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
      );
}
