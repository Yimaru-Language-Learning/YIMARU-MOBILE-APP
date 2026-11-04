import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/smart_auth_service.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/register/register_viewmodel.dart';
import '../register_view.form.dart';
import 'package:yimaru_app/ui/widgets/auth_header.dart';
import 'package:yimaru_app/ui/widgets/custom_cursor.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';

class RegistrationOtpScreen extends ViewModelWidget<RegisterViewModel> {
  final TextEditingController otpController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;

  const RegistrationOtpScreen({
    super.key,
    required this.otpController,
    required this.emailController,
    required this.phoneNumberController,
  });

  Future<void> _verifyOtp(RegisterViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();
    Map<String, dynamic> data = {};
    if (viewModel.signUpMethod == SignUpMethod.email) {
      data = {
        'otp': otpController.text,
        'email': emailController.text,
      };
    } else {
      data = {
        'otp': otpController.text,
        'phone_number': '251${phoneNumberController.text}',
      };
    }
    viewModel.clearUserData();
    viewModel.addUserData(data);

    await viewModel.verifyOtp();
  }

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    final bool canSubmit = otpController.text.length == 6 &&
        !viewModel.hasOtpValidationMessage;

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
                toastMessage: 'Code sent successfully',
                customIllustration: _buildEnvelopeIllustration(),
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
                          LocaleKeys.verification_code.tr(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.neutral14,
                            fontFamily: 'Aeonik',
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Subtitle
                        _buildSubtitle(viewModel),
                        const SizedBox(height: 26),

                        // Pinput 6-digit Code Boxes
                        Center(
                          child: Pinput(
                            length: 6,
                            controller: otpController,
                            cursor: const CustomCursor(),
                            focusNode: viewModel.focusNode,
                            onTap: viewModel.setOtpFocus,
                            onCompleted: (_) async => await _verifyOtp(viewModel),
                            smsRetriever: locator<SmartAuthService>(),
                            defaultPinTheme: PinTheme(
                              width: 48,
                              height: 52,
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppColors.neutral14,
                                fontFamily: 'Aeonik',
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.neutral84.withValues(alpha: 0.8),
                                  width: 1.2,
                                ),
                              ),
                            ),
                            focusedPinTheme: PinTheme(
                              width: 48,
                              height: 52,
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppColors.magenta38,
                                fontFamily: 'Aeonik',
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.magenta38,
                                  width: 2,
                                ),
                              ),
                            ),
                            errorPinTheme: PinTheme(
                              width: 48,
                              height: 52,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF0F0),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFE53935),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            separatorBuilder: (_) => const SizedBox(width: 8),
                          ),
                        ),
                        if (viewModel.hasOtpValidationMessage &&
                            viewModel.focusOtp) ...[
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              viewModel.otpValidationMessage!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFFE53935),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 22),

                        // Countdown / Resend Section
                        _buildTimerSection(viewModel),
                        const SizedBox(height: 32),

                        // Continue Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: canSubmit
                                ? () async => await _verifyOtp(viewModel)
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Loading Overlay
          if (viewModel.busy(StateObjects.verifyOtp))
            const PageLoadingIndicator(),
        ],
      ),
    );
  }

  Widget _buildSubtitle(RegisterViewModel viewModel) {
    final String text;
    if (viewModel.signUpMethod == SignUpMethod.email &&
        emailController.text.isNotEmpty) {
      final parts = emailController.text.split('@');
      final prefix = emailController.text.length > 2
          ? emailController.text.substring(0, 2)
          : emailController.text;
      text = 'We sent a 6-digit code to $prefix******@${parts.length > 1 ? parts.last : ""}';
    } else if (phoneNumberController.text.length == 9) {
      final prefix = phoneNumberController.text.substring(0, 3);
      text = 'We sent a 6-digit code to +251 $prefix******';
    } else {
      text = 'We sent a 6-digit code to your account.';
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral40,
        fontFamily: 'Aeonik',
      ),
    );
  }

  Widget _buildTimerSection(RegisterViewModel viewModel) {
    if (viewModel.buttonActive) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async => await viewModel.resendOtp(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.refresh_rounded,
              size: 16,
              color: AppColors.magenta38,
            ),
            const SizedBox(width: 6),
            Text(
              LocaleKeys.resend_code.tr(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.magenta38,
                fontFamily: 'Aeonik',
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.schedule_rounded,
          size: 16,
          color: AppColors.neutral40,
        ),
        const SizedBox(width: 6),
        Text(
          '${LocaleKeys.resend_code_in.tr()} ',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.neutral40,
            fontFamily: 'Aeonik',
          ),
        ),
        TimerCountdown(
          enableDescriptions: false,
          timeTextStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.magenta38,
            fontFamily: 'Aeonik',
          ),
          colonsTextStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.magenta38,
            fontFamily: 'Aeonik',
          ),
          endTime: viewModel.resendTime,
          onEnd: viewModel.setResendButton,
          format: CountDownTimerFormat.minutesSeconds,
        ),
      ],
    );
  }

  Widget _buildEnvelopeIllustration() {
    return SizedBox(
      height: 110,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // White envelope
            Container(
              width: 120,
              height: 74,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.14),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Envelope Flap
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                      size: const Size(120, 36),
                      painter: _EnvelopeFlapPainter(),
                    ),
                  ),
                ],
              ),
            ),

            // Top Right Checkmark Badge
            Positioned(
              top: -6,
              right: -6,
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3322C55E),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EnvelopeFlapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
