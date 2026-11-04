import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/register/register_viewmodel.dart';
import '../register_view.form.dart';
import 'package:yimaru_app/ui/widgets/auth_header.dart';
import 'package:yimaru_app/ui/widgets/option_text_divider.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';

class RegisterWithPhoneNumberScreen
    extends ViewModelWidget<RegisterViewModel> {
  final TextEditingController phoneNumberController;

  const RegisterWithPhoneNumberScreen({
    super.key,
    required this.phoneNumberController,
  });

  Future<void> _addUserData(RegisterViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'role': 'STUDENT',
      'otp_medium': 'sms',
      'phone_number': '251${phoneNumberController.text}',
    };
    viewModel.clearUserData();
    viewModel.addUserData(data);
    await viewModel.registerWithEmail(SignUpMethod.phone);
  }

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    final bool canSubmit = phoneNumberController.text.length == 9 &&
        !viewModel.hasPhoneNumberValidationMessage;

    return Scaffold(
      backgroundColor: const Color(0xFF6E1665),
      body: Stack(
        children: [
          Column(
            children: [
              AuthHeader(
                showBackButton: true,
                onBack: viewModel.goBack,
                onLanguage: () async => await viewModel.navigateToLanguage(),
                languageCode: viewModel.selectedLanguage['code'],
                speechTitle: 'እንኳን ደህና መጡ!',
                speechSubtitle: "I'll text you a code.",
                mascotAsset: 'assets/images/mascot/yimi-speaking.svg',
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(22, 26, 22, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          LocaleKeys.create_account.tr(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.neutral14,
                            fontFamily: 'Aeonik',
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Subtitle Link: Already have an account? Login
                        Row(
                          children: [
                            Text(
                              '${LocaleKeys.already_have_account.tr()} ',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.neutral40,
                                fontFamily: 'Aeonik',
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async =>
                                  await viewModel.replaceToLogin(),
                              child: Text(
                                LocaleKeys.login.tr(),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.magenta38,
                                  fontFamily: 'Aeonik',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Helper text
                        Text(
                          LocaleKeys.enter_phone_number.tr(),
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.neutral40,
                            fontFamily: 'Aeonik',
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Phone Number Input Row
                        _buildPhoneInputRow(viewModel),
                        if (viewModel.hasPhoneNumberValidationMessage &&
                            viewModel.focusPhoneNumber) ...[
                          const SizedBox(height: 4),
                          Text(
                            viewModel.phoneNumberValidationMessage!,
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: Color(0xFFE53935),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),

                        // Continue Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: canSubmit
                                ? () async => await _addUserData(viewModel)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.magenta38,
                              disabledBackgroundColor:
                                  const Color(0xFFF3E8FF),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              LocaleKeys.cont.tr(),
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: canSubmit
                                    ? Colors.white
                                    : AppColors.magenta38
                                        .withValues(alpha: 0.45),
                                fontFamily: 'Aeonik',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // "Or" Divider
                        const OptionTextDivider(),
                        const SizedBox(height: 18),

                        // Register with Email Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () => viewModel.goTo(page: 0),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: AppColors.magenta38,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  size: 18,
                                  color: AppColors.magenta38,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  LocaleKeys.register_with_email.tr(),
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.magenta38,
                                    fontFamily: 'Aeonik',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Loading Overlay
          if (viewModel.busy(StateObjects.register))
            const PageLoadingIndicator(),
        ],
      ),
    );
  }

  Widget _buildPhoneInputRow(RegisterViewModel viewModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Country Code Prefix Box
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.neutral84.withValues(alpha: 0.7),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/flag.png',
                width: 22,
                height: 16,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 6),
              const Text(
                '+251',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.neutral14,
                  fontFamily: 'Aeonik',
                ),
              ),
              const Icon(
                Icons.arrow_drop_down_rounded,
                size: 20,
                color: AppColors.neutral40,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),

        // Phone Number Input Field
        Expanded(
          child: TextFormField(
            controller: phoneNumberController,
            maxLength: 9,
            keyboardType: TextInputType.phone,
            onTap: viewModel.setPhoneNumberFocus,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.neutral14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Aeonik',
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              hintText: '9X XXX XXXX',
              hintStyle: TextStyle(
                fontSize: 13.5,
                color: AppColors.neutral40.withValues(alpha: 0.5),
                fontFamily: 'Aeonik',
                letterSpacing: 0.5,
              ),
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              counterText: '${phoneNumberController.text.length}/9',
              counterStyle: const TextStyle(
                fontSize: 11,
                color: AppColors.neutral40,
                fontWeight: FontWeight.w600,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: AppColors.neutral84.withValues(alpha: 0.7),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: AppColors.neutral84.withValues(alpha: 0.7),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: AppColors.magenta38,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
