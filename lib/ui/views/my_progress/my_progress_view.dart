import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/translations/locale_keys.g.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/course_progress_section.dart';
import '../../widgets/learning_progress_card.dart';
import '../../widgets/small_app_bar.dart';
import '../../widgets/retryable_content.dart';
import 'my_progress_viewmodel.dart';

class MyProgressView extends StackedView<MyProgressViewModel> {
  const MyProgressView({Key? key}) : super(key: key);
  @override
  void onViewModelReady(MyProgressViewModel viewModel) async {
    await viewModel.getProgressSummary();
    super.onViewModelReady(viewModel);
  }

  @override
  MyProgressViewModel viewModelBuilder(BuildContext context) =>
      MyProgressViewModel();

  @override
  Widget builder(
    BuildContext context,
    MyProgressViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(MyProgressViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(MyProgressViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(MyProgressViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(MyProgressViewModel viewModel) =>
      _buildNestedScrollView(viewModel);

  Widget _buildNestedScrollView(MyProgressViewModel viewModel) =>
      NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) =>
                  [_buildSliverAppbarWrapper(viewModel)],
          body: _buildContentScrollViewWrapper(viewModel));

  Widget _buildSliverAppbarWrapper(MyProgressViewModel viewModel) =>
      SliverAppBar(
        pinned: true,
        automaticallyImplyLeading: false,
        backgroundColor: kcBackgroundColor,
        surfaceTintColor: kcBackgroundColor,
        title: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(MyProgressViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.pop,
        title: LocaleKeys.my_progress.tr(),
      );

  Widget _buildContentScrollViewWrapper(MyProgressViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildContentWrapper(viewModel),
      );

  Widget _buildContentWrapper(MyProgressViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: RetryableContent(
          isLoading: viewModel.busy(StateObjects.progressSummary),
          hasError: viewModel.hasErrorForKey(StateObjects.progressSummary),
          onRetry: viewModel.getProgressSummary,
          builder: () => _buildContentColumn(viewModel),
        ),
      );

  Widget _buildContentColumn(MyProgressViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildContentChildren(viewModel),
      );

  List<Widget> _buildContentChildren(MyProgressViewModel viewModel) => [
        verticalSpaceMedium,
        _buildText(),
        verticalSpaceMedium,
        _buildLearningProgressCard(),
        verticalSpaceMedium,
        _buildCourseProgressSection()
      ];

  Widget _buildText() => Text(
        LocaleKeys.track_journey.tr(),
        style: style14DG400,
      );

  Widget _buildLearningProgressCard() => const LearningProgressCard();

  Widget _buildCourseProgressSection() => const CourseProgressSection();
}
