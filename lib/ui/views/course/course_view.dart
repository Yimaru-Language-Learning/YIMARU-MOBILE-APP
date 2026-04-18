import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/course_detail.dart';
import '../../../models/subcategory.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/course_tile.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/small_app_bar.dart';
import 'course_viewmodel.dart';

class CourseView extends StackedView<CourseViewModel> {
  final Subcategory subcategory;

  const CourseView({Key? key, required this.subcategory}) : super(key: key);

  @override
  void onViewModelReady(CourseViewModel viewModel) async {
    await viewModel.getCourseDetails(subcategory.id ?? 0);
    super.onViewModelReady(viewModel);
  }

  @override
  CourseViewModel viewModelBuilder(BuildContext context) => CourseViewModel();

  @override
  Widget builder(
    BuildContext context,
    CourseViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CourseViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CourseViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(CourseViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(CourseViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildCoursesColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(CourseViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildCoursesColumnWrapper(CourseViewModel viewModel) =>
      Expanded(child: _buildCoursesColumnScrollView(viewModel));

  Widget _buildCoursesColumnScrollView(CourseViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildCoursesColumn(viewModel),
      );

  Widget _buildCoursesColumn(CourseViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildCoursesColumnChildren(viewModel),
      );

  List<Widget> _buildCoursesColumnChildren(CourseViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildListViewBuilder(viewModel)
      ];

  Widget _buildTitle() => Text(
        '${subcategory.name ?? ''} courses',
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        'Explore variety of courses on ${subcategory.name ?? ''}.',
        style: style14DG400,
      );

  Widget _buildListViewBuilder(CourseViewModel viewModel) =>
      viewModel.busy(StateObjects.courses)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(CourseViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.courseDetail.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => verticalSpaceSmall,
        itemBuilder: (context, index) => _buildTile(
          courseDetail: viewModel.courseDetail[index],
          onCourseTap: () async => await viewModel
              .navigateToCoursePayment(viewModel.courseDetail[index].course!),
          onPracticeTap: () async => await viewModel.navigateToCoursePractice(
              viewModel.courseDetail[index].course?.id ?? 0),
        ),
      );

  Widget _buildTile({
    GestureTapCallback? onCourseTap,
    GestureTapCallback? onPracticeTap,
    required CourseDetail courseDetail,
  }) =>
      CourseTile(
        onCourseTap: onCourseTap,
        courseDetail: courseDetail,
        onPracticeTap: onPracticeTap,
      );
}
