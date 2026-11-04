import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/models/learn_course.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

class LearnCourseTile extends StatefulWidget {
  final int index;
  final bool isLast;
  final LearnCourse course;
  final GestureTapCallback? onViewTap;
  final GestureTapCallback? onPracticeTap;

  const LearnCourseTile({
    super.key,
    this.index = 0,
    this.isLast = false,
    this.onViewTap,
    this.onPracticeTap,
    required this.course,
  });

  @override
  State<LearnCourseTile> createState() => _LearnCourseTileState();
}

class _LearnCourseTileState extends State<LearnCourseTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    // Expand the first item by default or if accessible
    _isExpanded = widget.index == 0 || (widget.course.access?.isAccessible ?? false);
  }

  // Derive level code ("A1", "A2", "B1", etc.)
  String get _levelCode {
    final name = widget.course.name?.toUpperCase() ?? '';
    if (name.contains('A1')) return 'A1';
    if (name.contains('A2')) return 'A2';
    if (name.contains('B1')) return 'B1';
    if (name.contains('B2')) return 'B2';
    if (name.contains('C1')) return 'C1';
    if (name.contains('C2')) return 'C2';
    return widget.index == 0 ? 'A1' : 'A2';
  }

  // Derive level subtitle ("STARTER", "ELEMENTARY", etc.)
  String get _levelSubtitle {
    final code = _levelCode;
    switch (code) {
      case 'A1':
        return LocaleKeys.starter.tr();
      case 'A2':
        return LocaleKeys.elementary.tr();
      case 'B1':
        return LocaleKeys.intermediate.tr();
      case 'B2':
        return LocaleKeys.upper_intermediate.tr();
      case 'C1':
        return LocaleKeys.advanced.tr();
      case 'C2':
        return LocaleKeys.proficiency.tr();
      default:
        return code;
    }
  }

  // Card background pastel colors
  Color get _cardBgColor {
    return widget.index == 0
        ? const Color(0xFFFFF6D7) // Warm pastel yellow (A1)
        : const Color(0xFFE4F7EC); // Soft mint green (A2)
  }

  Color get _cardBorderColor {
    return widget.index == 0
        ? const Color(0xFFFFE8A3)
        : const Color(0xFFBCECD1);
  }

  // Left squircle badge background color
  Color get _badgeBgColor {
    return widget.index == 0
        ? const Color(0xFFFFD23F) // Gold/Yellow (A1)
        : const Color(0xFF7AD9A8); // Mint green (A2)
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCard(),
        if (!widget.isLast) _buildDottedPath(),
      ],
    );
  }

  Widget _buildCard() {
    return Container(
      decoration: BoxDecoration(
        color: _cardBgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _cardBorderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral14.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderRow(),
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: _buildExpandedSection(),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 240),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    final defaultDesc = widget.index == 0
        ? 'Start your journey with the basics of English'
        : 'Build upon your foundational knowledge.';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Level Squircle Badge
        Container(
          width: 66,
          height: 66,
          decoration: BoxDecoration(
            color: _badgeBgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: _badgeBgColor.withValues(alpha: 0.4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _levelCode,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.neutral14,
                  fontFamily: 'Aeonik',
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _levelSubtitle,
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  color: AppColors.neutral14,
                  fontFamily: 'Aeonik',
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),

        // Description text
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.course.description ?? defaultDesc,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.neutral21,
                height: 1.35,
                fontFamily: 'Aeonik',
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Trailing expand/collapse chevron squircle button
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: kcWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.neutral84.withValues(alpha: 0.4),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.neutral14.withValues(alpha: 0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            _isExpanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            color: AppColors.neutral14,
            size: 22,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        // English Scale Container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: kcWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.neutral84.withValues(alpha: 0.4),
              width: 0.8,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.where_level_sits_scale.tr(args: [_levelCode]),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.neutral40,
                  fontFamily: 'Aeonik',
                ),
              ),
              const SizedBox(height: 10),

              // Chips Row: A1, A2, B1, B2, C1, C2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'].map((chip) {
                  final isCurrent = chip == _levelCode;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? AppColors.magenta38
                          : AppColors.neutral93,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      chip,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isCurrent
                            ? FontWeight.w800
                            : FontWeight.w600,
                        color: isCurrent ? kcWhite : AppColors.neutral40,
                        fontFamily: 'Aeonik',
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // Dual CTA Buttons: "View course" and "Take practice"
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: widget.onViewTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.magenta38,
                    foregroundColor: kcWhite,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    LocaleKeys.view_course.tr(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: kcWhite,
                      fontFamily: 'Aeonik',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: widget.onPracticeTap,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: kcWhite,
                    foregroundColor: AppColors.magenta38,
                    side: const BorderSide(
                      color: AppColors.magenta38,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    LocaleKeys.take_practice.tr(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.magenta38,
                      fontFamily: 'Aeonik',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDottedPath() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: List.generate(
          4,
          (index) => Container(
            width: 3.5,
            height: 3.5,
            margin: const EdgeInsets.symmetric(vertical: 2.5),
            decoration: BoxDecoration(
              color: AppColors.neutral84.withValues(alpha: 0.7),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
