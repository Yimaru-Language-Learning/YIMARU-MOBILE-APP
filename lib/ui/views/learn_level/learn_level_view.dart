import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/learn_sub_level_tile.dart';
import 'package:yimaru_app/ui/widgets/small_app_bar.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'learn_level_viewmodel.dart';

class LearnLevelView extends StackedView<LearnLevelViewModel> {
  const LearnLevelView({Key? key}) : super(key: key);

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
          _buildLevelsColumnWrapper(viewModel)
        ],
      );

  Widget _buildAppBar(LearnLevelViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildLevelsColumnWrapper(LearnLevelViewModel viewModel) =>
      Expanded(child: _buildLevelsColumnScrollView(viewModel));

  Widget _buildLevelsColumnScrollView(LearnLevelViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildLevelsColumn(viewModel),
      );

  Widget _buildLevelsColumn(LearnLevelViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildLevelsColumnChildren(viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(LearnLevelViewModel viewModel) =>
      [verticalSpaceLarge, _buildListView(viewModel)];

  Widget _buildListView(LearnLevelViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.learnSubLevels.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
            title: viewModel.learnSubLevels[index]['title'],
            current: viewModel.learnSubLevels[index]['current'],
            subtitle: viewModel.learnSubLevels[index]['subtitle']),
      );

  Widget _buildTile({
    required String title,
    required bool current,
    required String subtitle,
  }) =>
      LearnSubLevelTile(
        title: title,
        current: current,
        subtitle: subtitle,
      );
}
