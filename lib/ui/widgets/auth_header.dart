import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class AuthHeader extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBack;
  final VoidCallback? onLanguage;
  final String? languageCode;
  final String? speechTitle;
  final String? speechSubtitle;
  final String mascotAsset;
  final Widget? customIllustration;
  final String? toastMessage;
  final double height;

  const AuthHeader({
    super.key,
    this.showBackButton = false,
    this.onBack,
    this.onLanguage,
    this.languageCode,
    this.speechTitle,
    this.speechSubtitle,
    this.mascotAsset = 'assets/images/mascot/yimi-hello.svg',
    this.customIllustration,
    this.toastMessage,
    this.height = 210,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF8E2483),
            Color(0xFF6E1665),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Sparkles
          Positioned(
            top: 36,
            left: 70,
            child: _buildSparkle(size: 14),
          ),
          Positioned(
            top: 75,
            left: 45,
            child: _buildSparkle(size: 8),
          ),
          Positioned(
            top: 32,
            right: 110,
            child: _buildSparkle(size: 12),
          ),
          Positioned(
            top: 85,
            right: 40,
            child: _buildSparkle(size: 10),
          ),

          // Safe Area Top Controls (Back Button & Language)
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (showBackButton)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onBack,
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 38),

                  // Optional Top Toast Banner (e.g. "Code sent successfully")
                  if (toastMessage != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFF22C55E),
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            toastMessage!,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.neutral14,
                              fontFamily: 'Aeonik',
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Language selector pill
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onLanguage,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.language_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            languageCode == 'am' ? 'አማ' : 'en',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: 'Aeonik',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Illustration & Speech Bubble Layer
          Positioned(
            left: 18,
            right: 18,
            bottom: 0,
            child: customIllustration ?? _buildMascotWithSpeech(),
          ),
        ],
      ),
    );
  }

  Widget _buildSparkle({required double size}) {
    return Icon(
      Icons.star_rounded,
      size: size,
      color: const Color(0xFFFFDF5D).withValues(alpha: 0.85),
    );
  }

  Widget _buildMascotWithSpeech() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Speech Bubble
        if (speechTitle != null || speechSubtitle != null)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 22, right: 6),
              child: _buildSpeechBubble(),
            ),
          )
        else
          const Spacer(),

        // Mascot Yimi peeking out
        SizedBox(
          width: 110,
          height: 110,
          child: SvgPicture.asset(
            mascotAsset,
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),
      ],
    );
  }

  Widget _buildSpeechBubble() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (speechTitle != null && speechTitle!.isNotEmpty)
            Text(
              speechTitle!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: AppColors.neutral14,
                fontFamily: 'Aeonik',
                height: 1.25,
              ),
            ),
          if (speechSubtitle != null && speechSubtitle!.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              speechSubtitle!,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.neutral40,
                fontFamily: 'Aeonik',
                height: 1.2,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

