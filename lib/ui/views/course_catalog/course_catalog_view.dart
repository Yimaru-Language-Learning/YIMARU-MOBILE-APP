import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course_catalog.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/course_catalog_tile.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/finish_practice_sheet.dart';
import 'course_catalog_viewmodel.dart';

class CourseCatalogView extends StackedView<CourseCatalogViewModel> {
  const CourseCatalogView({Key? key}) : super(key: key);

  Future<void> _onPractice({
    required BuildContext context,
    required CourseCatalog course,
    required CourseCatalogViewModel viewModel,
  }) async {
    await viewModel.navigateToCoursePractice(
        id: course.id ?? 0,
        type: course.category == 'IELTS'
            ? SubscriptionType.ielts
            : SubscriptionType.duolingo);
  }

  Future<void> _showSheet({
    required BuildContext context,
    required PracticeReason practice,
    required CourseCatalogViewModel viewModel,
  }) async =>
      await showModalBottomSheet(
        context: context,
        backgroundColor: kcTransparent,
        builder: (_) =>
            FinishPracticeSheet(practice: practice, onTap: viewModel.pop),
      );

  @override
  void onViewModelReady(CourseCatalogViewModel viewModel) async {
    await viewModel.getCourseCatalogs();
    super.onViewModelReady(viewModel);
  }

  @override
  CourseCatalogViewModel viewModelBuilder(BuildContext context) =>
      CourseCatalogViewModel();

  @override
  Widget builder(
    BuildContext context,
    CourseCatalogViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffold(context, viewModel);

  Widget _buildScaffold(
          BuildContext context, CourseCatalogViewModel viewModel) =>
      Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(child: _buildBody(context, viewModel)),
      );

  Widget _buildBody(BuildContext context, CourseCatalogViewModel viewModel) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBar(viewModel),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildTitle(),
                  const SizedBox(height: 6),
                  _buildSubtitle(),
                  const SizedBox(height: 24),
                  _buildListState(context, viewModel),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      );

  // ── Top bar ───────────────────────────────────────────────────────────────
  Widget _buildTopBar(CourseCatalogViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(left: 16, top: 12, bottom: 4),
        child: Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: viewModel.pop,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEEEEF0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 20,
                color: Color(0xFF9A288D),
              ),
            ),
          ),
        ),
      );

  Widget _buildTitle() => Text(
        LocaleKeys.english_proficiency.tr(),
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          fontFamily: 'Aeonik',
          color: Color(0xFF1E132D),
        ),
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.select_your_target_exam.tr(),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          fontFamily: 'Aeonik',
          color: Color(0xFF888899),
        ),
      );

  // ── List ──────────────────────────────────────────────────────────────────
  Widget _buildListState(
          BuildContext context, CourseCatalogViewModel viewModel) =>
      viewModel.busy(StateObjects.courseCatalogs)
          ? const Center(
              child: CustomCircularProgressIndicator(color: kcPrimaryColor),
            )
          : _buildList(context, viewModel);

  Widget _buildList(BuildContext context, CourseCatalogViewModel viewModel) {
    final catalogs = List<CourseCatalog>.from(viewModel.catalogs);
    final hasProfessionals = catalogs.any((c) =>
        (c.name ?? '').toLowerCase().contains('prof') ||
        (c.category ?? '').toLowerCase().contains('prof'));

    if (!hasProfessionals) {
      catalogs.add(const CourseCatalog(
        id: 0,
        name: 'English For Professionals',
        category: 'PROFESSIONAL',
      ));
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: catalogs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        final catalog = catalogs[index];
        return CourseCatalogTile(
          catalog: catalog,
          onCourseTap: () async {
            if (catalog.id == null) return;
            final isProf = (catalog.name ?? '').toLowerCase().contains('prof') ||
                (catalog.category ?? '').toLowerCase().contains('prof');
            await viewModel.navigateToCourseUnit(
              catalog: catalog,
              type: catalog.category == 'IELTS'
                  ? SubscriptionType.ielts
                  : (isProf ? SubscriptionType.learn : SubscriptionType.duolingo),
            );
          },
          onPracticeTap: () async {
            if (catalog.id == null) return;
            final isProf = (catalog.name ?? '').toLowerCase().contains('prof') ||
                (catalog.category ?? '').toLowerCase().contains('prof');
            if (isProf) {
              await viewModel.navigateToCourseUnit(
                catalog: catalog,
                type: SubscriptionType.learn,
              );
              return;
            }
            await _onPractice(
              context: context,
              viewModel: viewModel,
              course: catalog,
            );
          },
        );
      },
    );
  }
}
