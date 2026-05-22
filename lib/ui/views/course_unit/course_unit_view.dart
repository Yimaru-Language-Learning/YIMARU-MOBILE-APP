import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course_catalog.dart';
import 'package:yimaru_app/ui/widgets/course_unit_tile.dart';

import '../../../models/course_unit.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/course_module_banner.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/overall_progress.dart';
import '../../widgets/small_app_bar.dart';
import 'course_unit_viewmodel.dart';

class CourseUnitView extends StackedView<CourseUnitViewModel> {
  final CourseCatalog catalog;

  const CourseUnitView({Key? key, required this.catalog}) : super(key: key);

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
        title: 'Course Detail',
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
        verticalSpaceTiny,
        _buildContinueButton(viewModel),
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
      const CustomElevatedButton(
          height: 55,
          borderRadius: 12,
          foregroundColor: kcWhite,
          text: 'Continue Course',
          backgroundColor: kcPrimaryColor);

  Widget _buildListViewBuilder(CourseUnitViewModel viewModel) =>
      viewModel.busy(StateObjects.courseUnits)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(CourseUnitViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.units.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
            index: index,
            unit: viewModel.units[index],
            onPracticeTap: () {},
            onViewTap: () {}),
      );

  Widget _buildTile({
    required int index,
    required CourseUnit unit,
    required GestureTapCallback onViewTap,
    required GestureTapCallback onPracticeTap,
  }) =>
      CourseUnitTile(
        unit: unit,
        index: index,
        catalog: catalog,
        onLessonTap: onViewTap,
        onPracticeTap: onPracticeTap,
      );
}
