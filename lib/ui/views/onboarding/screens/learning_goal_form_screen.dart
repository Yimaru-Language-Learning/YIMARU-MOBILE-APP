import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_layout.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_option_tile.dart';

class LearningGoalFormScreen extends ViewModelWidget<OnboardingViewModel> {
  const LearningGoalFormScreen({super.key});

  void _pop(OnboardingViewModel viewModel) {
    viewModel.resetLearningGoalFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (viewModel.selectedLearningGoal == null) return;

    Map<String, dynamic> data = {
      'learning_goal': viewModel.selectedLearningGoal?.code,
    };
    viewModel.addUserData(data);
    viewModel.next();
  }

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    final selected = viewModel.selectedLearningGoal;
    final bool isOtherSelected =
        selected != null && (selected.label?.toLowerCase().contains('other') ?? false);

    final bool canContinue = selected != null;

    final String mascot = isOtherSelected
        ? 'assets/images/mascot/yimi-thinking.svg'
        : 'assets/images/mascot/yimi-speaking.svg';

    final String speech = isOtherSelected
        ? "Tell me more!"
        : "We'll make it happen!";

    return OnboardingLayout(
      showBackButton: true,
      onBack: () => _pop(viewModel),
      onLanguage: () async => await viewModel.navigateToLanguage(),
      languageCode: viewModel.selectedLanguage['code'],
      title: LocaleKeys.learning_goal.tr(),
      subtitle: "This helps us focus your learning priorities.",
      mascotAsset: mascot,
      speechText: speech,
      continueText: LocaleKeys.cont.tr(),
      canContinue: canContinue,
      onContinue: () async => await _next(viewModel),
      child: Column(
        children: viewModel.learningGoals.map((option) {
          final bool isSelected = viewModel.isSelectedLearningGoal(option);
          final bool isThisOther =
              option.label?.toLowerCase().contains('other') ?? false;

          return Column(
            children: [
              OnboardingOptionTile(
                title: option.label ?? '',
                isSelected: isSelected,
                onTap: () => viewModel.setSelectedLearningGoal(option),
              ),
              if (isThisOther && isSelected) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextFormField(
                    onChanged: (val) {
                      viewModel.userData['custom_learning_goal'] = val;
                    },
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.neutral14,
                      fontFamily: 'Aeonik',
                    ),
                    decoration: InputDecoration(
                      hintText: LocaleKeys.write_your_goal.tr(),
                      hintStyle: TextStyle(
                        fontSize: 13.5,
                        color: AppColors.neutral40.withValues(alpha: 0.6),
                        fontFamily: 'Aeonik',
                      ),
                      filled: true,
                      fillColor: const Color(0xFFFAF0F8),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.magenta38,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: AppColors.magenta38.withValues(alpha: 0.6),
                          width: 1,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        borderSide: BorderSide(
                          color: AppColors.magenta38,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        }).toList(),
      ),
    );
  }
}
