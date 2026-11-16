import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/practice_app_bar.dart';

class LearnPracticeFinishScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeFinishScreen({super.key});

  Future<void> _reset(LearnPracticeViewModel viewModel) async =>
      await viewModel.reset();

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7FC),
      body: SafeArea(
        child: Column(
          children: [
            PracticeAppBar(
              title: LocaleKeys.practice_speaking.tr(),
              onPop: viewModel.goBack,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(),
                    // Celebratory Mascot
                    SvgPicture.asset(
                      'assets/images/mascot/yimi-yay.svg',
                      width: 170,
                      height: 170,
                    ),
                    const SizedBox(height: 28),

                    // Title
                    Text(
                      LocaleKeys.practice_completed.tr(),
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
                    Text(
                      LocaleKeys.sound_confident.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Aeonik',
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const Spacer(),

                    // Buttons
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
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
                                LocaleKeys.continue_practice.tr(),
                                style: const TextStyle(
                                  fontFamily: 'Aeonik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: kcWhite,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: OutlinedButton(
                              onPressed: () async => await _reset(viewModel),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: kcWhite,
                                foregroundColor: AppColors.magenta38,
                                side: const BorderSide(
                                  color: AppColors.magenta38,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                LocaleKeys.practice_again.tr(),
                                style: const TextStyle(
                                  fontFamily: 'Aeonik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.magenta38,
                                ),
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
}
