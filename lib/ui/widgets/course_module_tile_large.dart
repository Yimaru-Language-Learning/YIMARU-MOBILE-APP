import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course_catalog.dart';
import 'package:yimaru_app/models/course_lesson.dart';
import 'package:yimaru_app/models/course_module.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/course_module/course_module_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/course_lesson_tile.dart';
import 'package:yimaru_app/ui/widgets/finish_practice_sheet.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';

class CourseModuleTileLarge extends ViewModelWidget<CourseModuleViewModel> {
  final bool first;
  final CourseModule? module;
  final SubscriptionType type;
  final CourseCatalog? catalog;
  final List<CourseLesson> lessons;
  final GestureTapCallback? onContinueTap;
  final int unitSortOrder;

  const CourseModuleTileLarge({
    super.key,
    this.catalog,
    this.onContinueTap,
    required this.type,
    required this.first,
    required this.module,
    required this.lessons,
    this.unitSortOrder = 1,
  });

  // ── Theme ─────────────────────────────────────────────────────────────────
  bool get _isProfessionals =>
      (catalog?.name ?? '').toLowerCase().contains('prof') ||
      (catalog?.category ?? '').toLowerCase().contains('prof') ||
      type == SubscriptionType.learn ||
      (module?.name ?? '').contains('ሥራ') ||
      (module?.name ?? '').contains('ሲቪ') ||
      (module?.name ?? '').contains('ቃለ መጠይቅ');

  bool get _isIelts => !_isProfessionals && type == SubscriptionType.ielts;

  Color get _themeColor {
    if (_isProfessionals) return const Color(0xFF8E2483);
    if (_isIelts) return const Color(0xFFE4002B);
    return AppColors.chartreuse40;
  }

  // ── Access logic (unchanged) ──────────────────────────────────────────────
  Future<void> _onPractice({
    required int index,
    required CourseLesson lesson,
    required BuildContext context,
    required CourseModuleViewModel viewModel,
  }) async =>
      await viewModel.navigateToCoursePractice(type: type, id: lesson.id ?? 0);

  Future<void> _onVideo({
    required int index,
    required CourseLesson lesson,
    required BuildContext context,
    required CourseModuleViewModel viewModel,
  }) async {
    if (type == SubscriptionType.duolingo) {
      if (viewModel.user?.duolingo ?? false) {
        await viewModel.navigateToCourseLessonDetail(
            type: type, lesson: lessons[index]);
      } else {
        if (lesson.accessTier?.toUpperCase() == 'FREE') {
          await viewModel.navigateToCourseLessonDetail(
              type: type, lesson: lessons[index]);
        } else {
          await viewModel
              .navigateToCourseSubscription(SubscriptionType.duolingo);
        }
      }
    } else {
      if (viewModel.user?.ielts ?? false) {
        await viewModel.navigateToCourseLessonDetail(
            type: type, lesson: lessons[index]);
      } else {
        if (lesson.accessTier?.toUpperCase() == 'FREE') {
          await viewModel.navigateToCourseLessonDetail(
              type: type, lesson: lessons[index]);
        } else {
          await viewModel.navigateToCourseSubscription(SubscriptionType.ielts);
        }
      }
    }
  }

  Future<void> _showSheet({
    required BuildContext context,
    required CourseModuleViewModel viewModel,
  }) async =>
      await showModalBottomSheet(
        context: context,
        backgroundColor: kcTransparent,
        builder: (_) => FinishPracticeSheet(onTap: viewModel.pop),
      );

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context, CourseModuleViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModuleHeader(viewModel),
          const SizedBox(height: 12),
          _buildLessonsList(context, viewModel),
        ],
      );

  // ── Collapsible section header (theme-coloured) ───────────────────────────
  Widget _buildModuleHeader(CourseModuleViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: _themeColor,
            borderRadius: BorderRadius.circular(14),
          ),
          clipBehavior: Clip.antiAlias,
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: true,
              collapsedBackgroundColor: _themeColor,
              backgroundColor: _themeColor,
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              childrenPadding: EdgeInsets.zero,
              title: _buildModuleHeaderTitle(),
              trailing: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              children: [
                _buildModuleHeaderExpanded(viewModel),
              ],
            ),
          ),
        ),
      );

  Widget _buildModuleHeaderTitle() {
    final moduleLabel = (module?.name?.contains('.') ?? false)
        ? 'MODULE ${module!.name!.split(' ').first}'
        : LocaleKeys.module_detail.tr().toUpperCase();
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UNIT $unitSortOrder · $moduleLabel',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'Aeonik',
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            module?.name ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              fontFamily: 'Aeonik',
              color: Colors.white,
            ),
          ),
        ],
      );
  }

  Widget _buildModuleHeaderExpanded(CourseModuleViewModel viewModel) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '0% ${LocaleKeys.zero_percent_completed.tr()}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Aeonik',
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0,
                      minHeight: 7,
                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '0/${_getLessons().isNotEmpty ? _getLessons().length : 1}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Aeonik',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            if (type == SubscriptionType.duolingo) ...[
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async => await viewModel.navigateToCoursePractice(
                  id: module?.id ?? 0,
                  type: type,
                ),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.assignment_outlined,
                          size: 16, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        '${LocaleKeys.practice_test.tr()} - ${module?.name ?? ''}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Aeonik',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      );

  List<CourseLesson> _getLessons() {
    if (lessons.isNotEmpty) return lessons;
    if (_isProfessionals) {
      return [
        CourseLesson(
          id: module?.id ?? 1,
          title: module?.name ?? 'Lesson 1',
          sortOrder: 1,
          accessTier: 'FREE',
        ),
      ];
    }
    return lessons;
  }

  // ── Lessons list ──────────────────────────────────────────────────────────
  Widget _buildLessonsList(
      BuildContext context, CourseModuleViewModel viewModel) {
    final list = _getLessons();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) => CourseLessonTile(
        index: index,
        lesson: list[index],
        module: module,
        catalog: catalog,
        courseType: type,
        unitSortOrder: unitSortOrder,
        moduleSortOrder: module?.sortOrder ?? 1,
        onVideoTap: () async => await _onVideo(
          index: index,
          lesson: list[index],
          context: context,
          viewModel: viewModel,
        ),
        onPracticeTap: () async => await _onPractice(
          index: index,
          lesson: list[index],
          context: context,
          viewModel: viewModel,
        ),
      ),
    );
  }
}
