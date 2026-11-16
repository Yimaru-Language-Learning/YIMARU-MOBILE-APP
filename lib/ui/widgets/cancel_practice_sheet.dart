import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/speaking_partner_image.dart';

class CancelPracticeSheet extends StatelessWidget {
  final String user;
  final GestureTapCallback? onClose;
  final GestureTapCallback? onCancel;
  final GestureTapCallback? onContinue;

  const CancelPracticeSheet({
    super.key,
    this.onClose,
    this.onCancel,
    this.onContinue,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = user.trim().isNotEmpty ? user.trim() : 'there';

    return Container(
      decoration: const BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Close button on top right
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onClose ?? onContinue,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  size: 20,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Partner avatar
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF5EEF7),
            ),
            child: const SpeakingPartnerImage(radius: 38),
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            LocaleKeys.almost_there_user.tr(args: [displayName]),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Aeonik',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2A1830),
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              LocaleKeys.finish_session.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Aeonik',
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Primary Button: Continue practice
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.magenta38,
                foregroundColor: kcWhite,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                LocaleKeys.continue_practice.tr(),
                style: const TextStyle(
                  fontFamily: 'Aeonik',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: kcWhite,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Secondary Button: End session
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                backgroundColor: kcWhite,
                foregroundColor: AppColors.magenta38,
                side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                LocaleKeys.end_session.tr(),
                style: const TextStyle(
                  fontFamily: 'Aeonik',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.magenta38,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
