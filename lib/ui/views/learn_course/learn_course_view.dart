import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_course.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/learn_course_tile.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_course_viewmodel.dart';

class LearnCourseView extends StackedView<LearnCourseViewModel> {
  final int id;
  const LearnCourseView({Key? key, required this.id}) : super(key: key);

  @override
  void onViewModelReady(LearnCourseViewModel viewModel) async {
    await viewModel.getLearnCourses(id);
    super.onViewModelReady(viewModel);
  }

  @override
  LearnCourseViewModel viewModelBuilder(BuildContext context) =>
      LearnCourseViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnCourseViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnCourseViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnCourseViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(LearnCourseViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnCourseViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildCoursesColumnWrapper(viewModel)
        ],
      );

  Widget _buildAppBar(LearnCourseViewModel viewModel) => SmallAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildCoursesColumnWrapper(LearnCourseViewModel viewModel) =>
      Expanded(child: _buildLevelsColumnScrollView(viewModel));

  Widget _buildLevelsColumnScrollView(LearnCourseViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildListViewBuilder(viewModel),
      );

  Widget _buildListViewBuilder(LearnCourseViewModel viewModel) =>
      viewModel.busy(StateObjects.learnCourses)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(LearnCourseViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.learnCourses.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
          course: viewModel.learnCourses[index],
          onViewTap: () async => await viewModel
              .navigateToLearnModule(viewModel.learnCourses[index]),
          onPracticeTap: () async => await viewModel.navigateToLearnPractice(
              id: viewModel.learnCourses[index].id ?? 0,
              level: viewModel.learnCourses[index].name ?? ''),
        ),
        separatorBuilder: (context, index) => verticalSpaceSmall,
      );

  Widget _buildTile({
    required LearnCourse course,
    required GestureTapCallback onViewTap,
    required GestureTapCallback onPracticeTap,
  }) =>
      LearnCourseTile(
        course: course,
        onViewTap: onViewTap,
        onPracticeTap: onPracticeTap,
      );
}
