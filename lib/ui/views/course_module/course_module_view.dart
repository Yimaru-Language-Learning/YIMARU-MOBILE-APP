import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/course_module_tile_large.dart';

import '../../../models/course_catalog.dart';
import '../../../models/course_module.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/translations/locale_keys.g.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/small_app_bar.dart';
import 'course_module_viewmodel.dart';

class CourseModuleView extends StackedView<CourseModuleViewModel> {
  final bool first;
  final CourseModule? module;
  final CourseCatalog catalog;
  final SubscriptionType type;

  const CourseModuleView(
      {Key? key,
      required this.type,
      required this.first,
      required this.module,
      required this.catalog})
      : super(key: key);

  @override
  void onViewModelReady(CourseModuleViewModel viewModel) async {
    await viewModel.getCourseLessons(module?.id ?? 0);
    super.onViewModelReady(viewModel);
  }

  @override
  CourseModuleViewModel viewModelBuilder(BuildContext context) =>
      CourseModuleViewModel();

  @override
  Widget builder(
    BuildContext context,
    CourseModuleViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CourseModuleViewModel viewModel) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(CourseModuleViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CourseModuleViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(CourseModuleViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(CourseModuleViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildModulesColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(CourseModuleViewModel viewModel) => SmallAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
        title: LocaleKeys.module_detail.tr(),
      );

  Widget _buildModulesColumnWrapper(CourseModuleViewModel viewModel) =>
      Expanded(child: _buildLevelsColumnScrollView(viewModel));

  Widget _buildLevelsColumnScrollView(CourseModuleViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildLevelsColumn(viewModel),
      );

  Widget _buildLevelsColumn(CourseModuleViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildLevelsColumnChildren(viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(CourseModuleViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildListViewBuilder(viewModel)
      ];

  Widget _buildTitle() => Text(
        catalog.name ?? '',
        style: style25DG600,
      );

  Widget _buildListViewBuilder(CourseModuleViewModel viewModel) =>
      viewModel.busy(StateObjects.courseLessons)
          ? _buildProgressIndicator()
          : _buildTile(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildTile(CourseModuleViewModel viewModel) => CourseModuleTileLarge(
        type: type,
        first: first,
        module: module,
        lessons: viewModel.lessons,
      );
}
