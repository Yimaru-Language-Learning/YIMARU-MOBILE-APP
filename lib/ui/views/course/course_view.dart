import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/translations/locale_keys.g.dart';
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
        backgroundColor: const Color(0xFFF8F8FC),
        body: SafeArea(child: _buildBody(viewModel)),
      );

  Widget _buildBody(CourseViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildAppBar(viewModel),
            const SizedBox(height: 20),
            _buildTitle(),
            const SizedBox(height: 4),
            _buildSubtitle(),
            const SizedBox(height: 20),
            Expanded(child: _buildCourseList(viewModel)),
          ],
        ),
      );

  Widget _buildAppBar(CourseViewModel viewModel) => ProfileAppBar(
        name: viewModel.user?.firstName,
        profileImage: viewModel.user?.profilePicture,
        unreadCount: viewModel.unreadCount.toString(),
        onTap: () async => await viewModel.navigateToNotification(),
      );

  Widget _buildTitle() => Text(
        LocaleKeys.courses.tr(),
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          fontFamily: 'Aeonik',
          color: Color(0xFF1A1A2E),
        ),
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.choose_course_to_improve.tr(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Aeonik',
          color: Color(0xFF666677),
        ),
      );

  Widget _buildCourseList(CourseViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.courses.length,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) => CourseCard(
          course: viewModel.courses[index],
          onTap: () async => await viewModel.navigateToCourseCatalog(),
        ),
      );
}
