import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class OnboardingOptionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isStacked;

  const OnboardingOptionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    required this.isSelected,
    required this.onTap,
    this.isStacked = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFAF0F8) : const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.magenta38
                : AppColors.neutral84.withValues(alpha: 0.65),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: isStacked
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (leading != null) leading!,
                      _buildCheckCircle(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: isSelected ? AppColors.magenta38 : AppColors.neutral14,
                      fontFamily: 'Aeonik',
                      letterSpacing: -0.1,
                    ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: isSelected
                            ? AppColors.magenta38.withValues(alpha: 0.8)
                            : AppColors.neutral40,
                        fontFamily: 'Aeonik',
                        height: 1.3,
                      ),
                    ),
                  ],
                ],
              )
            : Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: 14),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected ? AppColors.magenta38 : AppColors.neutral14,
                            fontFamily: 'Aeonik',
                            letterSpacing: -0.1,
                          ),
                        ),
                        if (subtitle != null && subtitle!.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(
                            subtitle!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: isSelected
                                  ? AppColors.magenta38.withValues(alpha: 0.8)
                                  : AppColors.neutral40,
                              fontFamily: 'Aeonik',
                              height: 1.3,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildCheckCircle(),
                ],
              ),
      ),
    );
  }

  Widget _buildCheckCircle() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.magenta38 : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? AppColors.magenta38
              : AppColors.neutral84.withValues(alpha: 0.9),
          width: 1.5,
        ),
      ),
      child: isSelected
          ? const Center(
              child: Icon(
                Icons.check_rounded,
                size: 14,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
