import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_course.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/finish_practice_sheet.dart';
import '../../widgets/learn_course_tile.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_course_viewmodel.dart';

class LearnCourseView extends StackedView<LearnCourseViewModel> {
  final int id;
  final bool first;

  const LearnCourseView({Key? key, required this.id, required this.first})
      : super(key: key);

  Future<void> _onPractice(
      {required BuildContext context,
      required LearnCourse course,
      required LearnCourseViewModel viewModel}) async {
    if (viewModel.user?.learn ?? false) {
      if (course.access?.isCompleted ?? false) {
        await viewModel.navigateToLearnPractice(
            id: course.id ?? 0, level: course.name ?? '');
      } else {
        if (course.access?.isAccessible ?? false) {
          await _showSheet(
              context: context,
              viewModel: viewModel,
              practice: PracticeReason.course);
        } else {
          await _showSheet(
              context: context,
              viewModel: viewModel,
              practice: PracticeReason.course);
        }
      }
    } else {
      await viewModel.navigateToLearnPractice(
          id: course.id ?? 0, level: course.name ?? '');
    }
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required PracticeReason practice,
          required LearnCourseViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        backgroundColor: kcTransparent,
        builder: (_) => _buildSheet(viewModel: viewModel, practice: practice),
      );

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
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required LearnCourseViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldContainer(
          {required BuildContext context,
          required LearnCourseViewModel viewModel}) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required LearnCourseViewModel viewModel}) =>
      SafeArea(child: _buildBody(context: context, viewModel: viewModel));

  Widget _buildBody(
          {required BuildContext context,
          required LearnCourseViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(context: context, viewModel: viewModel),
      );

  Widget _buildColumn(
          {required BuildContext context,
          required LearnCourseViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildCoursesColumnWrapper(context: context, viewModel: viewModel)
        ],
      );

  Widget _buildAppBar(LearnCourseViewModel viewModel) => SmallAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildCoursesColumnWrapper(
          {required BuildContext context,
          required LearnCourseViewModel viewModel}) =>
      Expanded(
          child: _buildLevelsColumnScrollView(
              context: context, viewModel: viewModel));

  Widget _buildLevelsColumnScrollView(
          {required BuildContext context,
          required LearnCourseViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildListViewBuilder(context: context, viewModel: viewModel),
      );

  Widget _buildListViewBuilder(
          {required BuildContext context,
          required LearnCourseViewModel viewModel}) =>
      viewModel.busy(StateObjects.learnCourses)
          ? _buildProgressIndicator()
          : _buildListView(context: context, viewModel: viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(
          {required BuildContext context,
          required LearnCourseViewModel viewModel}) =>
      ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.courses.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
          course: viewModel.courses[index],
          onPracticeTap: () async => await _onPractice(
              context: context,
              viewModel: viewModel,
              course: viewModel.courses[index]),
          onViewTap: () async => await viewModel.navigateToLearnModule(
              first: first && index == 0, course: viewModel.courses[index]),
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

  Widget _buildSheet(
          {required PracticeReason practice,
          required LearnCourseViewModel viewModel}) =>
      FinishPracticeSheet(
        practice: practice,
        onTap: viewModel.pop,
      );
}
