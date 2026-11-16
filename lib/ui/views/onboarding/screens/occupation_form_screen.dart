import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_layout.dart';
import 'package:yimaru_app/ui/widgets/custom_dropdown.dart';

class OccupationFormScreen extends ViewModelWidget<OnboardingViewModel> {
  const OccupationFormScreen({super.key});

  void _pop(OnboardingViewModel viewModel) {
    viewModel.resetOccupationFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (viewModel.selectedOccupation == null) return;

    Map<String, dynamic> data = {
      'occupation': viewModel.selectedOccupation?.code,
    };
    viewModel.addUserData(data);
    viewModel.next();
  }

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    final bool canContinue = viewModel.selectedOccupation != null;

    final String speechText = canContinue
        ? "Awesome! English helps in every career."
        : "What do you do for work or study?";

    return OnboardingLayout(
      showBackButton: true,
      onBack: () => _pop(viewModel),
      onLanguage: () async => await viewModel.navigateToLanguage(),
      languageCode: viewModel.selectedLanguage['code'],
      title: LocaleKeys.your_occupation.tr(),
      subtitle: LocaleKeys.occupation_for_personalization.tr(),
      mascotAsset: canContinue
          ? 'assets/images/mascot/yimi-yay.svg'
          : 'assets/images/mascot/yimi-learning.svg',
      speechText: speechText,
      continueText: LocaleKeys.cont.tr(),
      canContinue: canContinue,
      onContinue: () async => await _next(viewModel),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdownPicker(
            hint: LocaleKeys.select_occupation.tr(),
            selectedItem: viewModel.selectedOccupation,
            items: (value, props) => viewModel.occupations,
            onChanged: (value) => viewModel.setSelectedOccupation(value),
          ),
        ],
      ),
    );
  }
}
