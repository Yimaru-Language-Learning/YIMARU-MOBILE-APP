import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class PracticeAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onPop;
  final double? progress;
  final Widget? trailing;

  const PracticeAppBar({
    super.key,
    required this.title,
    this.onPop,
    this.progress,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              if (onPop != null)
                GestureDetector(
                  onTap: onPop,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: kcWhite,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      size: 20,
                      color: Color(0xFF2A1830),
                    ),
                  ),
                )
              else
                const SizedBox(width: 40, height: 40),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Aeonik',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.magenta38, // #6E1665
                  ),
                ),
              ),
              if (trailing != null)
                trailing!
              else
                const SizedBox(width: 40, height: 40),
            ],
          ),
        ),
        if (progress != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress!.clamp(0.0, 1.0),
                minHeight: 5,
                backgroundColor: const Color(0xFFF3E8F5),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.magenta38,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

