import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/course_card.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/learn_app_bar.dart';
import 'course_viewmodel.dart';

class CourseView extends StackedView<CourseViewModel> {
  const CourseView({Key? key}) : super(key: key);

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
          _buildCourseColumnWrapper(viewModel)
        ],
      );

  Widget _buildAppBar(CourseViewModel viewModel) => LearnAppBar(
        name: viewModel.user?.firstName,
        profileImage: viewModel.user?.profilePicture,
      );

  Widget _buildCourseColumnWrapper(CourseViewModel viewModel) =>
      Expanded(child: _buildCourseColumnScrollView(viewModel));

  Widget _buildCourseColumnScrollView(CourseViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildCourseColumn(viewModel),
      );

  Widget _buildCourseColumn(CourseViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildLevelsColumnChildren(viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(CourseViewModel viewModel) => [
        verticalSpaceLarge,
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildListView(viewModel)
      ];

  Widget _buildTitle() => Text(
        'Courses',
        style: style20DG700,
      );

  Widget _buildSubtitle() => Text(
        'Choose a course to improve your professional or exam skills.',
        style: style14DG400,
      );

  Widget _buildListView(CourseViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.courses.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
          title: viewModel.courses[index]['title'],
          subtitle: viewModel.courses[index]['subtitle'],
          onTap: () async => await viewModel.navigateToCourseModule(),
        ),
        separatorBuilder: (context, index) => verticalSpaceSmall,
      );

  //
  Widget _buildTile({
    required String title,
    required String subtitle,
    required GestureTapCallback onTap,
  }) =>
      CourseCard(
        title: title,
        onTap: onTap,
        subtitle: subtitle,
      );
}
