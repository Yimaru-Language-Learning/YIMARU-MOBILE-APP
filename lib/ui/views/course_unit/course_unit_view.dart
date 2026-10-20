import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../widgets/retryable_content.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course_catalog.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/course_unit_tile.dart';

import '../../../models/course_unit.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/course_module_banner.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/finish_practice_sheet.dart';
import '../../widgets/overall_progress.dart';
import '../../widgets/small_app_bar.dart';
import 'course_unit_viewmodel.dart';

class CourseUnitView extends StackedView<CourseUnitViewModel> {
  final CourseCatalog catalog;
  final SubscriptionType type;

  const CourseUnitView({Key? key, required this.type, required this.catalog})
      : super(key: key);

  Future<void> _onPractice(
      {required CourseUnit unit,
      required BuildContext context,
      required CourseUnitViewModel viewModel}) async {
    await viewModel.navigateToCoursePractice(id: unit.id ?? 0, type: type, context: context);

/*    if (unit.access?.isCompleted ?? false) {
      await viewModel.navigateToCoursePractice(unit.id ?? 0);
    } else {
      if (unit.access?.isAccessible ?? false) {
        await _showSheet(
            context: context,
            viewModel: viewModel,
            practice: PracticeReason.unit);
      } else {
        await _showSheet(
            context: context,
            viewModel: viewModel,
            practice: PracticeReason.previousUnit);
      }
    }*/
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required PracticeReason practice,
          required CourseUnitViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        backgroundColor: kcTransparent,
        builder: (_) => _buildSheet(viewModel: viewModel, practice: practice),
      );

  @override
  void onViewModelReady(CourseUnitViewModel viewModel) async {
    await viewModel.getCourseUnits(catalog.id ?? 0);
    super.onViewModelReady(viewModel);
  }

  @override
  CourseUnitViewModel viewModelBuilder(BuildContext context) =>
      CourseUnitViewModel();

  @override
  Widget builder(
    BuildContext context,
    CourseUnitViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CourseUnitViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(CourseUnitViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CourseUnitViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(CourseUnitViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(CourseUnitViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildModulesColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(CourseUnitViewModel viewModel) => SmallAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
        title: LocaleKeys.course_detail.tr(),
      );

  Widget _buildModulesColumnWrapper(CourseUnitViewModel viewModel) =>
      Expanded(child: _buildLevelsColumnScrollView(viewModel));

  Widget _buildLevelsColumnScrollView(CourseUnitViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildLevelsColumn(viewModel),
      );

  Widget _buildLevelsColumn(CourseUnitViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildLevelsColumnChildren(viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(CourseUnitViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildCourseModuleBanner(),
        verticalSpaceMedium,
        _buildOverallProgress(),
        // verticalSpaceTiny,
        // _buildContinueButton(viewModel),
        verticalSpaceMedium,
        _buildListViewBuilder(viewModel)
      ];

  Widget _buildTitle() => Text(
        catalog.name ?? '',
        style: style25DG600,
      );

  Widget _buildCourseModuleBanner() => const CourseModuleBanner();

  Widget _buildOverallProgress() => const OverallProgress(
        progress: 0,
        backgroundColor: Colors.transparent,
        indicatorBackgroundColor: kcVeryLightGrey,
      );

  Widget _buildContinueButton(CourseUnitViewModel viewModel) =>
      CustomElevatedButton(
          height: 55,
          borderRadius: 12,
          foregroundColor: kcWhite,
          text: LocaleKeys.continue_course.tr(),
          backgroundColor: kcPrimaryColor);

  Widget _buildListViewBuilder(CourseUnitViewModel viewModel) =>
      RetryableContent(
        isLoading: viewModel.busy(StateObjects.courseUnits),
        hasError: viewModel.hasErrorForKey(StateObjects.courseUnits),
        onRetry: () => viewModel.getCourseUnits(catalog.id ?? 0),
        loading: _buildProgressIndicator(),
        builder: () => _buildListView(viewModel),
      );

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(CourseUnitViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.units.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
          index: index,
          onViewTap: () {},
          first: index == 0,
          unit: viewModel.units[index],
          onPracticeTap: () async => await _onPractice(
            context: context,
            viewModel: viewModel,
            unit: viewModel.units[index],
          ),
        ),
      );

  Widget _buildTile({
    required int index,
    required bool first,
    required CourseUnit unit,
    required GestureTapCallback onViewTap,
    required GestureTapCallback onPracticeTap,
  }) =>
      CourseUnitTile(
        unit: unit,
        type: type,
        index: index,
        first: first,
        catalog: catalog,
        onLessonTap: onViewTap,
        onPracticeTap: onPracticeTap,
      );

  Widget _buildSheet(
          {required PracticeReason practice,
          required CourseUnitViewModel viewModel}) =>
      FinishPracticeSheet(
        practice: practice,
        onTap: viewModel.pop,
      );
}
