import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/translations/locale_keys.g.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/course_category_card.dart';
import '../../widgets/profile_app_bar.dart';
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
        resizeToAvoidBottomInset: true,
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(CourseViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
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
          _buildCategoryColumnWrapper(viewModel)
        ],
      );

  Widget _buildAppBar(CourseViewModel viewModel) => ProfileAppBar(
        name: viewModel.user?.firstName,
        profileImage: viewModel.user?.profilePicture,
        unreadCount: viewModel.unreadCount.toString(),
        onTap: () async => await viewModel.navigateToNotification(),
      );

  Widget _buildCategoryColumnWrapper(CourseViewModel viewModel) =>
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
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildListView(viewModel)
      ];

  Widget _buildTitle() => Text(
        LocaleKeys.courses.tr(),
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.choose_course_to_improve.tr(),
        style: style14DG400,
      );

  Widget _buildListView(CourseViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.courses.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
            course: viewModel.courses[index],
            onTap: () async => await viewModel.navigateToCourseCatalog()),
        separatorBuilder: (context, index) => verticalSpaceSmall,
      );

  //
  Widget _buildTile({
    required GestureTapCallback onTap,
    required Map<String, dynamic> course,
  }) =>
      CourseCard(
        onTap: onTap,
        course: course,
      );
}
