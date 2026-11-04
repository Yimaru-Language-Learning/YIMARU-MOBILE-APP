import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/course_service.dart';
import 'package:yimaru_app/ui/widgets/course_module_tile_large.dart';

import '../../../models/course_catalog.dart';
import '../../../models/course_module.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/translations/locale_keys.g.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import 'course_module_viewmodel.dart';

class CourseModuleView extends StackedView<CourseModuleViewModel> {
  final bool first;
  final CourseModule? module;
  final CourseCatalog catalog;
  final SubscriptionType type;

  const CourseModuleView({
    Key? key,
    required this.type,
    required this.first,
    required this.module,
    required this.catalog,
  }) : super(key: key);

  @override
  void onViewModelReady(CourseModuleViewModel viewModel) async {
    await viewModel.getCourseLessons(module?.id ?? 0);
    super.onViewModelReady(viewModel);
  }

  @override
  CourseModuleViewModel viewModelBuilder(BuildContext context) =>
      CourseModuleViewModel();

  @override
  Widget builder(
    BuildContext context,
    CourseModuleViewModel viewModel,
    Widget? child,
  ) =>
      Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        body: SafeArea(child: _buildBody(context, viewModel)),
      );

  Widget _buildBody(BuildContext context, CourseModuleViewModel viewModel) =>
      Column(
        children: [
          _buildTopBar(viewModel),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page title
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                    child: Center(
                      child: Text(
                        catalog.name ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Aeonik',
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Content
                  _buildContentState(context, viewModel),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      );

  // ── Top bar ───────────────────────────────────────────────────────────────
  Widget _buildTopBar(CourseModuleViewModel viewModel) => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: viewModel.pop,
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFEEEEF0)),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  LocaleKeys.module_detail.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Aeonik',
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 38), // Balance back button
          ],
        ),
      );

  // ── Content state ─────────────────────────────────────────────────────────
  Widget _buildContentState(
      BuildContext context, CourseModuleViewModel viewModel) {
    // Resolve the unit's sortOrder from the in-memory list in CourseService.
    // This is a read-only lookup — no structural change to viewmodel/service.
    final courseService = locator<CourseService>();
    final unitSortOrder = courseService.units
            .where((u) => u.id == module?.unitId)
            .map((u) => u.sortOrder ?? 1)
            .firstOrNull ??
        1;

    return viewModel.busy(StateObjects.courseLessons)
        ? const Padding(
            padding: EdgeInsets.all(40),
            child: Center(
              child: CustomCircularProgressIndicator(color: kcPrimaryColor),
            ),
          )
        : CourseModuleTileLarge(
            type: type,
            catalog: catalog,
            first: first,
            module: module,
            lessons: viewModel.lessons,
            unitSortOrder: unitSortOrder,
          );
  }
}
