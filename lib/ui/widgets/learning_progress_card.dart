import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../common/app_colors.dart';
import '../views/my_progress/my_progress_viewmodel.dart';

class LearningProgressCard extends ViewModelWidget<MyProgressViewModel> {
  final GestureTapCallback? onTap;

  const LearningProgressCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context, MyProgressViewModel viewModel) =>
      _buildCard(viewModel);

  Widget _buildCard(MyProgressViewModel viewModel) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFEEEEF0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderRow(),
            const SizedBox(height: 14),
            _buildProgressBar(viewModel),
            const SizedBox(height: 14),
            _buildStatsBox(viewModel),
            const SizedBox(height: 16),
            _buildContinueButton(viewModel),
          ],
        ),
      );

  Widget _buildHeaderRow() => Row(
        children: [
          _buildIconBox(),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.learn_english.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Aeonik',
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  LocaleKeys.keep_momentum.tr(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Aeonik',
                    color: Color(0xFF888899),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _buildIconBox() => Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFF7EBF5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/images/subscription and progress/learn-english-book.svg',
            width: 34,
            height: 34,
            fit: BoxFit.contain,
          ),
        ),
      );

  Widget _buildProgressBar(MyProgressViewModel viewModel) {
    final progress = viewModel.busy(StateObjects.progressSummary)
        ? 0.0
        : (viewModel.totalProgress / 100).clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
        backgroundColor: const Color(0xFFEADBEE),
        valueColor:
            const AlwaysStoppedAnimation<Color>(AppColors.magenta35),
      ),
    );
  }

  Widget _buildStatsBox(MyProgressViewModel viewModel) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF8FC),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildStatItem(
              value: viewModel.busy(StateObjects.progressSummary)
                  ? '-'
                  : viewModel.completedCount.toString(),
              label: LocaleKeys.completed_practices.tr(),
            ),
            _buildStatItem(
              value: viewModel.busy(StateObjects.progressSummary)
                  ? '-'
                  : viewModel.totalCount.toString(),
              label: LocaleKeys.total_practices.tr(),
            ),
            _buildStatItem(
              value: viewModel.busy(StateObjects.progressSummary)
                  ? '-'
                  : '${viewModel.totalProgress}%',
              label: LocaleKeys.progress_percentage.tr(),
            ),
          ],
        ),
      );

  Widget _buildStatItem({required String value, required String label}) =>
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                fontFamily: 'Aeonik',
                color: AppColors.magenta35,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                fontFamily: 'Aeonik',
                color: Color(0xFF888899),
              ),
            ),
          ],
        ),
      );

  Widget _buildContinueButton(MyProgressViewModel viewModel) =>
      GestureDetector(
        onTap: () async => await viewModel.navigateToLearnProgram(),
        child: Container(
          width: double.infinity,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.magenta35,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${LocaleKeys.continue_learning.tr()} →',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Aeonik',
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      );
}
