import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/practice_question.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/cancel_practice_sheet.dart';
import 'package:yimaru_app/ui/widgets/practice_app_bar.dart';

class StartLearnPracticeScreen extends ViewModelWidget<LearnPracticeViewModel> {
  final int index;
  final PracticeQuestion question;

  const StartLearnPracticeScreen({
    super.key,
    required this.index,
    required this.question,
  });

  Future<void> _cancel(LearnPracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.pop();
  }

  Future<void> _start(LearnPracticeViewModel viewModel) async =>
      await viewModel.playVoicePrompt(question);

  Future<void> _showSheet({
    required BuildContext context,
    required LearnPracticeViewModel viewModel,
  }) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (cxt) => CancelPracticeSheet(
          onClose: viewModel.pop,
          onContinue: viewModel.pop,
          user: viewModel.user?.firstName ?? '',
          onCancel: () async => await _cancel(viewModel),
        ),
      );

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) {
    final totalQuestions =
        viewModel.questions.isEmpty ? 1 : viewModel.questions.length;
    final currentProgress = (index - 0.7) / totalQuestions;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7FC),
      body: SafeArea(
        child: Column(
          children: [
            PracticeAppBar(
              title: LocaleKeys.practice_speaking.tr(),
              progress: currentProgress,
              onPop: () async =>
                  await _showSheet(context: context, viewModel: viewModel),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(),
                    // Start audio prompt button with concentric rings
                    GestureDetector(
                      onTap: () async => await _start(viewModel),
                      child: SizedBox(
                        width: 240,
                        height: 240,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/Yimaru-Icons-and-Illustrations/02-Illustrations/07-learn-level-speaking-practice/7.3-level-practice-start-01.svg',
                              width: 240,
                              height: 240,
                            ),
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.magenta38,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.magenta38
                                        .withValues(alpha: 0.35),
                                    blurRadius: 18,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.volume_up_rounded,
                                    size: 34,
                                    color: kcWhite,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    LocaleKeys.start.tr(),
                                    style: const TextStyle(
                                      fontFamily: 'Aeonik',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: kcWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    // Action label
                    Text(
                      LocaleKeys.tap_start_to_listen.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Aeonik',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2A1830),
                      ),
                    ),
                    const Spacer(),
                    // Disabled Mic Button at the bottom
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF3E8F5),
                        ),
                        child: const Icon(
                          Icons.mic_rounded,
                          size: 32,
                          color: Color(0xFFB0A4B8),
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
