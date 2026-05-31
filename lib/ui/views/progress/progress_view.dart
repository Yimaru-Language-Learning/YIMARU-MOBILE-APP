import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/course_progress_section.dart';
import '../../widgets/learning_progress_card.dart';
import '../../widgets/small_app_bar.dart';
import 'progress_viewmodel.dart';

class ProgressView extends StackedView<ProgressViewModel> {
  const ProgressView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(ProgressViewModel viewModel) async {
    await viewModel.getProgressSummary();
    super.onViewModelReady(viewModel);
  }

  @override
  ProgressViewModel viewModelBuilder(BuildContext context) =>
      ProgressViewModel();

  @override
  Widget builder(
    BuildContext context,
    ProgressViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(ProgressViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(ProgressViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(ProgressViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(ProgressViewModel viewModel) =>
      _buildNestedScrollView(viewModel);

  Widget _buildNestedScrollView(ProgressViewModel viewModel) =>
      NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) =>
                  [_buildSliverAppbarWrapper(viewModel)],
          body: _buildContentScrollViewWrapper(viewModel));

  Widget _buildSliverAppbarWrapper(ProgressViewModel viewModel) => SliverAppBar(
        pinned: true,
        automaticallyImplyLeading: false,
        backgroundColor: kcBackgroundColor,
        surfaceTintColor: kcBackgroundColor,
        title: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(ProgressViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.pop,
        title: LocaleKeys.my_progress.tr(),
      );

  Widget _buildContentScrollViewWrapper(ProgressViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildContentWrapper(viewModel),
      );

  Widget _buildContentWrapper(ProgressViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildContentColumn(viewModel),
      );

  Widget _buildContentColumn(ProgressViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildContentChildren(viewModel),
      );

  List<Widget> _buildContentChildren(ProgressViewModel viewModel) => [
        verticalSpaceMedium,
        _buildText(),
        verticalSpaceMedium,
        _buildLearningProgressCard(),
        verticalSpaceMedium,
        //  _buildCourseProgressSection()
      ];

  Widget _buildText() => Text(
        LocaleKeys.track_journey.tr(),
        style: style14DG400,
      );

  Widget _buildLearningProgressCard() => const LearningProgressCard();

  Widget _buildCourseProgressSection() => const CourseProgressSection();
}
