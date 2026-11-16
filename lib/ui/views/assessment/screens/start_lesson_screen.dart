import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../../../common/enmus.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../assessment_viewmodel.dart';

class StartLessonScreen extends ViewModelWidget<AssessmentViewModel> {
  const StartLessonScreen({super.key});

  Future<void> _start(AssessmentViewModel viewModel) async {
    await viewModel.completeProfile();
  }

  @override
  Widget build(BuildContext context, AssessmentViewModel viewModel) {
    final bool isLoading = viewModel.busy(StateObjects.profileCompletion);
    final String firstName =
        (viewModel.userData['first_name'] as String?)?.trim() ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFF6E1665),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar
            _buildTopBar(viewModel),

            // White Sheet
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Mascot with festive sparkles
                                  _buildMascotSection(),
                                  const SizedBox(height: 32),

                                  // Title: Welcome aboard, [Name]!
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.neutral14,
                                        fontFamily: 'Aeonik',
                                        letterSpacing: -0.3,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: firstName.isNotEmpty
                                              ? '${LocaleKeys.welcome_abroad.tr()}, '
                                              : '${LocaleKeys.welcome_abroad.tr()}!',
                                        ),
                                        if (firstName.isNotEmpty)
                                          TextSpan(
                                            text: '$firstName!',
                                            style: const TextStyle(
                                              color: AppColors.magenta38,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  // Subtitle
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      LocaleKeys.ready_to_explore.tr(),
                                      style: const TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.neutral40,
                                        fontFamily: 'Aeonik',
                                        height: 1.45,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Go to My Lessons Button
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(22, 0, 22, 32),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () async => await _start(viewModel),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.magenta38,
                                disabledBackgroundColor:
                                    const Color(0xFFDCBEDA),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'Go to My Lessons',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: 'Aeonik',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (isLoading)
                      const PageLoadingIndicator(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMascotSection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Decorative confetti sparkle dots
        SizedBox(
          width: 240,
          height: 200,
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 30,
                child: _confettiDot(const Color(0xFFFFB74D), 8),
              ),
              Positioned(
                top: 35,
                right: 35,
                child: _confettiDot(const Color(0xFF4DD0E1), 7),
              ),
              Positioned(
                bottom: 45,
                left: 20,
                child: _confettiDot(const Color(0xFF81C784), 7),
              ),
              Positioned(
                bottom: 30,
                right: 25,
                child: _confettiDot(const Color(0xFFFF8A80), 8),
              ),
              Positioned(
                top: 80,
                left: 10,
                child: _confettiDot(AppColors.magenta38, 6),
              ),
              Positioned(
                top: 75,
                right: 15,
                child: _confettiDot(const Color(0xFFFFD54F), 6),
              ),
            ],
          ),
        ),

        // Mascot SVG
        SvgPicture.asset(
          'assets/images/mascot/yimi-yay.svg',
          height: 160,
        ),
      ],
    );
  }

  Widget _confettiDot(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildTopBar(AssessmentViewModel viewModel) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Sparkles
          Positioned(left: 80, top: 14, child: _sparkle(12)),
          Positioned(right: 90, top: 24, child: _sparkle(8)),
          Positioned(left: 170, bottom: 8, child: _sparkle(6)),

          // Language Selector (Right)
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () async => await viewModel.navigateToLanguage(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      viewModel.selectedLanguage['code'] == 'am'
                          ? 'አማ'
                          : 'EN',
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

  Widget _sparkle(double size) => Icon(
        Icons.star_rounded,
        size: size,
        color: Colors.white.withValues(alpha: 0.35),
      );
}
