import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_module.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/learn_module_tile.dart';
import 'package:yimaru_app/ui/widgets/overall_progress.dart';

import '../../../models/learn_course.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/finish_practice_sheet.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_module_viewmodel.dart';

class LearnModuleView extends StackedView<LearnModuleViewModel> {
  final bool first;
  final LearnCourse course;

  const LearnModuleView({Key? key, required this.first, required this.course})
      : super(key: key);

  Future<void> _onPractice(
      {required BuildContext context,
      required LearnModule module,
      required LearnModuleViewModel viewModel}) async {
    if (viewModel.user?.learn ?? false) {
      if (module.access?.isCompleted ?? false) {
        await viewModel.navigateToLearnPractice(
            id: module.id ?? 0, module: module.name ?? '');
      } else {
        if (module.access?.isAccessible ?? false) {
          await _showSheet(
              context: context,
              viewModel: viewModel,
              practice: PracticeReason.module);
        } else {
          await _showSheet(
              context: context,
              viewModel: viewModel,
              practice: PracticeReason.previousModule);
        }
      }
    } else {
      await viewModel.navigateToLearnPractice(
          id: module.id ?? 0, module: module.name ?? '');
    }
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required PracticeReason practice,
          required LearnModuleViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        backgroundColor: kcTransparent,
        builder: (_) => _buildSheet(viewModel: viewModel, practice: practice),
      );

  @override
  void onViewModelReady(LearnModuleViewModel viewModel) async {
    await viewModel.getLearnModules(course.id ?? 0);
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
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldContainer(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      SafeArea(child: _buildBody(context: context, viewModel: viewModel));

  Widget _buildBody(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(context: context, viewModel: viewModel),
      );

  Widget _buildColumn(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildModulesColumnWrapper(context: context, viewModel: viewModel),
        ],
      );

  Widget _buildAppBar(LearnModuleViewModel viewModel) => SmallAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildModulesColumnWrapper(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Expanded(
          child: _buildLevelsColumnScrollView(
              context: context, viewModel: viewModel));

  Widget _buildLevelsColumnScrollView(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildLevelsColumn(context: context, viewModel: viewModel),
      );

  Widget _buildLevelsColumn(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            _buildLevelsColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      [
        verticalSpaceSmall,
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildOverallProgress(viewModel),
        verticalSpaceMedium,
        _buildListViewBuilder(context: context, viewModel: viewModel)
      ];

  Widget _buildTitle() => Text(
        course.name ?? '',
        style: style18P600,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.your_current_level.tr(),
        style: style14P400,
      );

  Widget _buildOverallProgress(LearnModuleViewModel viewModel) =>
      OverallProgress(
        indicatorBackgroundColor: kcWhite,
        backgroundColor: kcPrimaryColor.withValues(alpha: 0.1),
        progress: (viewModel.getUpdatedLearnCourse(course.id ?? 0) ?? course)
                .access
                ?.progressPercent ??
            0,
      );

  Widget _buildListViewBuilder(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      viewModel.busy(StateObjects.learnModules)
          ? _buildProgressIndicator()
          : _buildListView(context: context, viewModel: viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.modules.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
          module: viewModel.modules[index],
          onPracticeTap: () async => await _onPractice(
            context: context,
            viewModel: viewModel,
            module: viewModel.modules[index],
          ),
          onModuleTap: () async => await viewModel.navigateToLearnLesson(
              first: first && index == 0, module: viewModel.modules[index]),
        ),
      );

  Widget _buildTile({
    required LearnModule module,
    required GestureTapCallback onModuleTap,
    required GestureTapCallback onPracticeTap,
  }) =>
      LearnModuleTile(
          module: module,
          onModuleTap: onModuleTap,
          onPracticeTap: onPracticeTap);

  Widget _buildSheet(
          {required PracticeReason practice,
          required LearnModuleViewModel viewModel}) =>
      FinishPracticeSheet(
        practice: practice,
        onTap: viewModel.pop,
      );
}
