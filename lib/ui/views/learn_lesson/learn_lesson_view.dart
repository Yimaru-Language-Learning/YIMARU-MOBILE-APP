import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_lesson.dart';
import 'package:yimaru_app/models/learn_module.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/lesson_illustration_resolver.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:yimaru_app/ui/widgets/finish_practice_sheet.dart';
import 'package:yimaru_app/ui/widgets/learn_lesson_tile.dart';
import 'package:yimaru_app/ui/widgets/motivation_card.dart';

import 'learn_lesson_viewmodel.dart';

class LearnLessonView extends StackedView<LearnLessonViewModel> {
  final bool first;
  final LearnModule module;

  const LearnLessonView({Key? key, required this.first, required this.module})
      : super(key: key);

  Future<void> _onPractice({
    required int index,
    required LearnLesson lesson,
    required BuildContext context,
    required LearnLessonViewModel viewModel,
  }) async {
    if (viewModel.user?.learn ?? false) {
      if (lesson.access?.isAccessible ?? false) {
        await viewModel.navigateToLearnPractice(lesson.id ?? 0);
      } else {
        await _showSheet(context: context, viewModel: viewModel);
      }
    } else {
      await viewModel.navigateToLearnPractice(lesson.id ?? 0);
    }
  }

  Future<void> _showSheet({
    required BuildContext context,
    required LearnLessonViewModel viewModel,
  }) async =>
      await showModalBottomSheet(
        context: context,
        backgroundColor: kcTransparent,
        builder: (_) => _buildSheet(viewModel),
      );

  @override
  void onViewModelReady(LearnLessonViewModel viewModel) async {
    await viewModel.getLessons(module.id ?? 0);
    super.onViewModelReady(viewModel);
  }

