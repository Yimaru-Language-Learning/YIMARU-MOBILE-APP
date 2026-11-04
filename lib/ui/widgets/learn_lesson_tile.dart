import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yimaru_app/models/learn_lesson.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/lesson_illustration_resolver.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

const List<Color> _kPastelColors = [
  Color(0xFFFFF6D7), // warm yellow
  Color(0xFFE4F7EC), // soft mint
  Color(0xFFFFECE5), // soft peach
  Color(0xFFF3E8FF), // lavender
  Color(0xFFE5F4FF), // sky blue
  Color(0xFFFFF0F5), // rose
];

class LearnLessonTile extends StatefulWidget {
  final int index;
  final bool last;
  final bool first;
  final LearnLesson lesson;
  final String? moduleName;
  final GestureTapCallback? onLessonTap;
  final GestureTapCallback? onPracticeTap;

  const LearnLessonTile({
    super.key,
    required this.index,
    required this.last,
    required this.first,
    required this.lesson,
    this.moduleName,
    this.onLessonTap,
    this.onPracticeTap,
  });

  @override
  State<LearnLessonTile> createState() => _LearnLessonTileState();
}

class _LearnLessonTileState extends State<LearnLessonTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    final isCompleted = widget.lesson.access?.isCompleted ?? false;
    final isAccessible = widget.lesson.access?.isAccessible ?? false;
    // Default expanded if it's the active in-progress lesson
    _isExpanded = isAccessible && !isCompleted;
  }

  bool get _isCompleted =>
      widget.last && (widget.lesson.access?.isAccessible ?? false)
          ? true
          : (widget.lesson.access?.isCompleted ?? false);

  bool get _isAccessible =>
      widget.first || (widget.lesson.access?.isAccessible ?? false);

  Color get _pastelColor =>
      _kPastelColors[widget.index % _kPastelColors.length];

  String get _illustrationPath => LessonIllustrationResolver.resolve(
        lessonTitle: widget.lesson.title,
        index: widget.index,
        lessonThumbnail: widget.lesson.thumbnail,
        moduleName: widget.moduleName,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.neutral84.withValues(alpha: 0.6),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral14.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            if (_isAccessible) {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            } else {
              widget.onPracticeTap?.call();
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Main Row
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Squircle Thumbnail with Number Badge
                    _buildLeadingThumbnail(),
                    const SizedBox(width: 14),

                    // Title & In-Progress Badge
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.lesson.title ?? '',
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.neutral14,
                              fontFamily: 'Aeonik',
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (_isAccessible && !_isCompleted) ...[
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                LocaleKeys.in_progress.tr(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFD97706),
                                  fontFamily: 'Aeonik',
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Trailing Status Indicator
                    _buildTrailingStatus(),
                  ],
                ),
              ),

              // Expanded Action Section
              if (_isExpanded && _isAccessible) _buildExpandedContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingThumbnail() {
    return SizedBox(
      width: 58,
      height: 58,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Pastel Squircle with SVG Illustration
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: _pastelColor,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SvgPicture.asset(
                _illustrationPath,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Small White Number Squircle on Bottom-Left
          Positioned(
            left: -2,
            bottom: -2,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: kcWhite,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.neutral84.withValues(alpha: 0.6),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${widget.index + 1}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.neutral14,
                    fontFamily: 'Aeonik',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailingStatus() {
    if (_isCompleted) {
      return Container(
        width: 26,
        height: 26,
        decoration: const BoxDecoration(
          color: Color(0xFF22C55E),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.check_rounded,
            size: 16,
            color: kcWhite,
          ),
        ),
      );
    }

    if (_isAccessible) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.neutral93.withValues(alpha: 0.6),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            _isExpanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            color: AppColors.neutral40,
            size: 20,
          ),
        ),
      );
    }

    return const Icon(
      Icons.lock_outline_rounded,
      color: AppColors.neutral40,
      size: 20,
    );
  }

  Widget _buildExpandedContent() {
    final double progressPercent = _isCompleted
        ? 1.0
        : ((widget.lesson.access?.progressPercent ?? 0) / 100).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: AppColors.neutral84.withValues(alpha: 0.4),
            height: 1,
          ),
          const SizedBox(height: 12),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progressPercent,
              minHeight: 5,
              backgroundColor: AppColors.neutral93,
              valueColor: AlwaysStoppedAnimation<Color>(
                _isCompleted
                    ? const Color(0xFF22C55E)
                    : AppColors.magenta38,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Action Buttons: Practice and Start
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 44,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.practice.tr(),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.magenta38,
                            fontFamily: 'Aeonik',
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.mic_rounded,
                          size: 16,
                          color: AppColors.magenta38,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: widget.onLessonTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.magenta38,
                      foregroundColor: kcWhite,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.start.tr(),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: kcWhite,
                            fontFamily: 'Aeonik',
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.play_arrow_rounded,
                          size: 16,
                          color: kcWhite,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
