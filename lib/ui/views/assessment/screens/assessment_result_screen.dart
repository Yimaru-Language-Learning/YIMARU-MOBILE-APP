import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../../../common/enmus.dart';
import '../assessment_viewmodel.dart';

class AssessmentResultScreen extends ViewModelWidget<AssessmentViewModel> {
  const AssessmentResultScreen({super.key});

  String _getLevelSvgPath(String? level) {
    if (level == null || level.isEmpty) return 'assets/icons/b_1.svg';
    final lower = level.toLowerCase().trim();
    // Handles formats like "b1" -> "b_1.svg", "a2" -> "a_2.svg"
    if (lower.length >= 2) {
      final letter = lower[0];
      final number = lower.substring(1);
      return 'assets/icons/${letter}_$number.svg';
    }
    return 'assets/icons/b_1.svg';
  }

  Future<void> _proceedToStartLesson(AssessmentViewModel viewModel) async {
    await viewModel.updateKnowledgeLevel();
    viewModel.next();
  }

  @override
  Widget build(BuildContext context, AssessmentViewModel viewModel) {
    final bool isLoading = viewModel.busy(StateObjects.finishAssessment);
    final bool isPassed = viewModel.proficiencyLevel?.passed ?? true;
    final String level = viewModel.proficiencyLevel?.level ?? 'B1';

    // 1. Frame 7: Analyzing results
    if (isLoading) {
      return _buildAnalyzingScreen(viewModel);
    }

    // 2. Frame 6: Insufficient results / Failed
    if (!isPassed && viewModel.proficiencyLevel != null) {
      return _buildInsufficientScreen(viewModel);
    }

    // 3. Frame 8: Assessment complete!
    if (!viewModel.showLevelResult) {
      return _buildCompleteScreen(viewModel);
    }

    // 4. Frame 9 & 10: Level Result (e.g. B1)
    return _buildLevelResultScreen(viewModel, level);
  }

