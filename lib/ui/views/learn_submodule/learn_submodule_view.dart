import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/module.dart';
import 'package:yimaru_app/models/submodule.dart';
import 'package:yimaru_app/ui/widgets/course_module_banner.dart';
import 'package:yimaru_app/ui/widgets/learn_submodule_tile.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/overall_learn_progress.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_submodule_viewmodel.dart';

class LearnSubmoduleView extends StackedView<LearnSubmoduleViewModel> {
  final Module module;

  @override
  void onViewModelReady(LearnSubmoduleViewModel viewModel) async {
    await viewModel.getSubmodules(module.id ?? 0);
    super.onViewModelReady(viewModel);
  }

  const LearnSubmoduleView({Key? key, required this.module}) : super(key: key);

  @override
  LearnSubmoduleViewModel viewModelBuilder(BuildContext context) =>
      LearnSubmoduleViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnSubmoduleViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnSubmoduleViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnSubmoduleViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(LearnSubmoduleViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnSubmoduleViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildModulesColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(LearnSubmoduleViewModel viewModel) => SmallAppBar(
        title: 'Submodules',
        onTap: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildModulesColumnWrapper(LearnSubmoduleViewModel viewModel) =>
      Expanded(child: _buildLevelsColumnScrollView(viewModel));

  Widget _buildLevelsColumnScrollView(LearnSubmoduleViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildLevelsColumn(viewModel),
      );

  Widget _buildLevelsColumn(LearnSubmoduleViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildLevelsColumnChildren(viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(LearnSubmoduleViewModel viewModel) =>
      [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildCourseModuleBanner(),
        verticalSpaceMedium,
        _buildOverallProgress(),
        verticalSpaceTiny,
        _buildContinueButton(viewModel),
        verticalSpaceMedium,
        _buildListViewBuilder(viewModel)
      ];

  Widget _buildTitle() => Text(
        module.title ?? '',
        style: style18P600,
      );

  Widget _buildCourseModuleBanner() => const CourseModuleBanner();

  Widget _buildOverallProgress() => const OverallLearnProgress(
        color: Colors.transparent,
      );

  Widget _buildContinueButton(LearnSubmoduleViewModel viewModel) =>
      const CustomElevatedButton(
          height: 55,
          borderRadius: 12,
          foregroundColor: kcWhite,
          text: 'Continue Submodule',
          backgroundColor: kcPrimaryColor);

  Widget _buildListViewBuilder(LearnSubmoduleViewModel viewModel) =>
      viewModel.busy(StateObjects.learnSubmodules)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(LearnSubmoduleViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.submodules.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
          submodule: viewModel.submodules[index],
          onPracticeTap: () {},
          onLessonTap: () async => await viewModel
              .navigateToLearnLessons(viewModel.submodules[index]),
        ),
      );

  Widget _buildTile({
    required Submodule submodule,
    required GestureTapCallback onLessonTap,
    required GestureTapCallback onPracticeTap,
  }) =>
      LearnSubmoduleTile(
        submodule: submodule,
        onLessonTap: onLessonTap,
        onPracticeTap: onPracticeTap,
      );
}
