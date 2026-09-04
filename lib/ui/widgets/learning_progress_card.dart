import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/custom_column.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import '../views/my_progress/my_progress_viewmodel.dart';
import 'custom_elevated_button.dart';
import 'custom_linear_progress_indicator.dart';

class LearningProgressCard extends ViewModelWidget<MyProgressViewModel> {
  final GestureTapCallback? onTap;

  const LearningProgressCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context, MyProgressViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(MyProgressViewModel viewModel) => Container(
        height: 320,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kcPrimaryColor.withValues(alpha: 0.1),
        ),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(MyProgressViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(MyProgressViewModel viewModel) => [
        _buildIcon(),
        verticalSpaceSmall,
        _buildTitle(),
        verticalSpaceTiny,
        _buildSubtitle(),
        verticalSpaceSmall,
        _buildProgressIndicator(viewModel),
        verticalSpaceSmall,
        _buildLearningStatus(viewModel),
        verticalSpaceMedium,
        _buildActionButton(viewModel),
      ];

  Widget _buildIcon() => const Icon(
        Icons.menu_book_rounded,
        size: 50,
        color: kcPrimaryColor,
      );

  Widget _buildTitle() => Text(
        LocaleKeys.learn_english.tr(),
        style: style16DG600,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.keep_momentum.tr(),
        maxLines: 2,
        style: style14MG400,
      );

  Widget _buildProgressIndicator(MyProgressViewModel viewModel) =>
      CustomLinearProgressIndicator(
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
        progress: viewModel.busy(StateObjects.progressSummary)
            ? 0
            : viewModel.totalProgress / 100,
      );

  Widget _buildLearningStatus(MyProgressViewModel viewModel) => Row(
        children: _buildLearningStatusChildren(viewModel),
      );

  List<Widget> _buildLearningStatusChildren(MyProgressViewModel viewModel) => [
        _buildCompletedPractices(viewModel),
        horizontalSpaceSmall,
        _buildTotalPractices(viewModel),
        horizontalSpaceSmall,
        _buildProgressPercentage(viewModel),
      ];

  Widget _buildCompletedPractices(MyProgressViewModel viewModel) => Expanded(
      child: CustomColumn(
          title: viewModel.busy(StateObjects.progressSummary)
              ? '-'
              : viewModel.completedCount.toString(),
          subtitle: LocaleKeys.completed_practices.tr()));

  Widget _buildTotalPractices(MyProgressViewModel viewModel) => Expanded(
      child: CustomColumn(
          title: viewModel.busy(StateObjects.progressSummary)
              ? '-'
              : viewModel.totalCount.toString(),
          subtitle: LocaleKeys.total_practices.tr()));

  Widget _buildProgressPercentage(MyProgressViewModel viewModel) => Expanded(
      child: CustomColumn(
          title: viewModel.busy(StateObjects.progressSummary)
              ? '-'
              : '${viewModel.totalProgress.toString()}%',
          subtitle: LocaleKeys.progress_percentage.tr()));

  Widget _buildActionButton(MyProgressViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        width: 200,
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        text: LocaleKeys.continue_learning.tr(),
        onTap: () async => await viewModel.navigateToLearnProgram(),
      );
}
