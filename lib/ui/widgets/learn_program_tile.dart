import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/models/learn_program.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/plant_stage_visual.dart';

class LearnProgramTile extends StatefulWidget {
  final int index;
  final LearnProgram program;
  final GestureTapCallback? onTap;

  const LearnProgramTile({
    super.key,
    this.index = 0,
    this.onTap,
    required this.program,
  });

  @override
  State<LearnProgramTile> createState() => _LearnProgramTileState();
}

class _LearnProgramTileState extends State<LearnProgramTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    // Expand the first item by default or if accessible
    _isExpanded = widget.index == 0 || (widget.program.access?.isAccessible ?? false);
  }

  Color get _backgroundColor {
    switch (widget.index % 3) {
      case 0:
        return const Color(0xFFFFF6D7); // Soft warm pastel yellow
      case 1:
        return const Color(0xFFE4F7EC); // Soft pastel mint green
      default:
        return const Color(0xFFFFECE5); // Soft pastel peach
    }
  }

  Color get _borderColor {
    switch (widget.index % 3) {
      case 0:
        return const Color(0xFFFFE8A3);
      case 1:
        return const Color(0xFFBCECD1);
      default:
        return const Color(0xFFFFD4C4);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isInProgress = widget.program.access?.isAccessible ?? (widget.index == 0);
    final bool isCompleted = widget.program.access?.isCompleted ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _borderColor.withValues(alpha: 0.8),
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Content (Left) + Plant Graphic (Right)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Level Title
                          Text(
                            widget.program.name ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.neutral14,
                              fontFamily: 'Aeonik',
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // In Progress / Completed Badge
                          if (isInProgress) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.magenta38.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
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
                                    isCompleted
                                        ? LocaleKeys.completed.tr()
                                        : LocaleKeys.in_progress.tr(),
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
                            const SizedBox(height: 8),
                          ],

                          // Description
                          Text(
                            widget.program.description ?? '',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
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

                    // Plant Visual + Chevron Column
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PlantStageVisual(
                          stage: widget.index % 3,
                          size: 72,
                        ),
                        if (widget.index != 0) ...[
                          const SizedBox(height: 6),
                          Icon(
                            _isExpanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            color: AppColors.neutral40,
                            size: 24,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),

                // Expanded Section: "Start Learning →" Button
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: widget.onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.magenta35,
                          foregroundColor: kcWhite,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (widget.program.access?.progressPercent == 0 ||
                                      widget.program.access == null)
                                  ? LocaleKeys.start_learning.tr()
                                  : LocaleKeys.continue_learning.tr(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: kcWhite,
                                fontFamily: 'Aeonik',
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: kcWhite,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
}
