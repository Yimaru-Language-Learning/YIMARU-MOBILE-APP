import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_module.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_module/learn_module_viewmodel.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

// Pastel palette for module icon backgrounds (cycles through modules).
const List<Color> _kModulePastels = [
  Color(0xFFFFF6D7), // warm yellow
  Color(0xFFE4F7EC), // mint green
  Color(0xFFFFECE5), // soft peach
  Color(0xFFEDE8FF), // lavender
  Color(0xFFE5F4FF), // sky blue
];

// Local-asset fallback icons for modules whose `icon` URL is missing/empty.
const List<String> _kFallbackAssets = [
  'assets/images/module_travel.jpg',
  'assets/images/module_health.jpg',
];

class LearnModuleTile extends StatefulWidget {
  final LearnModule module;
  final GestureTapCallback? onModuleTap;
  final GestureTapCallback? onPracticeTap;
  final String? illustrationAsset;
  final String? courseLevel;

  const LearnModuleTile({
    super.key,
    this.onModuleTap,
    this.onPracticeTap,
    this.illustrationAsset,
    this.courseLevel,
    required this.module,
  });

  @override
  State<LearnModuleTile> createState() => _LearnModuleTileState();
}

class _LearnModuleTileState extends State<LearnModuleTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.module.access?.isAccessible ?? false;
  }

  // ── Main build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final viewModel = getParentViewModel<LearnModuleViewModel>(context, listen: false);
    final index = viewModel.modules.indexOf(widget.module);
    final pastel = _kModulePastels[(index >= 0 ? index : 0) % _kModulePastels.length];
    final isAccessible = widget.module.access?.isAccessible ?? false;

    return GestureDetector(
      onTap: !isAccessible ? widget.onPracticeTap : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 3),
              color: const Color(0xFF9E2891).withValues(alpha: 0.07),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            key: PageStorageKey(widget.module.id),
            initiallyExpanded: isAccessible,
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            tilePadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            childrenPadding:
                const EdgeInsets.fromLTRB(14, 0, 14, 14),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            shape: const Border(),
            collapsedShape: const Border(),
            backgroundColor: Colors.transparent,
            collapsedBackgroundColor: Colors.transparent,
            leading: _buildIconBox(pastel, index >= 0 ? index : 0),
            title: _buildTitle(),
            subtitle: _buildSubtitle(),
            trailing: _buildTrailing(isAccessible),
            children: [
              _buildExpandedContent(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Icon box ────────────────────────────────────────────────────────────────

  Widget _buildIconBox(Color pastel, int index) {
    final isCompleted = widget.module.access?.isCompleted ?? false;
    final sortIndex = (widget.module.sortOrder != null && widget.module.sortOrder! > 0)
        ? widget.module.sortOrder! - 1
        : index;
    final illustration = widget.illustrationAsset ??
        _resolveIllustration(widget.courseLevel, sortIndex);

    return SizedBox(
      width: 54,
      height: 54,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: pastel,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: illustration != null && illustration.endsWith('.svg')
                    ? SvgPicture.asset(
                        illustration,
                        width: 38,
                        height: 38,
                        fit: BoxFit.contain,
                      )
                    : ((widget.module.icon ?? '').isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: widget.module.icon!,
                            width: 52,
                            height: 52,
                            fit: BoxFit.cover,
                            errorWidget: (_, __, ___) => _fallbackImage(index),
                          )
                        : _fallbackImage(index)),
              ),
            ),
          ),
          if (isCompleted)
            Positioned(
              bottom: -2,
              right: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Center(
                  child: Icon(Icons.check, size: 10, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String? _resolveIllustration(String? courseLevel, int index) {
    final level = (courseLevel ?? '').toLowerCase().trim();
    String prefix = 'a2';
    int maxCount = 6;

    if (level.contains('b1') || level.contains('pre-intermediate') || (level.contains('intermediate') && !level.contains('upper'))) {
      prefix = 'b1';
      maxCount = 7;
    } else if (level.contains('b2') || level.contains('upper')) {
      prefix = 'b2';
      maxCount = 7;
    } else if (level.contains('c1') || level.contains('advanced')) {
      prefix = 'c1';
      maxCount = 7;
    } else if (level.contains('c2') || level.contains('profic') || level.contains('master')) {
      prefix = 'c2';
      maxCount = 7;
    } else if (level.contains('a2') || level.contains('elementary')) {
      prefix = 'a2';
      maxCount = 6;
    } else {
      prefix = 'a2';
      maxCount = 6;
    }

    final num = (index % maxCount) + 1;
    return 'assets/images/illustrations/${prefix}_$num.svg';
  }

  Widget _fallbackImage(int index) {
    final assetPath = _kFallbackAssets[index % _kFallbackAssets.length];
    return Image.asset(
      assetPath,
      width: 52,
      height: 52,
      fit: BoxFit.cover,
    );
  }

  // ── Tile header ─────────────────────────────────────────────────────────────

  Widget _buildTitle() => Text(
        widget.module.name ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1A1B1E),
        ),
      );

  Widget _buildSubtitle() => Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          widget.module.description ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6B5A70),
          ),
        ),
      );

  Widget _buildTrailing(bool isAccessible) {
    if (_isExpanded) {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFFF3E8FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.keyboard_arrow_up_rounded,
          color: AppColors.magenta38,
          size: 20,
        ),
      );
    }

    return const Icon(
      Icons.keyboard_arrow_down_rounded,
      color: Color(0xFF6B5A70),
      size: 24,
    );
  }

  // ── Expanded content ────────────────────────────────────────────────────────

  Widget _buildExpandedContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProgressRow(),
          verticalSpaceSmall,
          _buildActionButtons(),
        ],
      );

  Widget _buildProgressRow() {
    final completed = widget.module.access?.completedCount ?? 0;
    final total = widget.module.access?.totalCount ?? 0;
    final percent = (widget.module.access?.progressPercent ?? 0) / 100;
    final isCompleted = widget.module.access?.isCompleted ?? false;

    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: AlwaysStoppedAnimation<Color>(
                isCompleted ? const Color(0xFF22C55E) : AppColors.magenta38,
              ),
              minHeight: 6,
            ),
          ),
        ),
        horizontalSpaceSmall,
        Text(
          '$completed/$total lessons',
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6B5A70),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() => SizedBox(
        height: 44,
        child: Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                height: 15,
                borderRadius: 14,
                onTap: widget.onModuleTap,
                foregroundColor: Colors.white,
                backgroundColor: AppColors.magenta38,
                text: LocaleKeys.view_module.tr(),
              ),
            ),
            horizontalSpaceSmall,
            Expanded(
              child: CustomElevatedButton(
                height: 15,
                borderRadius: 14,
                onTap: widget.onPracticeTap,
                backgroundColor: Colors.white,
                borderColor: AppColors.magenta38,
                foregroundColor: AppColors.magenta38,
                text: LocaleKeys.take_practice.tr(),
              ),
            ),
          ],
        ),
      );
}
