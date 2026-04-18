import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/level.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/widgets/learn_module_tile.dart';
import 'package:yimaru_app/ui/widgets/overall_learn_progress.dart';

import '../../../models/module.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_module_viewmodel.dart';

class LearnModuleView extends StackedView<LearnModuleViewModel> {
  final Level level;

  const LearnModuleView({Key? key, required this.level}) : super(key: key);

  @override
  void onViewModelReady(LearnModuleViewModel viewModel) async {
    await viewModel.getModules(level.id ?? 0);
    super.onViewModelReady(viewModel);
  }

  @override
  LearnModuleViewModel viewModelBuilder(BuildContext context) =>
      LearnModuleViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnModuleViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnModuleViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnModuleViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(LearnModuleViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnModuleViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildModulesColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(LearnModuleViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildModulesColumnWrapper(LearnModuleViewModel viewModel) =>
      Expanded(child: _buildLevelsColumnScrollView(viewModel));

  Widget _buildLevelsColumnScrollView(LearnModuleViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildLevelsColumn(viewModel),
      );

  Widget _buildLevelsColumn(LearnModuleViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildLevelsColumnChildren(viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(LearnModuleViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildOverallProgress(),
        verticalSpaceMedium,
        _buildListView(viewModel)
      ];

  Widget _buildTitle() => Text(
        level.title ?? '',
        style: style18P600,
      );

  Widget _buildSubtitle() => Text(
        'Your Current Level',
        style: style14DG400,
      );

  Widget _buildOverallProgress() => const OverallLearnProgress();

  Widget _buildListView(LearnModuleViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.modules.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
            module: viewModel.modules[index],
            onLessonTap: () {},
            onPracticeTap: () {}),
      );

  Widget _buildTile({
    required Module module,
    required GestureTapCallback onLessonTap,
    required GestureTapCallback onPracticeTap,
  }) =>
      LearnModuleTile(
        module: module,
        onLessonTap: onLessonTap,
        onPracticeTap: onPracticeTap,
      );
}
