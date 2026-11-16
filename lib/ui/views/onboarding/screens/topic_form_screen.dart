import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_layout.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_option_tile.dart';

class TopicFormScreen extends ViewModelWidget<OnboardingViewModel> {
  const TopicFormScreen({super.key});

  void _pop(OnboardingViewModel viewModel) {
    viewModel.resetTopicFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (viewModel.selectedTopic == null) return;

    Map<String, dynamic> data = {
      'profile_completed': true,
      'preferred_language': 'en',
      'favoutite_topic': viewModel.selectedTopic?.code,
      'birth_day': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    };
    viewModel.addUserData(data);

    await viewModel.navigateToAssessment();
  }

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    final bool canContinue = viewModel.selectedTopic != null;
    final selectedLabel = viewModel.selectedTopic?.label?.toLowerCase() ?? '';

    String speech = "Great topics! Let's explore them together.";
    if (selectedLabel.contains('tech')) {
      speech = "Ooh, I love tech too!";
    } else if (selectedLabel.contains('food') || selectedLabel.contains('cook')) {
      speech = "Yum! English around food is so fun.";
    } else if (selectedLabel.contains('music') || selectedLabel.contains('sport')) {
      speech = "Awesome hobbies to talk about!";
    } else if (selectedLabel.contains('travel')) {
      speech = "Pack your bags, English takes you places!";
    }

    return OnboardingLayout(
      showBackButton: true,
      onBack: () => _pop(viewModel),
      onLanguage: () async => await viewModel.navigateToLanguage(),
      languageCode: viewModel.selectedLanguage['code'],
      title: LocaleKeys.topic_interest.tr(),
      subtitle: LocaleKeys.favourite_topic.tr(),
      mascotAsset: 'assets/images/mascot/yimi-yay.svg',
      speechText: speech,
      continueText: LocaleKeys.cont.tr(),
      canContinue: canContinue,
      onContinue: () async => await _next(viewModel),
      child: Column(
        children: viewModel.topics.map((option) {
          final bool isSelected = viewModel.isSelectedTopic(option);
          return OnboardingOptionTile(
            title: option.label ?? '',
            isSelected: isSelected,
            onTap: () => viewModel.setSelectedTopic(option),
          );
        }).toList(),
      ),
    );
  }
}