  @override
  LearnLessonViewModel viewModelBuilder(BuildContext context) =>
      LearnLessonViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnLessonViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper({
    required BuildContext context,
    required LearnLessonViewModel viewModel,
  }) =>
      Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: _buildBody(context: context, viewModel: viewModel),
        ),
      );

  Widget _buildBody({
    required BuildContext context,
    required LearnLessonViewModel viewModel,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pinned Squircle Back Button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: _buildAppBar(viewModel),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Module Header Card with Status, Title, Description, Illustration, and Progress
                  _buildModuleHeaderCard(viewModel),
                  const SizedBox(height: 16),

                  // Motivation Card with Mascot Yimi
                  _buildMotivationCard(viewModel),
                  const SizedBox(height: 22),

                  // Section Header: "Lessons in this module" + count
                  _buildSectionHeader(viewModel),
                  const SizedBox(height: 14),

                  // Lessons List
                  _buildLessonsSection(context: context, viewModel: viewModel),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _buildAppBar(LearnLessonViewModel viewModel) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: viewModel.pop,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: kcWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.neutral84.withValues(alpha: 0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.neutral14.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back_rounded,
              size: 22,
              color: AppColors.magenta38,
            ),
          ),
        ),
      );

  Widget _buildModuleHeaderCard(LearnLessonViewModel viewModel) {
    final updatedModule =
        viewModel.getUpdatedLearnModule(module.id ?? 0) ?? module;
    final isCompleted = updatedModule.access?.isCompleted ?? false;

    final total = updatedModule.access?.totalCount ??
        (viewModel.lessons.isNotEmpty ? viewModel.lessons.length : 1);
    final completed = updatedModule.access?.completedCount ??
        (isCompleted ? total : 0);
    final double percent =
        total > 0 ? (completed / total).clamp(0.0, 1.0) : 0.0;
    final int percentInt = (percent * 100).round();

    final Color cardBg =
        isCompleted ? const Color(0xFFE8F7F0) : const Color(0xFFFFF6D7);
    final Color cardBorder =
        isCompleted ? const Color(0xFFBCECD1) : const Color(0xFFFFE8A3);

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: cardBorder,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral14.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Content on Left + Squircle Illustration on Right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Badge (Completed or In Progress)
                    if (isCompleted)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: kcWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 14,
                              color: Color(0xFF22C55E),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              LocaleKeys.completed.tr(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF22C55E),
                                fontFamily: 'Aeonik',
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: kcWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.magenta38,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              LocaleKeys.in_progress.tr(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.magenta38,
                                fontFamily: 'Aeonik',
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 10),

                    // Module Title
                    Text(
                      updatedModule.name ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.neutral14,
                        fontFamily: 'Aeonik',
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Module Description
                    Text(
                      updatedModule.description ?? '',
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral40,
                        height: 1.35,
                        fontFamily: 'Aeonik',
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),

              // Squircle Illustration Box
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: kcWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neutral14.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: _buildModuleIllustration(updatedModule),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Bottom Progress Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: kcWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$percentInt% Progress',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.neutral14,
                        fontFamily: 'Aeonik',
                      ),
                    ),
                    Text(
                      '$completed/$total',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.neutral40,
                        fontFamily: 'Aeonik',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: percent,
                    minHeight: 6,
                    backgroundColor: AppColors.neutral93,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCompleted
                          ? const Color(0xFF22C55E)
                          : AppColors.magenta38,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleIllustration(LearnModule module) {
    return SvgPicture.asset(
      LessonIllustrationResolver.resolveModuleSvg(
        module.name,
        module.sortOrder ?? 0,
      ),
      fit: BoxFit.contain,
    );
  }

  Widget _buildMotivationCard(LearnLessonViewModel viewModel) {
    final updatedModule =
        viewModel.getUpdatedLearnModule(module.id ?? 0) ?? module;
    final isCompleted = updatedModule.access?.isCompleted ?? false;
    final total = updatedModule.access?.totalCount ??
        (viewModel.lessons.isNotEmpty ? viewModel.lessons.length : 1);
    final completed = updatedModule.access?.completedCount ??
        (isCompleted ? total : 0);
    final percent = total > 0 ? (completed / total) : 0.0;

    final String message;
    if (isCompleted || percent >= 1.0) {
      message = LocaleKeys.module_complete_motivation.tr();
    } else if (percent >= 0.5) {
      message = LocaleKeys.module_halfway_motivation.tr();
    } else {
      message = LocaleKeys.module_start_motivation.tr();
    }

    return MotivationCard(customText: message);
  }

  Widget _buildSectionHeader(LearnLessonViewModel viewModel) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleKeys.lessons_in_module.tr(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.neutral14,
              fontFamily: 'Aeonik',
              letterSpacing: -0.2,
            ),
          ),
          Text(
            LocaleKeys.lessons_count
                .tr(args: ['${viewModel.lessons.length}']),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.neutral40,
              fontFamily: 'Aeonik',
            ),
          ),
        ],
      );

  Widget _buildLessonsSection({
    required BuildContext context,
    required LearnLessonViewModel viewModel,
  }) =>
      viewModel.busy(StateObjects.learnLessons)
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: CustomCircularProgressIndicator(color: kcPrimaryColor),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: viewModel.lessons.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => LearnLessonTile(
                index: index,
                first: first && index < 3,
                lesson: viewModel.lessons[index],
                moduleName: module.name,
                last: index == viewModel.lessons.length - 1,
                onPracticeTap: () async => await _onPractice(
                  index: index,
                  context: context,
                  viewModel: viewModel,
                  lesson: viewModel.lessons[index],
                ),
                onLessonTap: () async =>
                    await viewModel.navigateToLearnLessonDetail(
                  index: index,
                  module: module,
                  lesson: viewModel.lessons[index],
                  hasPractice: index != viewModel.lessons.length - 1,
                ),
              ),
            );

  Widget _buildSheet(LearnLessonViewModel viewModel) => FinishPracticeSheet(
        onTap: viewModel.pop,
        practice: PracticeReason.lesson,
      );
}
