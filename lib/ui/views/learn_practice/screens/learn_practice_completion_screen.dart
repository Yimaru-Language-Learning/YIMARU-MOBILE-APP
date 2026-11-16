import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/practice_app_bar.dart';

class LearnPracticeCompletionScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  final String level;

  const LearnPracticeCompletionScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) {
    final displayLevel = level.trim().isNotEmpty ? level.trim().toUpperCase() : 'A1';

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7FC),
      body: SafeArea(
        child: Column(
          children: [
            PracticeAppBar(
              title: 'Level practice',
              onPop: viewModel.pop,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(),
                    // Mascot with graduation cap & level badge
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/Yimaru-Icons-and-Illustrations/02-Illustrations/07-learn-level-speaking-practice/7.9-level-practice-a1-completed-01.svg',
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                          // Dynamic badge on bottom right
                          Positioned(
                            bottom: 12,
                            right: 18,
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.magenta38,
                                border: Border.all(color: kcWhite, width: 2.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.magenta38
                                        .withValues(alpha: 0.35),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                displayLevel,
                                style: const TextStyle(
                                  fontFamily: 'Aeonik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: kcWhite,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Title
                    Text(
                      "Yay, you've completed $displayLevel!",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Aeonik',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2A1830),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Subtitle
                    const Text(
                      "Great work. You're ready for the next level.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Aeonik',
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const Spacer(),

                    // Continue button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: viewModel.pop,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.magenta38,
                            foregroundColor: kcWhite,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            LocaleKeys.cont.tr(),
                            style: const TextStyle(
                              fontFamily: 'Aeonik',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: kcWhite,
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
}
