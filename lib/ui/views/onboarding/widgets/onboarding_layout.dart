import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class OnboardingLayout extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBack;
  final VoidCallback? onLanguage;
  final String? languageCode;
  final String title;
  final String? subtitle;
  final Widget? headerExtra;
  final Widget child;
  final String mascotAsset;
  final String speechText;
  final String continueText;
  final bool canContinue;
  final VoidCallback? onContinue;
  final bool scrollable;

  const OnboardingLayout({
    super.key,
    this.showBackButton = true,
    this.onBack,
    this.onLanguage,
    this.languageCode,
    this.title = '',
    this.subtitle,
    this.headerExtra,
    required this.child,
    this.mascotAsset = 'assets/images/mascot/yimi-hello.svg',
    required this.speechText,
    this.continueText = 'Continue',
    this.canContinue = true,
    this.onContinue,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6E1665),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top App Bar
            _buildTopBar(),

            // Main White Sheet
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    // Scrollable content area
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(22, 22, 22, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (headerExtra != null) ...[
                              headerExtra!,
                              const SizedBox(height: 12),
                            ],

                            // Title
                            if (title.isNotEmpty) ...[
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.neutral14,
                                  fontFamily: 'Aeonik',
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ],

                            // Subtitle
                            if (subtitle != null && subtitle!.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                subtitle!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.neutral40,
                                  fontFamily: 'Aeonik',
                                  height: 1.35,
                                ),
                              ),
                            ],

                            const SizedBox(height: 20),

                            // Form content
                            child,
                          ],
                        ),
                      ),
                    ),

                    // Fixed Bottom Section: Mascot + Speech Bubble + Continue Button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 6, 22, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Mascot & Speech bubble row
                          _buildMascotRow(),
                          const SizedBox(height: 12),

                          // Continue Button
                          _buildContinueButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Sparkles
          Positioned(
            left: 80,
            top: 14,
            child: _buildSparkle(12),
          ),
          Positioned(
            right: 90,
            top: 24,
            child: _buildSparkle(8),
          ),
          Positioned(
            left: 170,
            bottom: 8,
            child: _buildSparkle(6),
          ),

          // Back Button (Left)
          if (showBackButton)
            Positioned(
              left: 0,
              child: GestureDetector(
                onTap: onBack,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

          // Language Selector (Right)
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: onLanguage,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      languageCode == 'am' ? 'አማ' : 'EN',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'Aeonik',
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSparkle(double size) {
    return Icon(
      Icons.star_rounded,
      size: size,
      color: Colors.white.withValues(alpha: 0.35),
    );
  }

  Widget _buildMascotRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Speech Bubble
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8, bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.neutral84.withValues(alpha: 0.7),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              speechText,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.neutral14,
                fontFamily: 'Aeonik',
                height: 1.3,
              ),
            ),
          ),
        ),

        // Mascot SVG
        SvgPicture.asset(
          mascotAsset,
          height: 82,
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: canContinue ? onContinue : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.magenta38,
          disabledBackgroundColor: const Color(0xFFDCBEDA),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          continueText,
          style: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontFamily: 'Aeonik',
          ),
        ),
      ),
    );
  }
}
