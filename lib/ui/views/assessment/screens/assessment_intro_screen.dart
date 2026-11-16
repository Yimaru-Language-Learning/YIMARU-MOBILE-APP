import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../assessment_viewmodel.dart';

class AssessmentIntroScreen extends ViewModelWidget<AssessmentViewModel> {
  final bool hasAssessments;

  const AssessmentIntroScreen({super.key, required this.hasAssessments});

  void _next(AssessmentViewModel viewModel) {
    viewModel.reset();
    viewModel.next();
  }

  @override
  Widget build(BuildContext context, AssessmentViewModel viewModel) {
    return Scaffold(
      backgroundColor: const Color(0xFF6E1665),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top bar with language toggle
            _buildTopBar(viewModel),

            // White card body
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    // Mascot area
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/mascot/yimi-yay.svg',
                              height: 180,
                            ),
                            const SizedBox(height: 28),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                LocaleKeys.want_quick_assessment.tr(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.neutral14,
                                  fontFamily: 'Aeonik',
                                  letterSpacing: -0.3,
                                  height: 1.25,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 36),
                              child: Text(
                                LocaleKeys.answer_quick_questions.tr(),
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

                    // Bottom buttons
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 32),
                      child: Column(
                        children: [
                          if (hasAssessments &&
                              !(viewModel.session?.completed ?? false)) ...[
                            _buildPrimaryButton(
                              label: LocaleKeys.start_assessment.tr(),
                              onTap: () => _next(viewModel),
                            ),
                            const SizedBox(height: 14),
                          ],
                          _buildSkipButton(viewModel),
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

  Widget _buildTopBar(AssessmentViewModel viewModel) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Sparkles
          Positioned(
              left: 80,
              top: 14,
              child: _sparkle(12)),
          Positioned(
              right: 90,
              top: 24,
              child: _sparkle(8)),
          Positioned(
              left: 170,
              bottom: 8,
              child: _sparkle(6)),

          // Language badge (right)
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
                      viewModel.selectedLanguage['code'] == 'am' ? 'አማ' : 'EN',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'Aeonik',
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        size: 14, color: Colors.white),
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

  Widget _buildPrimaryButton(
      {required String label, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.magenta38,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
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

  Widget _buildSkipButton(AssessmentViewModel viewModel) {
    return GestureDetector(
      onTap: () => viewModel.next(page: 3),
      child: Text(
        LocaleKeys.skip.tr(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.magenta38,
          fontFamily: 'Aeonik',
          decoration: TextDecoration.underline,
          decorationColor: AppColors.magenta38,
        ),
      ),
    );
  }
}
