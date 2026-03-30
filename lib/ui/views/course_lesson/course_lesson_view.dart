import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course.dart';
import 'package:yimaru_app/models/course_lesson.dart';
import 'package:yimaru_app/ui/widgets/course_lesson_tile.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/small_app_bar.dart';
import 'course_lesson_viewmodel.dart';

class CourseLessonView extends StackedView<CourseLessonViewModel> {
  final Course course;

  const CourseLessonView({Key? key, required this.course}) : super(key: key);

  @override
  void onViewModelReady(CourseLessonViewModel viewModel) async {
    await viewModel.getCourseLessons(course.id ?? 0);
    super.onViewModelReady(viewModel);
  }

  @override
  CourseLessonViewModel viewModelBuilder(BuildContext context) =>
      CourseLessonViewModel();

  @override
  Widget builder(
    BuildContext context,
    CourseLessonViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CourseLessonViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CourseLessonViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(CourseLessonViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(CourseLessonViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildLessonColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(CourseLessonViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        showBackButton: true,
        title: 'Course Detail',
      );

  Widget _buildLessonColumnWrapper(CourseLessonViewModel viewModel) =>
      Expanded(child: _buildLessonColumnScrollView(viewModel));

  Widget _buildLessonColumnScrollView(CourseLessonViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildLessonColumn(viewModel),
      );

  Widget _buildLessonColumn(CourseLessonViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildLessonColumnChildren(viewModel),
      );

  List<Widget> _buildLessonColumnChildren(CourseLessonViewModel viewModel) => [
        //  verticalSpaceLarge,
        _buildTitle(),
        verticalSpaceMedium,
        _buildListViewBuilder(viewModel)
      ];

  Widget _buildTitle() => Text(
        '${course.title} course lessons',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildListViewBuilder(CourseLessonViewModel viewModel) =>
      viewModel.busy(StateObjects.courseLessons)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(CourseLessonViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.courseLessons.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
            lesson: viewModel.courseLessons[index],
            onPracticeTap: () async =>
                await viewModel.navigateToCoursePractice(course.id ?? 0),
            onVideoTap: () async => await viewModel
                .navigateToCourseLessonDetail(viewModel.courseLessons[index])),
      );

  Widget _buildTile({
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
