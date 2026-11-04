import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class NotificationIcon extends StatelessWidget {
  final String count;
  final GestureTapCallback? onTap;
  const NotificationIcon({super.key, this.onTap, required this.count});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: kcWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.neutral84.withValues(alpha: 0.6),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.neutral14.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.notifications_none_rounded,
                size: 24,
                color: AppColors.neutral14,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  decoration: const BoxDecoration(
                    color: AppColors.red50,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      count,
                      style: const TextStyle(
                        color: kcWhite,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Aeonik',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