  /// Frame 7: Analyzing results spinner
  Widget _buildAnalyzingScreen(AssessmentViewModel viewModel) {
    return Scaffold(
      backgroundColor: const Color(0xFF6E1665),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(viewModel),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Festive sparkle dots
                    _buildConfettiCircle(
                      size: 130,
                      child: const SizedBox(
                        width: 58,
                        height: 58,
                        child: CircularProgressIndicator(
                          strokeWidth: 3.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.magenta38),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Analyzing your results...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.neutral14,
                        fontFamily: 'Aeonik',
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This might take a moment.',
                      style: TextStyle(
                        fontSize: 13.5,
                        color: AppColors.neutral40,
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
    );
  }

  /// Frame 6: We didn't get enough from your assessment
  Widget _buildInsufficientScreen(AssessmentViewModel viewModel) {
    return Scaffold(
      backgroundColor: const Color(0xFF6E1665),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(viewModel, showClose: true),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 28),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Alert icon with confetti
                              _buildConfettiCircle(
                                size: 160,
                                child: SvgPicture.asset(
                                  'assets/icons/alert.svg',
                                  height: 80,
                                ),
                              ),
                              const SizedBox(height: 28),

                              // Title
                              const Text(
                                "We didn't get enough from your assessment",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.neutral14,
                                  fontFamily: 'Aeonik',
                                  letterSpacing: -0.3,
                                  height: 1.25,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),

                              // Subtitle
                              const Text(
                                "Your responses weren't long enough for us to evaluate your speaking level. You can retake the test or get a custom course.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.neutral40,
                                  fontFamily: 'Aeonik',
                                  height: 1.45,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Buttons
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 32),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                viewModel.reset();
                                await viewModel.getInitialAssessment();
                                viewModel.next(page: 1);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.magenta38,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'Continue Assessment',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: 'Aeonik',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
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
                          ),
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

  /// Frame 8: Assessment complete!
  Widget _buildCompleteScreen(AssessmentViewModel viewModel) {
    return Scaffold(
      backgroundColor: const Color(0xFF6E1665),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(viewModel),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 28),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Rosette Checkmark Badge with confetti
                              _buildConfettiCircle(
                                size: 170,
                                child: SvgPicture.asset(
                                  'assets/icons/complete.svg',
                                  height: 110,
                                ),
                              ),
                              const SizedBox(height: 32),

                              // Title
                              const Text(
                                'Assessment complete!',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.neutral14,
                                  fontFamily: 'Aeonik',
                                  letterSpacing: -0.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),

                              // Subtitle
                              const Text(
                                'Your results are ready!',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.neutral40,
                                  fontFamily: 'Aeonik',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Continue button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 32),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            viewModel.setShowLevelResult(true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.magenta38,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            LocaleKeys.cont.tr(),
                            style: const TextStyle(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Frame 9 & 10: You're likely a [B1] speaker!
  Widget _buildLevelResultScreen(
      AssessmentViewModel viewModel, String level) {
    return Scaffold(
      backgroundColor: const Color(0xFF6E1665),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(
              viewModel,
              showBack: true,
              onBack: () => viewModel.setShowLevelResult(false),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 28),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Hexagon Level Badge with Confetti
                              _buildConfettiCircle(
                                size: 180,
                                child: SvgPicture.asset(
                                  _getLevelSvgPath(level),
                                  height: 120,
                                ),
                              ),
                              const SizedBox(height: 32),

                              // Title
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
                                    const TextSpan(text: "You're likely a "),
                                    TextSpan(
                                      text: '$level ',
                                      style: const TextStyle(
                                        color: AppColors.magenta38,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const TextSpan(text: 'speaker!'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Subtitles
                              Text(
                                LocaleKeys.great_job.tr(),
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.neutral40,
                                  fontFamily: 'Aeonik',
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                LocaleKeys.lets_start_practice.tr(),
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.neutral14,
                                  fontFamily: 'Aeonik',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Continue button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 32),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async =>
                              await _proceedToStartLesson(viewModel),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.magenta38,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            LocaleKeys.cont.tr(),
                            style: const TextStyle(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Circular confetti surrounding badge/icon
  Widget _buildConfettiCircle({
    required Widget child,
    required double size,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background soft tint ring
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFAF0F8).withValues(alpha: 0.7),
            ),
          ),

          // Floating confetti dots
          Positioned(
            top: size * 0.12,
            left: size * 0.18,
            child: _confettiDot(const Color(0xFFFFB74D), 7),
          ),
          Positioned(
            top: size * 0.15,
            right: size * 0.20,
            child: _confettiDot(const Color(0xFF4DD0E1), 7),
          ),
          Positioned(
            bottom: size * 0.15,
            left: size * 0.16,
            child: _confettiDot(const Color(0xFF81C784), 8),
          ),
          Positioned(
            bottom: size * 0.12,
            right: size * 0.18,
            child: _confettiDot(const Color(0xFFFF8A80), 7),
          ),
          Positioned(
            top: size * 0.48,
            left: size * 0.05,
            child: _confettiDot(AppColors.magenta38, 6),
          ),
          Positioned(
            top: size * 0.50,
            right: size * 0.05,
            child: _confettiDot(const Color(0xFFFFD54F), 6),
          ),

          // Icon / Badge
          child,
        ],
      ),
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

  Widget _buildTopBar(
    AssessmentViewModel viewModel, {
    bool showBack = false,
    bool showClose = false,
    VoidCallback? onBack,
  }) {
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

          // Back Button
          if (showBack)
            Positioned(
              left: 0,
              child: GestureDetector(
                onTap: onBack ?? viewModel.goBack,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.arrow_back_ios_new_rounded,
                        size: 16, color: Colors.white),
                  ),
                ),
              ),
            ),

          // Close Button
          if (showClose)
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: viewModel.goBack,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.close_rounded,
                        size: 18, color: Colors.white),
                  ),
                ),
              ),
            )
          else
            // Language selector
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
}
