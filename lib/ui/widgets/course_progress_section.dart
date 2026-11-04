import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../common/app_colors.dart';
import '../views/my_progress/my_progress_viewmodel.dart';

class CourseProgressSection extends ViewModelWidget<MyProgressViewModel> {
  const CourseProgressSection({super.key});

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
            const SizedBox(height: 16),
            _buildCourseList(viewModel),
          ],
        ),
      );

  Widget _buildHeaderRow() => Row(
        children: [
          _buildIconBox(),
          const SizedBox(width: 14),
          Text(
            LocaleKeys.course.tr(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              fontFamily: 'Aeonik',
              color: Color(0xFF1A1A2E),
            ),
          ),
        ],
      );

  Widget _buildIconBox() => Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFFFF0D3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/images/subscription and progress/course-graduation-cap.svg',
            width: 34,
            height: 34,
            fit: BoxFit.contain,
          ),
        ),
      );

  Widget _buildCourseList(MyProgressViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: viewModel.courses
            .map((course) => _buildCourseItem(course['title'] ?? ''))
            .toList(),
      );

  Widget _buildCourseItem(String title) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEEEEF0)),
        ),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: true,
            tilePadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            iconColor: AppColors.magenta35,
            collapsedIconColor: AppColors.magenta35,
            trailing: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.magenta35,
              size: 24,
            ),
            title: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4AC600),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.flag_rounded,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Aeonik',
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ),
              ],
            ),
            children: [
              _buildProgressBar(),
              const SizedBox(height: 12),
              _buildStatsBox(),
              const SizedBox(height: 14),
              _buildContinueButton(),
            ],
          ),
        ),
      );

  Widget _buildProgressBar() => ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: const LinearProgressIndicator(
          value: 0.05,
          minHeight: 8,
          backgroundColor: Color(0xFFEADBEE),
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4AC600)),
        ),
      );

  Widget _buildStatsBox() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF8FC),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            _buildStatItem(
              value: LocaleKeys.zero_slash_zero.tr(),
              label: LocaleKeys.videos.tr(),
            ),
            const SizedBox(width: 40),
            _buildStatItem(
              value: LocaleKeys.zero_slash_zero.tr(),
              label: LocaleKeys.practice.tr(),
            ),
          ],
        ),
      );

  Widget _buildStatItem({required String value, required String label}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              fontFamily: 'Aeonik',
              color: AppColors.magenta35,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              fontFamily: 'Aeonik',
              color: Color(0xFF888899),
            ),
          ),
        ],
      );

  Widget _buildContinueButton() => Container(
        width: double.infinity,
        height: 46,
        decoration: BoxDecoration(
          color: AppColors.magenta35,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            '${LocaleKeys.continue_course.tr()} →',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Aeonik',
              color: AppColors.white,
            ),
          ),
        ),
      );
}
