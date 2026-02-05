import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/learn_app_bar.dart';
import 'package:yimaru_app/ui/widgets/learn_level_tile.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import 'learn_viewmodel.dart';

class LearnView extends StackedView<LearnViewModel> {
  const LearnView({Key? key}) : super(key: key);

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
          _buildLevelsColumnWrapper(viewModel)
        ],
      );

  Widget _buildAppBar(LearnViewModel viewModel) => LearnAppBar(
        name: viewModel.user?.firstName,
        profileImage: viewModel.user?.profilePicture,
      );

  Widget _buildLevelsColumnWrapper(LearnViewModel viewModel) =>
      Expanded(child: _buildLevelsColumnScrollView(viewModel));

  Widget _buildLevelsColumnScrollView(LearnViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildLevelsColumn(viewModel),
      );

  Widget _buildLevelsColumn(LearnViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildLevelsColumnChildren(viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(LearnViewModel viewModel) =>
      [verticalSpaceLarge, _buildListView(viewModel)];

  Widget _buildListView(LearnViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.learnLevels.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
            title: viewModel.learnLevels[index]['title'],
            status: viewModel.learnLevels[index]['status'],
            subtitle: viewModel.learnLevels[index]['subtitle']),
      );

  Widget _buildTile(
          {required String title,
          required String subtitle,
          required ProgressStatuses status}) =>
      LearnLevelTile(
        title: title,
        status: status,
        subtitle: subtitle,
      );
}
