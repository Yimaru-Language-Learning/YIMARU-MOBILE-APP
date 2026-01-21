import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/course_progress_section.dart';
import 'package:yimaru_app/ui/widgets/learning_progress_card.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/small_app_bar.dart';
import 'ongoing_progress_viewmodel.dart';

class OngoingProgressView extends StackedView<OngoingProgressViewModel> {
  const OngoingProgressView({Key? key}) : super(key: key);

  @override
  OngoingProgressViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OngoingProgressViewModel();

  @override
  Widget builder(
    BuildContext context,
    OngoingProgressViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(OngoingProgressViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(OngoingProgressViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(OngoingProgressViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(OngoingProgressViewModel viewModel) =>
      _buildNestedScrollView(viewModel);

  Widget _buildNestedScrollView(OngoingProgressViewModel viewModel) =>
      NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) =>
                  [_buildSliverAppbarWrapper(viewModel)],
          body: _buildContentScrollViewWrapper(viewModel));

  Widget _buildSliverAppbarWrapper(OngoingProgressViewModel viewModel) =>
      SliverAppBar(
        pinned: true,
        automaticallyImplyLeading: false,
        backgroundColor: kcBackgroundColor,
        surfaceTintColor: kcBackgroundColor,
        title: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(OngoingProgressViewModel viewModel) => SmallAppBar(
        title: 'My Progress',
        onTap: viewModel.pop,
      );

  Widget _buildContentScrollViewWrapper(OngoingProgressViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildContentWrapper(viewModel),
      );

  Widget _buildContentWrapper(OngoingProgressViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildContentColumn(viewModel),
      );

  Widget _buildContentColumn(OngoingProgressViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildContentChildren(viewModel),
      );

  List<Widget> _buildContentChildren(OngoingProgressViewModel viewModel) => [
        verticalSpaceMedium,
        _buildText(),
        verticalSpaceMedium,
        _buildLearningProgressCard(),
        verticalSpaceMedium,
        _buildCourseProgressSection()
      ];

  Widget _buildText() => const Text(
        'Track your learning journey and see your growth over time.',
        style: TextStyle(color: kcDarkGrey),
      );

  Widget _buildLearningProgressCard() => const LearningProgressCard();

  Widget _buildCourseProgressSection() => const CourseProgressSection();
}
