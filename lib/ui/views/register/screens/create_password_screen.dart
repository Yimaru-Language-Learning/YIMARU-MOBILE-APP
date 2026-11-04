import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/register/register_viewmodel.dart';
import '../register_view.form.dart';
import 'package:yimaru_app/ui/widgets/auth_header.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';

class CreatePasswordScreen extends ViewModelWidget<RegisterViewModel> {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const CreatePasswordScreen({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  Future<void> _signUp(RegisterViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'role': 'STUDENT',
      'otp_medium': 'email',
      'password': passwordController.text,
    };
    viewModel.addUserData(data);

    await viewModel.registerWithEmail(SignUpMethod.email);
  }

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    final bool canSubmit = passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        viewModel.length &&
        viewModel.passwordMatch &&
        viewModel.agree;

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
                speechTitle: "Don't worry, I won't peek!",
                mascotAsset: 'assets/images/mascot/yimi-oops.svg',
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
                          LocaleKeys.create_password.tr(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.neutral14,
                            fontFamily: 'Aeonik',
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Password Field
                        _buildFieldLabel(LocaleKeys.password.tr()),
                        const SizedBox(height: 7),
                        _buildPasswordField(viewModel),
                        const SizedBox(height: 16),

                        // Confirm Password Field
                        _buildFieldLabel(LocaleKeys.confirm_password.tr()),
                        const SizedBox(height: 7),
                        _buildConfirmPasswordField(viewModel),
                        const SizedBox(height: 16),

                        // Strength Segmented Bar
                        _buildSegmentedStrengthBar(viewModel),
                        const SizedBox(height: 14),

                        // Check items
                        _buildValidationItem(
                          isValid: viewModel.length,
                          label: LocaleKeys.eight_character_minimum.tr(),
                        ),
                        const SizedBox(height: 8),
                        _buildValidationItem(
                          isValid: viewModel.passwordMatch,
                          label: LocaleKeys.password_match.tr(),
                        ),
                        const SizedBox(height: 18),

                        // Terms & Conditions Checkbox
                        _buildTermsCheckbox(viewModel),
                        const SizedBox(height: 24),

                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: canSubmit
                                ? () async => await _signUp(viewModel)
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
                              LocaleKeys.register.tr(),
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

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        color: AppColors.neutral14,
        fontFamily: 'Aeonik',
      ),
    );
  }

  Widget _buildPasswordField(RegisterViewModel viewModel) {
    return TextFormField(
      controller: passwordController,
      onTap: viewModel.setPasswordFocus,
      obscureText: viewModel.obscurePassword,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.neutral14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Aeonik',
      ),
      onChanged: (_) => viewModel.validatePassword(
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      ),
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(
          fontSize: 13.5,
          color: AppColors.neutral40.withValues(alpha: 0.6),
          fontFamily: 'Aeonik',
        ),
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        suffixIcon: IconButton(
          icon: Icon(
            viewModel.obscurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 20,
            color: AppColors.neutral40,
          ),
          onPressed: viewModel.setObscurePassword,
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
    );
  }

  Widget _buildConfirmPasswordField(RegisterViewModel viewModel) {
    return TextFormField(
      controller: confirmPasswordController,
      onTap: viewModel.setConfirmPasswordFocus,
      obscureText: viewModel.obscureConfirmPassword,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.neutral14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Aeonik',
      ),
      onChanged: (_) => viewModel.validatePassword(
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      ),
      decoration: InputDecoration(
        hintText: 'Confirm password',
        hintStyle: TextStyle(
          fontSize: 13.5,
          color: AppColors.neutral40.withValues(alpha: 0.6),
          fontFamily: 'Aeonik',
        ),
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        suffixIcon: IconButton(
          icon: Icon(
            viewModel.obscureConfirmPassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 20,
            color: AppColors.neutral40,
          ),
          onPressed: viewModel.setObscureConfirmPassword,
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
    );
  }

  Widget _buildSegmentedStrengthBar(RegisterViewModel viewModel) {
    int activeSegments = 0;
    if (viewModel.length) activeSegments += 2;
    if (viewModel.passwordMatch && passwordController.text.isNotEmpty) {
      activeSegments += 2;
    }

    return Row(
      children: List.generate(4, (index) {
        final bool isActive = index < activeSegments;
        final Color segmentColor = isActive
            ? (activeSegments >= 4
                ? const Color(0xFF22C55E)
                : AppColors.magenta38)
            : AppColors.neutral84.withValues(alpha: 0.5);

        return Expanded(
          child: Container(
            height: 4.5,
            margin: EdgeInsets.only(right: index < 3 ? 6 : 0),
            decoration: BoxDecoration(
              color: segmentColor,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildValidationItem({required bool isValid, required String label}) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: isValid
                ? const Color(0xFF22C55E)
                : AppColors.neutral93,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.check_rounded,
              size: 12,
              color: isValid ? Colors.white : AppColors.neutral40,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: isValid ? AppColors.neutral14 : AppColors.neutral40,
            fontFamily: 'Aeonik',
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox(RegisterViewModel viewModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 22,
          height: 22,
          child: Checkbox(
            value: viewModel.agree,
            activeColor: AppColors.magenta38,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            side: BorderSide(
              color: AppColors.neutral84,
              width: 1.5,
            ),
            onChanged: (val) => viewModel.setAgreement(val ?? false),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: 'I agree to the ',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.neutral40,
                fontFamily: 'Aeonik',
                height: 1.35,
              ),
              children: [
                TextSpan(
                  text: LocaleKeys.terms_of_services.tr(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.magenta38,
                    fontFamily: 'Aeonik',
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = viewModel.navigateToTermsAndConditions,
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: LocaleKeys.privacy_policy.tr(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.magenta38,
                    fontFamily: 'Aeonik',
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = viewModel.navigateToPrivacyPolicy,
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
