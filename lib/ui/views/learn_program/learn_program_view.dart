import 'package:flutter/material.dart';
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
        backgroundColor: AppColors.background,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(LearnProgramViewModel viewModel) =>
      _buildScaffold(viewModel);

  Widget _buildScaffold(LearnProgramViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(LearnProgramViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnProgramViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBarState(viewModel),
          const SizedBox(height: 24),
          _buildProgramsColumnWrapper(viewModel),
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
        padding: const EdgeInsets.only(bottom: 24),
        child: _buildListViewBuilder(viewModel),
      );

  Widget _buildListViewBuilder(LearnProgramViewModel viewModel) =>
      viewModel.busy(StateObjects.learnPrograms)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(LearnProgramViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.learnPrograms.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 4),
        itemBuilder: (context, index) => _buildTile(
          index: index,
          program: viewModel.learnPrograms[index],
          onTap: () async => await viewModel.navigateToLearnCourse(
              first: index == 0, id: viewModel.learnPrograms[index].id ?? 0),
        ),
      );

  Widget _buildTile({
    required int index,
    required LearnProgram program,
    required GestureTapCallback onTap,
  }) =>
      LearnProgramTile(index: index, onTap: onTap, program: program);
}
