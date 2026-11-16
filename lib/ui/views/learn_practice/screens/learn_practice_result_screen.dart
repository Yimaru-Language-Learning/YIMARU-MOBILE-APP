import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/cancel_practice_sheet.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_results_wrapper.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_tip_section.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';
import 'package:yimaru_app/ui/widgets/practice_app_bar.dart';

class LearnPracticeResultScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  final LearnPractices practice;

  const LearnPracticeResultScreen({super.key, required this.practice});

  Future<void> _navigate(LearnPracticeViewModel viewModel) async {
    await viewModel.completeLearnPractice();
    if (practice == LearnPractices.course) {
      viewModel.goTo(6);
    } else if (practice == LearnPractices.module) {
      viewModel.goTo(5);
    } else {
      viewModel.goTo(4);
    }
  }

  Future<void> _retry(LearnPracticeViewModel viewModel) async =>
      await viewModel.reset();

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
    if (viewModel.busy(StateObjects.completeLearnPractice)) {
      return const Scaffold(
        backgroundColor: Color(0xFFFAF7FC),
        body: PageLoadingIndicator(),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7FC),
      body: SafeArea(
        child: Column(
          children: [
            PracticeAppBar(
              title: LocaleKeys.result.tr(),
              onPop: () async =>
                  await _showSheet(context: context, viewModel: viewModel),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // Conversation review
                    const LearnPracticeResultsWrapper(),
                    const SizedBox(height: 16),
                    // Quick tip
                    const LearnPracticeTipSection(),
                    const SizedBox(height: 24),
                    // Buttons
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () async => await _navigate(viewModel),
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
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: OutlinedButton(
                        onPressed: () async => await _retry(viewModel),
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
                          LocaleKeys.retry.tr(),
                          style: const TextStyle(
                            fontFamily: 'Aeonik',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.magenta38,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
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
