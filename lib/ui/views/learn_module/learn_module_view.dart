import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_module.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/learn_module_tile.dart';

import '../../../models/learn_course.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/custom_linear_progress_indicator.dart';
import '../../widgets/finish_practice_sheet.dart';
import 'learn_module_viewmodel.dart';

class LearnModuleView extends StackedView<LearnModuleViewModel> {
  final bool first;
  final LearnCourse course;

  const LearnModuleView({Key? key, required this.first, required this.course})
      : super(key: key);

  // ── Business Logic ──────────────────────────────────────────────────────────

  Future<void> _onPractice({
    required BuildContext context,
    required LearnModule module,
    required LearnModuleViewModel viewModel,
  }) async {
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

  Future<void> _showSheet({
    required BuildContext context,
    required PracticeReason practice,
    required LearnModuleViewModel viewModel,
  }) async =>
      await showModalBottomSheet(
        context: context,
        backgroundColor: kcTransparent,
        builder: (_) => _buildSheet(viewModel: viewModel, practice: practice),
      );

  // ── Stacked overrides ───────────────────────────────────────────────────────

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
      _buildScaffold(context: context, viewModel: viewModel);

  // ── Scaffold ────────────────────────────────────────────────────────────────

  Widget _buildScaffold({
    required BuildContext context,
    required LearnModuleViewModel viewModel,
  }) =>
      Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: _buildBody(context: context, viewModel: viewModel),
        ),
      );

  Widget _buildBody({
    required BuildContext context,
    required LearnModuleViewModel viewModel,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(viewModel),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceMedium,
                  _buildOverallProgressCard(viewModel),
                  verticalSpaceMedium,
                  _buildModulesHeader(),
                  verticalSpaceSmall,
                  _buildListViewBuilder(context: context, viewModel: viewModel),
                  verticalSpaceMedium,
                ],
              ),
            ),
          ),
        ],
      );

  // ── App Bar ─────────────────────────────────────────────────────────────────

  Widget _buildAppBar(LearnModuleViewModel viewModel) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Row(
          children: [
            // Squircle back button — consistent with LearnCourseView
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
            horizontalSpaceSmall,
            _buildLevelChip(),
            horizontalSpaceSmall,
            Text(
              LocaleKeys.your_current_level.tr(),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.neutral40,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  // Amber/yellow chip — matches the Figma design colour
  Widget _buildLevelChip() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFFC200),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          course.name?.split(' ').first.toUpperCase() ?? 'A1',
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF3D2800),
            fontWeight: FontWeight.w800,
          ),
        ),
      );

  // ── Overall Progress Card ───────────────────────────────────────────────────

  Widget _buildOverallProgressCard(LearnModuleViewModel viewModel) {
    final updatedCourse =
        viewModel.getUpdatedLearnCourse(course.id ?? 0) ?? course;
    final progress = updatedCourse.access?.progressPercent ?? 0;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF8E2483), // magenta35
            Color(0xFF5E1557), // magenta23
          ],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 6),
            color: const Color(0xFF9E2891).withValues(alpha: 0.30),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative background circles
          Positioned(
            right: -28,
            top: -28,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            right: 36,
            bottom: -20,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 16, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildProgressInfo(progress)),
                _buildMascot(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressInfo(int progress) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                LocaleKeys.overall_progress.tr(),
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              horizontalSpaceSmall,
              Text(
                '$progress%',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFFFD23F),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          verticalSpaceTiny,
          verticalSpaceTiny,
          CustomLinearProgressIndicator(
            progress: progress / 100,
            activeColor: const Color(0xFFFFD23F),
            backgroundColor: Colors.white.withValues(alpha: 0.25),
          ),
          verticalSpaceSmall,
          Text(
            LocaleKeys.keep_up_the_great_work.tr(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.80),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );

  Widget _buildMascot() => SvgPicture.asset(
        'assets/images/mascot/yimi-official-master.svg',
        width: 85,
        height: 85,
      );

  // ── Modules Header ──────────────────────────────────────────────────────────

  Widget _buildModulesHeader() => const Text(
        'Modules',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Color(0xFF1A1B1E),
        ),
      );

  // ── Module List ─────────────────────────────────────────────────────────────

  Widget _buildListViewBuilder({
    required BuildContext context,
    required LearnModuleViewModel viewModel,
  }) =>
      viewModel.busy(StateObjects.learnModules)
          ? _buildProgressIndicator()
          : _buildListView(context: context, viewModel: viewModel);

  Widget _buildProgressIndicator() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: CustomCircularProgressIndicator(color: kcPrimaryColor),
        ),
      );

  Widget _buildListView({
    required BuildContext context,
    required LearnModuleViewModel viewModel,
  }) =>
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.modules.length,
        itemBuilder: (context, index) => _buildTile(
          module: viewModel.modules[index],
          courseLevel: course.name,
          onPracticeTap: () async => await _onPractice(
            context: context,
            viewModel: viewModel,
            module: viewModel.modules[index],
          ),
          onModuleTap: () async => await viewModel.navigateToLearnLesson(
            first: first && index == 0,
            module: viewModel.modules[index],
          ),
        ),
      );

  Widget _buildTile({
    required LearnModule module,
    required GestureTapCallback onModuleTap,
    required GestureTapCallback onPracticeTap,
    String? courseLevel,
  }) =>
      LearnModuleTile(
        module: module,
        courseLevel: courseLevel,
        onModuleTap: onModuleTap,
        onPracticeTap: onPracticeTap,
      );

  // ── Bottom Sheet ────────────────────────────────────────────────────────────

  Widget _buildSheet({
    required PracticeReason practice,
    required LearnModuleViewModel viewModel,
  }) =>
      FinishPracticeSheet(
        practice: practice,
        onTap: viewModel.pop,
      );
}
