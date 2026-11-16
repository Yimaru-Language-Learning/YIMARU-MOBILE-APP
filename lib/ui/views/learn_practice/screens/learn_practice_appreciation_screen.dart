import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/cancel_practice_sheet.dart';
import 'package:yimaru_app/ui/widgets/practice_app_bar.dart';
import 'package:yimaru_app/ui/widgets/rosette_check_badge.dart';

class LearnPracticeAppreciationScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeAppreciationScreen({super.key});

  Future<void> _cancel(LearnPracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.pop();
  }

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
    final firstName = viewModel.user?.firstName?.trim();
    final displayName = (firstName != null && firstName.isNotEmpty)
        ? firstName
        : 'Johnny';

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7FC),
      body: SafeArea(
        child: Column(
          children: [
            PracticeAppBar(
              title: LocaleKeys.practice_speaking.tr(),
              onPop: () async =>
                  await _showSheet(context: context, viewModel: viewModel),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(),
                    // Rosette Check Badge with confetti
                    const RosetteCheckBadge(size: 110),
                    const SizedBox(height: 28),

                    // Title
                    Text(
                      '${LocaleKeys.great_work.tr()}, $displayName!',
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
                      LocaleKeys.you_have_finished_practice.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Aeonik',
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const Spacer(),

                    // Button: View my results
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () => viewModel.goTo(4),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.magenta38,
                            foregroundColor: kcWhite,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'View my results',
                            style: TextStyle(
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
