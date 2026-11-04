import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course_module.dart';
import 'package:yimaru_app/models/course_unit.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/course_module_tile_small.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';

import '../../models/course_catalog.dart';
import '../common/app_colors.dart';
import '../common/enmus.dart';
import '../common/ui_helpers.dart';
import '../views/course_unit/course_unit_viewmodel.dart';
import 'custom_circular_progress_indicator.dart';
import 'finish_practice_sheet.dart';

class CourseUnitTile extends ViewModelWidget<CourseUnitViewModel> {
  final int index;
  final bool first;
  final CourseUnit unit;
  final CourseCatalog catalog;
  final SubscriptionType type;
  final GestureTapCallback? onLessonTap;
  final GestureTapCallback? onPracticeTap;

  const CourseUnitTile({
    super.key,
    this.onLessonTap,
    this.onPracticeTap,
    required this.unit,
    required this.type,
    required this.index,
    required this.first,
    required this.catalog,
  });

  // ── Icon config per unit index ────────────────────────────────────────────
  static const List<_UnitStyle> _styles = [
    _UnitStyle(color: Color(0xFF58CC02), icon: Icons.flag_rounded),        // green  – flag
    _UnitStyle(color: Color(0xFF1CB0F6), icon: Icons.bar_chart_rounded),   // blue   – chart
    _UnitStyle(color: Color(0xFF9C27B0), icon: Icons.headphones_rounded),  // purple – listen
    _UnitStyle(color: Color(0xFFFF9600), icon: Icons.menu_book_rounded),   // orange – read
    _UnitStyle(color: Color(0xFFFF4B4B), icon: Icons.edit_rounded),        // red    – write
    _UnitStyle(color: Color(0xFFFFD700), icon: Icons.mic_rounded),         // yellow – speak
    _UnitStyle(color: Color(0xFF58CC02), icon: Icons.play_arrow_rounded),  // green  – demo
  ];

  static const List<_UnitStyle> _ieltsStyles = [
    _UnitStyle(color: Color(0xFFE4002B), icon: Icons.flag_rounded),
    _UnitStyle(color: Color(0xFF2B2A4A), icon: Icons.mic_rounded),
    _UnitStyle(color: Color(0xFFE4002B), icon: Icons.headphones_rounded),
    _UnitStyle(color: Color(0xFF2B2A4A), icon: Icons.menu_book_rounded),
    _UnitStyle(color: Color(0xFFE4002B), icon: Icons.edit_rounded),
    _UnitStyle(color: Color(0xFF2B2A4A), icon: Icons.fact_check_rounded),
  ];

  static const List<_UnitStyle> _professionalsStyles = [
    _UnitStyle(color: Color(0xFF8E2483), icon: Icons.search_rounded),
    _UnitStyle(color: Color(0xFFFF7A50), icon: Icons.work_rounded),
  ];

  bool get _isProfessionals =>
      (catalog.name ?? '').toLowerCase().contains('prof') ||
      (catalog.category ?? '').toLowerCase().contains('prof') ||
      type == SubscriptionType.learn;

  _UnitStyle get _style {
    if (_isProfessionals) {
      return _professionalsStyles[index % _professionalsStyles.length];
    }
    if (type == SubscriptionType.ielts) {
      return _ieltsStyles[index % _ieltsStyles.length];
    }
    return _styles[index % _styles.length];
  }

  // ── Fetch modules (unchanged logic) ──────────────────────────────────────
  Future<void> _getCourseModules({
    required bool expanded,
    required CourseUnitViewModel viewModel,
  }) async {
    if (!expanded) return;
    if ((unit.modules?.isNotEmpty ?? false)) return;
    await viewModel.getCourseModules(index: index, id: unit.id ?? 0);
  }

  @override
  Widget build(BuildContext context, CourseUnitViewModel viewModel) =>
      GestureDetector(
        onTap: !(unit.access?.isAccessible ?? false) ? onPracticeTap : null,
        child: _buildCard(context, viewModel),
      );

