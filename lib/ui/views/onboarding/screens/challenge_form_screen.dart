import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_layout.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_option_tile.dart';

class ChallengeFormScreen extends ViewModelWidget<OnboardingViewModel> {
  const ChallengeFormScreen({super.key});

  void _pop(OnboardingViewModel viewModel) {
    viewModel.resetChallengeFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (viewModel.selectedChallenge == null) return;

    Map<String, dynamic> data = {
      'language_challange': viewModel.selectedChallenge?.code,
    };
    viewModel.addUserData(data);
    viewModel.next();
  }

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    final bool canContinue = viewModel.selectedChallenge != null;

    return OnboardingLayout(
      showBackButton: true,
      onBack: () => _pop(viewModel),
      onLanguage: () async => await viewModel.navigateToLanguage(),
      languageCode: viewModel.selectedLanguage['code'],
      title: LocaleKeys.challenge_you_face.tr(),
      subtitle: LocaleKeys.everyone_has_struggles_subtitle.tr(),
      mascotAsset: 'assets/images/mascot/yimi-standing.svg',
      speechText: "We'll build your confidence together.",
      continueText: LocaleKeys.cont.tr(),
      canContinue: canContinue,
      onContinue: () async => await _next(viewModel),
      child: Column(
        children: viewModel.challenges.map((option) {
          final bool isSelected = viewModel.isSelectedChallenge(option);
          return OnboardingOptionTile(
            title: option.label ?? '',
            isSelected: isSelected,
            onTap: () => viewModel.setSelectedChallenge(option),
          );
        }).toList(),
      ),
    );
  }
}
