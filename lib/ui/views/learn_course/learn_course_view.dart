import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_course.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/translations/locale_keys.g.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/finish_practice_sheet.dart';
import '../../widgets/learn_course_tile.dart';
import '../../widgets/plant_stage_visual.dart';
import 'learn_course_viewmodel.dart';

class LearnCourseView extends StackedView<LearnCourseViewModel> {
  final int id;
  final bool first;

  const LearnCourseView({Key? key, required this.id, required this.first})
      : super(key: key);

  Future<void> _onPractice(
      {required BuildContext context,
      required LearnCourse course,
      required LearnCourseViewModel viewModel}) async {
    if (viewModel.user?.learn ?? false) {
      if (course.access?.isCompleted ?? false) {
        await viewModel.navigateToLearnPractice(
            id: course.id ?? 0, level: course.name ?? '');
      } else {
        if (course.access?.isAccessible ?? false) {
          await _showSheet(
              context: context,
              viewModel: viewModel,
              practice: PracticeReason.course);
        } else {
          await _showSheet(
              context: context,
              viewModel: viewModel,
              practice: PracticeReason.course);
        }
      }
    } else {
      await viewModel.navigateToLearnPractice(
          id: course.id ?? 0, level: course.name ?? '');
    }
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required PracticeReason practice,
          required LearnCourseViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        backgroundColor: kcTransparent,
        builder: (_) => _buildSheet(viewModel: viewModel, practice: practice),
      );

  @override
  void onViewModelReady(LearnCourseViewModel viewModel) async {
    viewModel.setProgramId(id);
    await viewModel.getLearnCourses(id);
    super.onViewModelReady(viewModel);
  }

  @override
  LearnCourseViewModel viewModelBuilder(BuildContext context) =>
      LearnCourseViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnCourseViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required LearnCourseViewModel viewModel}) =>
      Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: _buildBody(context: context, viewModel: viewModel),
        ),
      );

  Widget _buildBody(
          {required BuildContext context,
          required LearnCourseViewModel viewModel}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pinned Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: _buildAppBar(viewModel),
          ),

          // Scrollable middle courses section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildCoursesSection(
                  context: context, viewModel: viewModel),
            ),
          ),

          // Pinned bottom motivation banner (consistently at bottom)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: _buildMotivationBanner(viewModel),
          ),
        ],
      );

  Widget _buildAppBar(LearnCourseViewModel viewModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Squircle Back Button with Purple Arrow
          GestureDetector(
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
          ),
          const SizedBox(width: 16),

          // Category Tag & Title Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  viewModel.getStageTitle(id),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppColors.magenta38,
                    letterSpacing: 0.4,
                    fontFamily: 'Aeonik',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  LocaleKeys.your_english_path.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.neutral14,
                    letterSpacing: -0.2,
                    fontFamily: 'Aeonik',
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _buildCoursesSection(
          {required BuildContext context,
          required LearnCourseViewModel viewModel}) =>
      viewModel.busy(StateObjects.learnCourses)
          ? _buildProgressIndicator()
          : _buildListView(context: context, viewModel: viewModel);

  Widget _buildProgressIndicator() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 60),
        child: Center(
          child: CustomCircularProgressIndicator(color: kcPrimaryColor),
        ),
      );

  Widget _buildListView(
          {required BuildContext context,
          required LearnCourseViewModel viewModel}) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.courses.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
          index: index,
          isLast: index == viewModel.courses.length - 1,
          course: viewModel.courses[index],
          onPracticeTap: () async => await _onPractice(
              context: context,
              viewModel: viewModel,
              course: viewModel.courses[index]),
          onViewTap: () async => await viewModel.navigateToLearnModule(
              first: first && index == 0, course: viewModel.courses[index]),
        ),
      );

  Widget _buildTile({
    required int index,
    required bool isLast,
    required LearnCourse course,
    required GestureTapCallback onViewTap,
    required GestureTapCallback onPracticeTap,
  }) =>
      LearnCourseTile(
        index: index,
        isLast: isLast,
        course: course,
        onViewTap: onViewTap,
        onPracticeTap: onPracticeTap,
      );

  Widget _buildMotivationBanner(LearnCourseViewModel viewModel) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.neutral84.withValues(alpha: 0.4),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral14.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            PlantStageVisual(
              stage: viewModel.getStageIndex(id),
              size: 44,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                viewModel.getMotivationMessage(id),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.neutral21,
                  height: 1.35,
                  fontFamily: 'Aeonik',
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildSheet(
          {required PracticeReason practice,
          required LearnCourseViewModel viewModel}) =>
      FinishPracticeSheet(
        practice: practice,
        onTap: viewModel.pop,
      );
}
