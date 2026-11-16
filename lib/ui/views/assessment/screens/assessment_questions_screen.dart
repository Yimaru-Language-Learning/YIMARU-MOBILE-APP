import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../../../common/enmus.dart';
import '../assessment_viewmodel.dart';

class AssessmentQuestionsScreen extends ViewModelWidget<AssessmentViewModel> {
  const AssessmentQuestionsScreen({super.key});

  Future<void> _finish(AssessmentViewModel viewModel) async {
    await viewModel.finishAssessment();
  }

  @override
  Widget build(BuildContext context, AssessmentViewModel viewModel) {
    final bool isLoading = viewModel.busy(StateObjects.finishAssessment);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => viewModel.previousQuestion(),
      child: Scaffold(
        backgroundColor: const Color(0xFF6E1665),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // Top purple bar with question counter & close
              _buildTopBar(viewModel),

              // White card body
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
                          // Progress bar
                          _buildProgressBar(viewModel),

                          // Scrollable question + answers
                          Expanded(
                            child: PageView.builder(
                              controller: viewModel.pageController,
                              itemCount: viewModel.questions.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, __) =>
                                  _buildQuestionPage(viewModel),
                            ),
                          ),

                          // Bottom mascot + continue button
                          _buildBottomSection(viewModel),
                        ],
                      ),

                      // Loading overlay
                      if (isLoading) _buildLoadingOverlay(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(AssessmentViewModel viewModel) {
    final int total = viewModel.questions.length;
    final int current = viewModel.currentQuestionIndex + 1;

    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Sparkles
          Positioned(
              left: 80, top: 14, child: _sparkle(12)),
          Positioned(
              right: 90, top: 24, child: _sparkle(8)),
          Positioned(
              left: 170, bottom: 8, child: _sparkle(6)),

          // Back button (left) — only after Q1
          if (viewModel.currentQuestionIndex > 0)
            Positioned(
              left: 0,
              child: GestureDetector(
                onTap: viewModel.previousQuestion,
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

          // Question counter (center)
          Text(
            '$current / $total',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: 'Aeonik',
            ),
          ),

          // Close button (right)
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: viewModel.abort,
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.close_rounded, size: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(AssessmentViewModel viewModel) {
    final double progress = viewModel.questions.isEmpty
        ? 0
        : (viewModel.currentQuestionIndex + 1) / viewModel.questions.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: LinearProgressIndicator(
          value: progress,
          minHeight: 6,
          backgroundColor: AppColors.neutral84.withValues(alpha: 0.5),
          valueColor:
              const AlwaysStoppedAnimation<Color>(AppColors.magenta38),
        ),
      ),
    );
  }

  Widget _buildQuestionPage(AssessmentViewModel viewModel) {
    final int idx = viewModel.currentQuestionIndex;
    if (idx >= viewModel.questions.length) return const SizedBox.shrink();

    final question = viewModel.questions[idx];
    final String questionText =
        'Q${idx + 1}. ${question.dynamicPayload?.stimulus?.first.value ?? ''}';
    final List<dynamic> options =
        question.dynamicPayload?.response?.first.value ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question text
          Text(
            questionText,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.neutral14,
              fontFamily: 'Aeonik',
              height: 1.4,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 20),

          // Answer options
          ...options.asMap().entries.map((entry) {
            final option = entry.value;
            final String text = option['option_text'] ?? '';
            final bool isSelected = viewModel.isSelectedAnswer(
              question: idx + 1,
              answer: text,
            );

            return _buildOptionTile(
              text: text,
              isSelected: isSelected,
              onTap: () => viewModel.setSelectedAnswer(
                question: idx + 1,
                option: option,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color:
              isSelected ? const Color(0xFFFAF0F8) : const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.magenta38
                : AppColors.neutral84.withValues(alpha: 0.65),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? AppColors.magenta38
                      : AppColors.neutral14,
                  fontFamily: 'Aeonik',
                ),
              ),
            ),
            const SizedBox(width: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.magenta38
                    : Colors.transparent,
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
                      child: Icon(Icons.check_rounded,
                          size: 14, color: Colors.white),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection(AssessmentViewModel viewModel) {
    final int idx = viewModel.currentQuestionIndex;
    final bool hasAnswered =
        viewModel.selectedAnswers.containsKey('${idx + 1}');
    final bool isLastQuestion =
        idx == viewModel.questions.length - 1;
    final bool sessionCompleted =
        viewModel.session?.completed ?? false;

    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 6, 22, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mascot row with speech bubble
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 8, bottom: 6),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 11),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.neutral84.withValues(alpha: 0.7),
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
                    _getSpeechText(
                      currentIndex: idx,
                      total: viewModel.questions.length,
                      hasAnswered: hasAnswered,
                    ),
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
              SvgPicture.asset(
                hasAnswered
                    ? 'assets/images/mascot/yimi-yay.svg'
                    : 'assets/images/mascot/yimi-thinking.svg',
                height: 80,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Continue / Finish button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: hasAnswered
                  ? isLastQuestion
                      ? (sessionCompleted
                          ? () async => await _finish(viewModel)
                          : () async => await _finish(viewModel))
                      : () => viewModel.nextQuestion()
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.magenta38,
                disabledBackgroundColor: const Color(0xFFDCBEDA),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                isLastQuestion
                    ? LocaleKeys.finish_assessment.tr()
                    : LocaleKeys.cont.tr(),
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'Aeonik',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getSpeechText({
    required int currentIndex,
    required int total,
    required bool hasAnswered,
  }) {
    final int currentQuestion = currentIndex + 1;
    if (currentQuestion == total) {
      return "Last one!";
    } else if (currentQuestion == 1) {
      return hasAnswered ? "Great start!" : "Take your time!";
    } else if (currentQuestion == 2) {
      return "You've got this!";
    } else if (currentQuestion == 3 || currentQuestion == total - 1) {
      return "Almost there!";
    } else {
      return hasAnswered ? "Great! Keep it up!" : "Take your time!";
    }
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.white.withValues(alpha: 0.85),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sparkle dots
            _buildSparkleRow(),
            const SizedBox(height: 28),
            const SizedBox(
              width: 56,
              height: 56,
              child: CircularProgressIndicator(
                strokeWidth: 3.5,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.magenta38),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Analyzing your results...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.neutral14,
                fontFamily: 'Aeonik',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This might take a moment.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.neutral40,
                fontFamily: 'Aeonik',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSparkleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _sparkleDot(10),
        const SizedBox(width: 10),
        _sparkleDot(14),
        const SizedBox(width: 10),
        _sparkleDot(10),
      ],
    );
  }

  Widget _sparkleDot(double size) => Icon(
        Icons.star_rounded,
        size: size,
        color: AppColors.magenta38.withValues(alpha: 0.4),
      );

  Widget _sparkle(double size) => Icon(
        Icons.star_rounded,
        size: size,
        color: Colors.white.withValues(alpha: 0.35),
      );
}
