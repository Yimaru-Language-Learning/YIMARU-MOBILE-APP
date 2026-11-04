import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class MotivationCard extends StatelessWidget {
  final String? customText;

  const MotivationCard({super.key, this.customText});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.neutral84.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral14.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF3E8FF),
              ),
              child: Center(
                child: ClipOval(
                  child: SvgPicture.asset(
                    'assets/images/mascot/yimi-official-master.svg',
                    width: 38,
                    height: 38,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            horizontalSpaceSmall,
            Expanded(
              child: Text(
                customText ?? LocaleKeys.keep_going.tr(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E1E36),
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      );
}
