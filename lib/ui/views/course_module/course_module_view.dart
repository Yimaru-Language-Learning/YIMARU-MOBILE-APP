import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/course_module_tile.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/small_app_bar.dart';
import 'course_module_viewmodel.dart';

class CourseModuleView extends StackedView<CourseModuleViewModel> {
  const CourseModuleView({Key? key}) : super(key: key);

  @override
  CourseModuleViewModel viewModelBuilder(BuildContext context) =>
      CourseModuleViewModel();

  @override
  Widget builder(
    BuildContext context,
    CourseModuleViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CourseModuleViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CourseModuleViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(CourseModuleViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(CourseModuleViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          _buildLevelsColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(CourseModuleViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildLevelsColumnWrapper(CourseModuleViewModel viewModel) =>
      Expanded(child: _buildLevelsColumnScrollView(viewModel));

  Widget _buildLevelsColumnScrollView(CourseModuleViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildLevelsColumn(viewModel),
      );

  Widget _buildLevelsColumn(CourseModuleViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildLevelsColumnChildren(viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(CourseModuleViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildListView(viewModel)
      ];

  Widget _buildTitle() => Text(
        'English Proficiency Exams',
        style: style20DG700,
      );

  Widget _buildSubtitle() => Text(
        'Select your target exam and start preparing',
        style: style14DG400,
      );

  Widget _buildListView(CourseModuleViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.modules.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
            title: viewModel.modules[index]['title'],
            onPracticeTap: () async =>
                await viewModel.navigateToCoursePractice(),
            onCourseTap: () async => await viewModel.navigateToCoursePayment()),
        separatorBuilder: (context, index) => verticalSpaceMedium,
      );

  Widget _buildTile({
    required String title,
    GestureTapCallback? onCourseTap,
    GestureTapCallback? onPracticeTap,
  }) =>
      CourseModuleTile(
        title: title,
        onCourseTap: onCourseTap,
        onPracticeTap: onPracticeTap,
      );
}
