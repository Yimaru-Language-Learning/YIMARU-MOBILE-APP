import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/category.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/course_category_card.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/profile_app_bar.dart';
import 'course_category_viewmodel.dart';

class CourseCategoryView extends StackedView<CourseCategoryViewModel> {
  const CourseCategoryView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(CourseCategoryViewModel viewModel) async {
    await viewModel.getCategories();
    super.onViewModelReady(viewModel);
  }

  @override
  CourseCategoryViewModel viewModelBuilder(BuildContext context) =>
      CourseCategoryViewModel();

  @override
  Widget builder(
    BuildContext context,
    CourseCategoryViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CourseCategoryViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CourseCategoryViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(CourseCategoryViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(CourseCategoryViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildCategoryColumnWrapper(viewModel)
        ],
      );

  Widget _buildAppBar(CourseCategoryViewModel viewModel) => ProfileAppBar(
        name: viewModel.user?.firstName,
        profileImage: viewModel.user?.profilePicture,
      );

  Widget _buildCategoryColumnWrapper(CourseCategoryViewModel viewModel) =>
      Expanded(child: _buildCourseColumnScrollView(viewModel));

  Widget _buildCourseColumnScrollView(CourseCategoryViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildCourseColumn(viewModel),
      );

  Widget _buildCourseColumn(CourseCategoryViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildLevelsColumnChildren(viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(CourseCategoryViewModel viewModel) =>
      [
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildListViewBuilder(viewModel)
      ];

  Widget _buildTitle() => Text(
        'Courses',
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        'Choose a course to improve your professional or exam skills.',
        style: style14DG400,
      );

  Widget _buildListViewBuilder(CourseCategoryViewModel viewModel) =>
      viewModel.busy(StateObjects.courseCategories)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(CourseCategoryViewModel viewModel) =>
      ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.categories.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
          category: viewModel.categories[index],
          onTap: () async => await viewModel
              .navigateToCourseCategory(viewModel.categories[index]),
        ),
        separatorBuilder: (context, index) => verticalSpaceSmall,
      );

  //
  Widget _buildTile({
    required Category category,
    required GestureTapCallback onTap,
  }) =>
      CourseCategoryCard(
        onTap: onTap,
        category: category,
      );
}
