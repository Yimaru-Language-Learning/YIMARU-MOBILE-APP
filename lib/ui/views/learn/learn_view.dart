import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/learn_tile.dart';

import '../../../models/course.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_viewmodel.dart';

class LearnView extends StackedView<LearnViewModel> {
  final int id;

  const LearnView({Key? key, required this.id}) : super(key: key);

  @override
  void onViewModelReady(LearnViewModel viewModel) async {
    await viewModel.getCourses(id);
    super.onViewModelReady(viewModel);
  }

  @override
  LearnViewModel viewModelBuilder(BuildContext context) => LearnViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(LearnViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildLearnColumnWrapper(viewModel)
        ],
      );

  Widget _buildAppBar(LearnViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildLearnColumnWrapper(LearnViewModel viewModel) =>
      Expanded(child: _buildLearnColumnScrollView(viewModel));

  Widget _buildLearnColumnScrollView(LearnViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildListViewBuilder(viewModel),
      );

  Widget _buildListViewBuilder(LearnViewModel viewModel) =>
      viewModel.busy(StateObjects.learnCourses)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(LearnViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.courses.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => verticalSpaceSmall,
        itemBuilder: (context, index) => _buildTile(
          course: viewModel.courses[index],
          onTap: () async => await viewModel
              .navigateToLearnLevel(viewModel.courses[index].id ?? 0),
        ),
      );

  Widget _buildTile({
    required Course course,
    required GestureTapCallback onTap,
  }) =>
      LearnTile(
        onTap: onTap,
        course: course,
      );
}
