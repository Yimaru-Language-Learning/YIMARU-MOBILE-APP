import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course_catalog.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/course_unit_tile.dart';

import '../../../models/course_unit.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/finish_practice_sheet.dart';
import 'course_unit_viewmodel.dart';

class CourseUnitView extends StackedView<CourseUnitViewModel> {
  final CourseCatalog catalog;
  final SubscriptionType type;

  const CourseUnitView({Key? key, required this.type, required this.catalog})
      : super(key: key);

  // ── Theme helpers ─────────────────────────────────────────────────────────
  bool get _isProfessionals =>
      (catalog.name ?? '').toLowerCase().contains('prof') ||
      (catalog.category ?? '').toLowerCase().contains('prof') ||
      type == SubscriptionType.learn;

  bool get _isIelts => !_isProfessionals && type == SubscriptionType.ielts;

  Color get _heroColor {
    if (_isProfessionals) return const Color(0xFF8E2483);
    if (_isIelts) return const Color(0xFFE4002B);
    return const Color(0xFF58CC02);
  }

  String get _heroAsset {
    if (_isProfessionals) {
      return 'assets/images/09-english-for-professionals/9.1-english-for-professionals-course-01.svg';
    }
    if (_isIelts) {
      return 'assets/images/08-ielts/8.1-ielts-course-01.svg';
    }
    return 'assets/images/07-duolingo-english-test/7.1-det-course-01.svg';
  }

  List<CourseUnit> _getUnits(CourseUnitViewModel viewModel) {
    if (viewModel.units.isNotEmpty) return viewModel.units;
    if (_isProfessionals) {
      return const [
        CourseUnit(
          id: 1,
          sortOrder: 1,
          name: 'ሥራ ከማግኘትዎ በፊት | Before Getting a Job',
        ),
        CourseUnit(
          id: 2,
          sortOrder: 2,
          name: 'በሥራ ላይ | After Landing a Job',
        ),
      ];
    }
    return viewModel.units;
  }

  Future<void> _onPractice({
    required CourseUnit unit,
    required BuildContext context,
    required CourseUnitViewModel viewModel,
  }) async =>
      await viewModel.navigateToCoursePractice(id: unit.id ?? 0, type: type);

  Future<void> _showSheet({
    required BuildContext context,
    required PracticeReason practice,
    required CourseUnitViewModel viewModel,
  }) async =>
      await showModalBottomSheet(
        context: context,
        backgroundColor: kcTransparent,
        builder: (_) =>
            FinishPracticeSheet(practice: practice, onTap: viewModel.pop),
      );

  @override
  void onViewModelReady(CourseUnitViewModel viewModel) async {
    await viewModel.getCourseUnits(catalog.id ?? 0);
    super.onViewModelReady(viewModel);
  }

  @override
  CourseUnitViewModel viewModelBuilder(BuildContext context) =>
      CourseUnitViewModel();

  @override
  Widget builder(
    BuildContext context,
    CourseUnitViewModel viewModel,
    Widget? child,
  ) =>
      Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        body: SafeArea(child: _buildBody(context, viewModel)),
      );

  Widget _buildBody(BuildContext context, CourseUnitViewModel viewModel) =>
      Column(
        children: [
          _buildTopBar(viewModel),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),
                  Center(
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
                  const SizedBox(height: 12),
                  _buildHeroBanner(viewModel),
                  _buildProgressSection(),
                  if (type == SubscriptionType.duolingo)
                    _buildCourseMockExamSection(context, viewModel),
                  const SizedBox(height: 8),
                  _buildUnitListState(context, viewModel),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      );

  // ── Top bar ───────────────────────────────────────────────────────────────
  Widget _buildTopBar(CourseUnitViewModel viewModel) => Container(
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
                  LocaleKeys.course_detail.tr(),
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

  // ── Hero banner (color/illustration driven by course type) ───────────────
  Widget _buildHeroBanner(CourseUnitViewModel viewModel) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: _heroColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: _heroColor.withValues(alpha: 0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Illustration
              Positioned.fill(
                child: Center(
                  child: SvgPicture.asset(
                    _heroAsset,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // Units pill – bottom left
              Positioned(
                bottom: 12,
                left: 12,
                child: _buildUnitsPill(viewModel),
              ),
            ],
          ),
        ),
      );

  Widget _buildUnitsPill(CourseUnitViewModel viewModel) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          '${_getUnits(viewModel).length} UNITS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            fontFamily: 'Aeonik',
            color: _heroColor,
            letterSpacing: 0.5,
          ),
        ),
      );

  // ── Duolingo Course-level mock exam section ──────────────────────────────
  Widget _buildCourseMockExamSection(
          BuildContext context, CourseUnitViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEEEEF0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2F8DA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.assignment_rounded,
                    color: Color(0xFF58CC02),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.take_mock_exam.tr(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Aeonik',
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Duolingo English Test Mock Exam',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Aeonik',
                        color: Color(0xFF888899),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async => await viewModel.navigateToCoursePractice(
                  id: catalog.id ?? 0,
                  type: type,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF58CC02),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF46A302),
                        offset: Offset(0, 2),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Text(
                    LocaleKeys.start_assessment.tr(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Aeonik',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  // ── Overall progress section ──────────────────────────────────────────────
  Widget _buildProgressSection() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEEEEF0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.overall_progress.tr(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Aeonik',
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  Text(
                    '0%',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Aeonik',
                      color: _heroColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 0,
                  minHeight: 7,
                  backgroundColor: const Color(0xFFE8E8F0),
                  valueColor: AlwaysStoppedAnimation<Color>(_heroColor),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                LocaleKeys.choose_course_to_improve.tr(),
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
      );

  // ── Unit list ─────────────────────────────────────────────────────────────
  Widget _buildUnitListState(
          BuildContext context, CourseUnitViewModel viewModel) =>
      viewModel.busy(StateObjects.courseUnits)
          ? const Padding(
              padding: EdgeInsets.all(40),
              child: Center(
                  child: CustomCircularProgressIndicator(
                      color: kcPrimaryColor)),
            )
          : _buildUnitList(context, viewModel);

  Widget _buildUnitList(BuildContext context, CourseUnitViewModel viewModel) {
    final units = _getUnits(viewModel);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: units.length,
      itemBuilder: (_, index) => CourseUnitTile(
        index: index,
        first: index == 0,
        type: type,
        catalog: catalog,
        unit: units[index],
        onLessonTap: () {},
        onPracticeTap: () async => await _onPractice(
          context: context,
          viewModel: viewModel,
          unit: units[index],
        ),
      ),
    );
  }
}