  // ── Card ──────────────────────────────────────────────────────────────────
  Widget _buildCard(BuildContext context, CourseUnitViewModel viewModel) =>
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
          clipBehavior: Clip.antiAlias,
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              childrenPadding: EdgeInsets.zero,
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              leading: _buildUnitIcon(),
              title: _buildTitleSection(),
              trailing: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xFFBBBBCC),
                size: 22,
              ),
              onExpansionChanged: (expanded) async => await _getCourseModules(
                  expanded: expanded, viewModel: viewModel),
              children: [
                const Divider(height: 1, color: Color(0xFFEEEEF5)),
                _buildExpandedContent(context, viewModel),
              ],
            ),
          ),
        ),
      );

  // ── Leading icon ──────────────────────────────────────────────────────────
  Widget _buildUnitIcon() => Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: _style.color,
          shape: BoxShape.circle,
        ),
        child: Icon(_style.icon, color: Colors.white, size: 22),
      );

  // ── Title + label + progress ──────────────────────────────────────────────
  Widget _buildTitleSection() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "UNIT X" label in the unit color
          Text(
            'UNIT ${index + 1}',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'Aeonik',
              color: _style.color,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            unit.name ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Aeonik',
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: CustomLinearProgressIndicator(
                  progress: 0,
                  activeColor: _style.color,
                  backgroundColor: const Color(0xFFE8E8F0),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                LocaleKeys.zero_percent_completed.tr(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Aeonik',
                  color: Color(0xFF888899),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
      );

  List<CourseModule> _getModules() {
    if (unit.modules != null && unit.modules!.isNotEmpty) {
      return unit.modules!;
    }
    if (_isProfessionals) {
      if (index == 0) {
        return const [
          CourseModule(id: 101, sortOrder: 1, name: 'እርስዎ የሚፈልጉትን ትክክለኛ ሥራ ማግኘት', lessonsCount: 1),
          CourseModule(id: 102, sortOrder: 2, name: 'የራስ ግምገማዎች እና የሥራ ማስታወቂያዎችን መረዳት', lessonsCount: 1),
          CourseModule(id: 103, sortOrder: 3, name: 'ሲቪ (CV) ወይም የሥራ ከንቲብ ማዘጋጀት', lessonsCount: 1),
          CourseModule(id: 104, sortOrder: 4, name: 'የሥራ ደብዳቤ (Cover Letter) እንዴት እንደሚጻፍ', lessonsCount: 1),
          CourseModule(id: 105, sortOrder: 5, name: 'ቃለ መጠይቅ (አለባበስ እና አመለካከት)', lessonsCount: 1),
          CourseModule(id: 106, sortOrder: 6, name: 'ስለ ራስዎ ማውራት (የግል መረጃ እና የክህሎቶች እና የብቃት ማጠቃለያ)', lessonsCount: 1),
        ];
      } else {
        return const [
          CourseModule(id: 107, sortOrder: 7, name: 'ስለ ራስዎ ማውራት (ጥንካሬዎች እና ድክመቶች)', lessonsCount: 1),
          CourseModule(id: 108, sortOrder: 8, name: 'ለምን እርስዎን ልንቀጥርዎ ይገባል እና ማንኛውም ጥያቄ አለዎት?', lessonsCount: 1),
          CourseModule(id: 109, sortOrder: 9, name: 'ደሞዝዎን እንዴት እንደሚደራደሩ', lessonsCount: 1),
          CourseModule(id: 110, sortOrder: 10, name: 'ከሥራ ባልደረቦችዎ ጋር በአካል መግባባት', lessonsCount: 1),
          CourseModule(id: 111, sortOrder: 11, name: 'ከአለቃዎ ጋር በአካል መግባባት', lessonsCount: 1),
          CourseModule(id: 112, sortOrder: 12, name: 'የበይነመረብ ግንኙነት (ስልክ፣ ኢሜይል እና ቪዲዮ ኮንፈረንስ)', lessonsCount: 1),
        ];
      }
    }
    return const [];
  }

  // ── Expanded: modules list ────────────────────────────────────────────────
  Widget _buildExpandedContent(
          BuildContext context, CourseUnitViewModel viewModel) {
    if (viewModel.busy(index)) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: CustomCircularProgressIndicator(color: kcPrimaryColor),
        ),
      );
    }
    final modules = _getModules();
    final bool showUnitPractice = type == SubscriptionType.duolingo &&
        ((unit.hasPractice ?? false) || index >= 1);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showUnitPractice)
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
            child: GestureDetector(
              onTap: onPracticeTap,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF86EFAC)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.assignment_turned_in_rounded,
                      color: Color(0xFF16A34A),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${LocaleKeys.view_practices.tr()} (Unit ${index + 1})',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Aeonik',
                        color: Color(0xFF16A34A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: modules.length,
          itemBuilder: (_, i) => CourseModuleTileSmall(
            module: modules[i],
            onTap: () async => await viewModel.navigateToCourseModule(
              first: first && i == 0,
              type: type,
              catalog: catalog,
              module: modules[i],
            ),
          ),
        ),
      ],
    );
  }
}

class _UnitStyle {
  final Color color;
  final IconData icon;
  const _UnitStyle({required this.color, required this.icon});
}
