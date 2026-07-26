import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course_catalog.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/course_catalog_tile.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/finish_practice_sheet.dart';
import '../../widgets/small_app_bar.dart';
import 'course_catalog_viewmodel.dart';

class CourseCatalogView extends StackedView<CourseCatalogViewModel> {
  const CourseCatalogView({Key? key}) : super(key: key);

  Future<void> _onPractice(
      {required BuildContext context,
      required CourseCatalog course,
      required CourseCatalogViewModel viewModel}) async {
    await viewModel.navigateToCoursePractice(
        id: course.id ?? 0,
        type: course.category == 'IELTS'
            ? SubscriptionType.ielts
            : SubscriptionType.duolingo);

    /*   if (course.access?.isCompleted ?? false) {
      await viewModel.navigateToCoursePractice(course.id ?? 0);
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
            practice: PracticeReason.previousCourse);
      }
    }*/
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required PracticeReason practice,
          required CourseCatalogViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        backgroundColor: kcTransparent,
        builder: (_) => _buildSheet(viewModel: viewModel, practice: practice),
      );

  @override
  void onViewModelReady(CourseCatalogViewModel viewModel) async {
    await viewModel.getCourseCatalogs();
    super.onViewModelReady(viewModel);
  }

  @override
  CourseCatalogViewModel viewModelBuilder(BuildContext context) =>
      CourseCatalogViewModel();

  @override
  Widget builder(
    BuildContext context,
    CourseCatalogViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CourseCatalogViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(CourseCatalogViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CourseCatalogViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(CourseCatalogViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(CourseCatalogViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildCoursesColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(CourseCatalogViewModel viewModel) => SmallAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildCoursesColumnWrapper(CourseCatalogViewModel viewModel) =>
      Expanded(child: _buildCoursesColumnScrollView(viewModel));

  Widget _buildCoursesColumnScrollView(CourseCatalogViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildCoursesColumn(viewModel),
      );

  Widget _buildCoursesColumn(CourseCatalogViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildCoursesColumnChildren(viewModel),
      );

  List<Widget> _buildCoursesColumnChildren(CourseCatalogViewModel viewModel) =>
      [
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildListViewBuilder(viewModel)
      ];

  Widget _buildTitle() => Text(
        'English Proficiency Exams',
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        'Select your target exam and start preparing',
        style: style14DG400,
      );

  Widget _buildListViewBuilder(CourseCatalogViewModel viewModel) =>
      viewModel.busy(StateObjects.courseCatalogs)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(CourseCatalogViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount:  1,//viewModel.catalogs.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
          onPracticeTap: () async => await _onPractice(
              context: context,
              viewModel: viewModel,
              course: viewModel.catalogs[index]),
          catalog: viewModel.catalogs[index],
          onCourseTap: () async => await viewModel.navigateToCourseUnit(
              catalog: viewModel.catalogs[index],
              type: viewModel.catalogs[index].category == 'IELTS'
                  ? SubscriptionType.ielts
                  : SubscriptionType.duolingo),
        ),
        separatorBuilder: (context, index) => verticalSpaceSmall,
      );

  Widget _buildTile({
    required CourseCatalog catalog,
    required GestureTapCallback onCourseTap,
    required GestureTapCallback onPracticeTap,
  }) =>
      CourseCatalogTile(
        catalog: catalog,
        onCourseTap: onCourseTap,
        onPracticeTap: onPracticeTap,
      );

  Widget _buildSheet(
          {required PracticeReason practice,
          required CourseCatalogViewModel viewModel}) =>
      FinishPracticeSheet(
        practice: practice,
        onTap: viewModel.pop,
      );
}
