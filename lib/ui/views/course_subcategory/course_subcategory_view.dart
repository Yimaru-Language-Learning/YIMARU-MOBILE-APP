import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/course_category.dart';
import '../../../models/course_subcategory.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/course_subcategory_tile.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/small_app_bar.dart';
import 'course_subcategory_viewmodel.dart';

class CourseSubcategoryView extends StackedView<CourseSubcategoryViewModel> {
  final CourseCategory category;

  const CourseSubcategoryView({Key? key, required this.category})
      : super(key: key);

  @override
  void onViewModelReady(CourseSubcategoryViewModel viewModel) async {
    await viewModel.getCourseSubcategories(category.id ?? 0);
    super.onViewModelReady(viewModel);
  }

  @override
  CourseSubcategoryViewModel viewModelBuilder(BuildContext context) =>
      CourseSubcategoryViewModel();

  @override
  Widget builder(
    BuildContext context,
    CourseSubcategoryViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CourseSubcategoryViewModel viewModel) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CourseSubcategoryViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(CourseSubcategoryViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(CourseSubcategoryViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildCoursesColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(CourseSubcategoryViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildCoursesColumnWrapper(CourseSubcategoryViewModel viewModel) =>
      Expanded(child: _buildCoursesColumnScrollView(viewModel));

  Widget _buildCoursesColumnScrollView(CourseSubcategoryViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildCoursesColumn(viewModel),
      );

  Widget _buildCoursesColumn(CourseSubcategoryViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildCoursesColumnChildren(viewModel),
      );

  List<Widget> _buildCoursesColumnChildren(
          CourseSubcategoryViewModel viewModel) =>
      [
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildListViewBuilder(viewModel)
      ];

  Widget _buildTitle() => Text(
        '${category.name ?? ''} courses',
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        'Explore variety of courses on this category.',
        style: style14DG400,
      );

  Widget _buildListViewBuilder(CourseSubcategoryViewModel viewModel) =>
      viewModel.busy(StateObjects.subcategories)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(CourseSubcategoryViewModel viewModel) =>
      ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.subcategories.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
          subcategory: viewModel.subcategories[index],
          onCourseTap: () async => await viewModel
              .navigateToSubcourse(viewModel.subcategories[index]),
        ),
        separatorBuilder: (context, index) => verticalSpaceSmall,
      );

  Widget _buildTile({
    GestureTapCallback? onCourseTap,
    GestureTapCallback? onPracticeTap,
    required CourseSubcategory subcategory,
  }) =>
      CourseSubcategoryTile(
        subcategory: subcategory,
        onCourseTap: onCourseTap,
        onPracticeTap: onPracticeTap,
      );
}
