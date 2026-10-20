import 'package:flutter/material.dart';
import '../../widgets/retryable_content.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_program.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/profile_app_bar.dart';
import '../../widgets/learn_program_tile.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_program_viewmodel.dart';

class LearnProgramView extends StackedView<LearnProgramViewModel> {
  final bool showAppBar;
  const LearnProgramView({Key? key, required this.showAppBar})
      : super(key: key);

  @override
  void onViewModelReady(LearnProgramViewModel viewModel) async {
    await viewModel.getLearnPrograms();
    super.onViewModelReady(viewModel);
  }

  @override
  LearnProgramViewModel viewModelBuilder(BuildContext context) =>
      LearnProgramViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnProgramViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnProgramViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(LearnProgramViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnProgramViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(LearnProgramViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnProgramViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBarState(viewModel),
          verticalSpaceMedium,
          _buildProgramsColumnWrapper(viewModel)
        ],
      );

  Widget _buildAppBarState(LearnProgramViewModel viewModel) => showAppBar
      ? _buildProfileAppBar(viewModel)
      : _buildSmallAppBar(viewModel);

  Widget _buildSmallAppBar(LearnProgramViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.pop,
      );

  Widget _buildProfileAppBar(LearnProgramViewModel viewModel) => ProfileAppBar(
        name: viewModel.user?.firstName,
        profileImage: viewModel.user?.profilePicture,
        unreadCount: viewModel.unreadCount.toString(),
        onTap: () async => await viewModel.navigateToNotification(),
      );

  Widget _buildProgramsColumnWrapper(LearnProgramViewModel viewModel) =>
      Expanded(child: _buildProgramsColumnScrollView(viewModel));

  Widget _buildProgramsColumnScrollView(LearnProgramViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildListViewBuilder(viewModel),
      );

  Widget _buildListViewBuilder(LearnProgramViewModel viewModel) =>
      RetryableContent(
        isLoading: viewModel.busy(StateObjects.learnPrograms),
        hasError: viewModel.hasErrorForKey(StateObjects.learnPrograms),
        onRetry: () => viewModel.getLearnPrograms(),
        loading: _buildProgressIndicator(),
        builder: () => _buildListView(viewModel),
      );

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(LearnProgramViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.learnPrograms.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => verticalSpaceSmall,
        itemBuilder: (context, index) => _buildTile(
          program: viewModel.learnPrograms[index],
          onTap: () async => await viewModel.navigateToLearnCourse(
              context: context,
              first: index == 0, id: viewModel.learnPrograms[index].id ?? 0),
        ),
      );

  Widget _buildTile({
    required LearnProgram program,
    required GestureTapCallback onTap,
  }) =>
      LearnProgramTile(onTap: onTap, program: program);
}
