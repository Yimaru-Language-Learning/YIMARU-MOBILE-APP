import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';

import 'package:yimaru_app/ui/views/register/register_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_cursor.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';

import '../register_view.form.dart';

class RegistrationOtpScreen extends ViewModelWidget<RegisterViewModel> {
  final TextEditingController otpController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;

  const RegistrationOtpScreen(
      {super.key,
      required this.otpController,
      required this.emailController,
      required this.phoneNumberController});

  Future<void> _verifyOtp(RegisterViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'otp': otpController.text,
      'email': emailController.text,
    };
    viewModel.clearUserData();
    viewModel.addUserData(data);

    await viewModel.verifyOtp();
  }

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(RegisterViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(RegisterViewModel viewModel) =>
      [_buildColumnScroller(viewModel), _buildContinueButtonWrapper(viewModel)];

  Widget _buildColumnScroller(RegisterViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildUpperColumn(viewModel),
      );

  Widget _buildUpperColumn(RegisterViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(RegisterViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildSubtitleWrapper(),
        verticalSpaceMedium,
        _buildPinPutWrapper(viewModel),
        if (viewModel.hasOtpValidationMessage && viewModel.focusOtp)
          verticalSpaceTiny,
        if (viewModel.hasOtpValidationMessage && viewModel.focusOtp)
          _buildOtpValidatorWrapper(viewModel),
        verticalSpaceSmall,
        _buildTimerWrapper(viewModel)
      ];

  Widget _buildTitle() => Text(
        'Verification Code',
        style: style25DG600,
      );

  Widget _buildSubtitleWrapper() =>
      phoneNumberController.text.length == 9 ? _buildSubtitle() : Container();

  Widget _buildSubtitle() => Text(
        'Code sent to your number +251${phoneNumberController.text.substring(0, 5)}****',
        style: style14DG400,
      );

  Widget _buildPinPutWrapper(RegisterViewModel viewModel) => Center(
        child: _buildPinPut(viewModel),
      );

  Widget _buildPinPut(RegisterViewModel viewModel) => Pinput(
        length: 6,
        controller: otpController,
        defaultPinTheme: defaultPin,
        cursor: const CustomCursor(),
        errorPinTheme: errorPinTheme,
        onTap: viewModel.setOtpFocus,
        focusNode: viewModel.focusNode,
        errorTextStyle: validationStyle,
        //smsRetriever: locator<KewedeSmsRetriever>(),
        focusedPinTheme: focusedThemePin,
        submittedPinTheme: submittedThemePin,
        hapticFeedbackType: HapticFeedbackType.heavyImpact,
        separatorBuilder: (index) => const SizedBox(width: 10),
        onCompleted: (otp) async => await _verifyOtp(viewModel),
      );

  Widget _buildOtpValidatorWrapper(RegisterViewModel viewModel) =>
      viewModel.hasOtpValidationMessage
          ? _buildOtpValidator(viewModel)
          : Container();

  Widget _buildOtpValidator(RegisterViewModel viewModel) => Text(
        viewModel.otpValidationMessage!,
        style: style12R700,
      );

  Widget _buildTimerWrapper(RegisterViewModel viewModel) =>
      !viewModel.buttonActive
          ? _buildTimerSection(viewModel)
          : _buildResendButton(viewModel);

  Widget _buildResendButton(RegisterViewModel viewModel) => TextButton(
      onPressed: () async => await viewModel.resendOtp(),
      child: _buildResendText());

  Widget _buildResendText() => Text(
        'Resend code',
        style: style14P600.copyWith(fontStyle: FontStyle.italic),
      );

  Widget _buildTimerSection(RegisterViewModel viewModel) => Row(
        children: [
          _buildCountdownText(),
          horizontalSpaceSmall,
          _buildTimer(viewModel)
        ],
      );

  Widget _buildCountdownText() => Text('Resend code in ', style: style14DG400);

  Widget _buildTimer(RegisterViewModel viewModel) => TimerCountdown(
        enableDescriptions: false,
        timeTextStyle: style14P600,
        endTime: viewModel.resendTime,
        onEnd: viewModel.setResendButton,
        format: CountDownTimerFormat.minutesSeconds,
        colonsTextStyle: const TextStyle(color: kcPrimaryColor),
      );

  Widget _buildContinueButtonWrapper(RegisterViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(RegisterViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor:
            otpController.text.length == 6 && !viewModel.hasOtpValidationMessage
                ? kcPrimaryColor
                : kcPrimaryColor.withOpacity(0.1),
        onTap:
            otpController.text.length == 6 && !viewModel.hasOtpValidationMessage
                ? () async => await _verifyOtp(viewModel)
                : null,
      );
}
