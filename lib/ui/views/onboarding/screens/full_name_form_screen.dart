import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/helper_functions.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_layout.dart';
import '../onboarding_view.form.dart';

class FullNameFormScreen extends ViewModelWidget<OnboardingViewModel> {
  final TextEditingController fullNameController;

  const FullNameFormScreen({super.key, required this.fullNameController});

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (fullNameController.text.trim().isEmpty) {
      viewModel.setFullNameFocus();
      viewModel.rebuildUi();
      return;
    }

    Map<String, dynamic> data = splitFullName(fullNameController.text);
    viewModel.addUserData(data);
    viewModel.next();
  }

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    final String name = fullNameController.text.trim();
    final bool hasError = viewModel.hasFullNameValidationMessage && viewModel.focusFullName;

    String mascot = 'assets/images/mascot/yimi-hello.svg';
    String speech = "I'm Yimi, your English buddy!";

    if (hasError || (viewModel.focusFullName && name.isEmpty)) {
      mascot = 'assets/images/mascot/yimi-oops.svg';
      speech = "Oops! I need your name first.";
    } else if (name.isNotEmpty) {
      mascot = 'assets/images/mascot/yimi-yay.svg';
      speech = "Nice to meet you, $name!";
    }

    return OnboardingLayout(
      showBackButton: false,
      onLanguage: () async => await viewModel.navigateToLanguage(),
      languageCode: viewModel.selectedLanguage['code'],
      title: LocaleKeys.what_should_we_call_you_title.tr(),
      subtitle: LocaleKeys.name_for_personalization.tr(),
      mascotAsset: mascot,
      speechText: speech,
      continueText: LocaleKeys.cont.tr(),
      canContinue: name.isNotEmpty,
      onContinue: () async => await _next(viewModel),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name Text Input Field
          TextFormField(
            controller: fullNameController,
            onTap: viewModel.setFullNameFocus,
            onChanged: (val) => viewModel.rebuildUi(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.neutral14,
              fontFamily: 'Aeonik',
            ),
            decoration: InputDecoration(
              hintText: 'Enter Your Name',
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.neutral40.withValues(alpha: 0.6),
                fontFamily: 'Aeonik',
              ),
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: hasError ? const Color(0xFFE53935) : AppColors.neutral84.withValues(alpha: 0.7),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: hasError ? const Color(0xFFE53935) : AppColors.neutral84.withValues(alpha: 0.7),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: hasError ? const Color(0xFFE53935) : AppColors.magenta38,
                  width: 1.5,
                ),
              ),
              suffixIcon: name.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18, color: AppColors.neutral40),
                      onPressed: () {
                        fullNameController.clear();
                        viewModel.rebuildUi();
                      },
                    )
                  : null,
            ),
          ),

          // Error Message
          if (hasError) ...[
            const SizedBox(height: 6),
            Text(
              viewModel.fullNameValidationMessage ?? 'Please enter your name!',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFFE53935),
                fontFamily: 'Aeonik',
              ),
            ),
          ],
        ],
      ),
    );
  }
}
