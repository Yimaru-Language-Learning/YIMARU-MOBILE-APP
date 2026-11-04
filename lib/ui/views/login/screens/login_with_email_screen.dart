import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/login/login_viewmodel.dart';
import '../login_view.form.dart';
import 'package:yimaru_app/ui/widgets/auth_header.dart';
import 'package:yimaru_app/ui/widgets/option_text_divider.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';

class LoginWithEmailScreen extends ViewModelWidget<LoginViewModel> {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginWithEmailScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  Future<void> _login(LoginViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'email': emailController.text,
      'password': passwordController.text,
    };
    viewModel.addUserData(data);

    await viewModel.loginWithEmail();
  }

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    final bool isFilled = emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFF6E1665),
      body: Stack(
        children: [
          Column(
            children: [
              AuthHeader(
                showBackButton: false,
                onLanguage: () async => await viewModel.navigateToLanguage(),
                languageCode: viewModel.selectedLanguage['code'],
                speechTitle: 'ሰላም!',
                speechSubtitle: 'Good to see you again.',
                mascotAsset: 'assets/images/mascot/yimi-hello.svg',
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
                          LocaleKeys.welcome_back.tr(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.neutral14,
                            fontFamily: 'Aeonik',
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Subtitle Link: Don't have an account? Register
                        Row(
                          children: [
                            Text(
                              '${LocaleKeys.dont_have_account.tr()} ',
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
                                  await viewModel.navigateToRegister(),
                              child: Text(
                                LocaleKeys.register.tr(),
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
                        const SizedBox(height: 22),

                        // Email Field
                        _buildFieldLabel(LocaleKeys.email.tr()),
                        const SizedBox(height: 7),
                        _buildEmailField(viewModel),
                        if (viewModel.hasEmailValidationMessage &&
                            viewModel.focusEmail) ...[
                          const SizedBox(height: 4),
                          Text(
                            viewModel.emailValidationMessage!,
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: Color(0xFFE53935),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),

                        // Password Field
                        _buildFieldLabel(LocaleKeys.password.tr()),
                        const SizedBox(height: 7),
                        _buildPasswordField(viewModel),
                        if (viewModel.hasPasswordValidationMessage &&
                            viewModel.focusPassword) ...[
                          const SizedBox(height: 4),
                          Text(
                            viewModel.passwordValidationMessage!,
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: Color(0xFFE53935),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),

                        // Forgot Password Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async =>
                                await viewModel.navigateToForgetPassword(),
                            child: Text(
                              LocaleKeys.forgot_password.tr(),
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.magenta38,
                                fontFamily: 'Aeonik',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),

                        // Continue Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed:
                                isFilled ? () async => await _login(viewModel) : null,
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
                                color: isFilled
                                    ? Colors.white
                                    : AppColors.magenta38
                                        .withValues(alpha: 0.45),
                                fontFamily: 'Aeonik',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Login with Google Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () async =>
                                await viewModel.signInWithGoogle(),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                color: AppColors.neutral84.withValues(alpha: 0.7),
                                width: 1.2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/google.png',
                                  width: 18,
                                  height: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  LocaleKeys.login_with_google.tr(),
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.neutral14,
                                    fontFamily: 'Aeonik',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // "Or" Divider
                        const OptionTextDivider(),
                        const SizedBox(height: 18),

                        // Login with Phone Number Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () => viewModel.goTo(1),
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
                                  Icons.phone_outlined,
                                  size: 18,
                                  color: AppColors.magenta38,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  LocaleKeys.login_with_phone.tr(),
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

          // Loading Overlays
          if (viewModel.busy(StateObjects.loginWithEmail) ||
              viewModel.busy(StateObjects.loginWithGoogle))
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

  Widget _buildEmailField(LoginViewModel viewModel) {
    return TextFormField(
      controller: emailController,
      onTap: viewModel.setEmailFocus,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.neutral14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Aeonik',
      ),
      decoration: InputDecoration(
        hintText: 'you@example.com',
        hintStyle: TextStyle(
          fontSize: 13.5,
          color: AppColors.neutral40.withValues(alpha: 0.6),
          fontFamily: 'Aeonik',
        ),
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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

  Widget _buildPasswordField(LoginViewModel viewModel) {
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
      decoration: InputDecoration(
        hintText: 'Your password',
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
}
