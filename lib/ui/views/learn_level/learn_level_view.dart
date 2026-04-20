import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/learn_level_tile.dart';
import 'package:yimaru_app/ui/widgets/small_app_bar.dart';

import '../../../models/level.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import 'learn_level_viewmodel.dart';

class LearnLevelView extends StackedView<LearnLevelViewModel> {
  final int id;
  const LearnLevelView({Key? key, required this.id}) : super(key: key);

  @override
  void onViewModelReady(LearnLevelViewModel viewModel) async {
    await viewModel.getLevels(id);
    super.onViewModelReady(viewModel);
  }

  @override
  LearnLevelViewModel viewModelBuilder(BuildContext context) =>
      LearnLevelViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnLevelViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnLevelViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnLevelViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(LearnLevelViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnLevelViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildLevelsColumnWrapper(viewModel)
        ],
      );

  Widget _buildAppBar(LearnLevelViewModel viewModel) => SmallAppBar(
        title: 'Levels',
        onTap: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildLevelsColumnWrapper(LearnLevelViewModel viewModel) =>
      Expanded(child: _buildLevelsColumnScrollView(viewModel));

  Widget _buildLevelsColumnScrollView(LearnLevelViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildListViewBuilder(viewModel),
      );

  Widget _buildListViewBuilder(LearnLevelViewModel viewModel) =>
      viewModel.busy(StateObjects.learnLevels)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(LearnLevelViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.levels.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
          level: viewModel.levels[index],
          onTap: () async =>
              await viewModel.navigateToModule(viewModel.levels[index]),
        ),
        separatorBuilder: (context, index) => verticalSpaceSmall,
      );

  Widget _buildTile({
    required Level level,
    required GestureTapCallback onTap,
  }) =>
      LearnLevelTile(
        onTap: onTap,
        level: level,
      );
}
