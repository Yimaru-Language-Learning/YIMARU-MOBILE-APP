import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';

import 'package:yimaru_app/ui/widgets/custom_cursor.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../login_viewmodel.dart';
import '../login_view.form.dart';

class LoginOtpScreen extends ViewModelWidget<LoginViewModel> {
  final TextEditingController otpController;
  final TextEditingController phoneNumberController;

  const LoginOtpScreen(
      {super.key,
      required this.otpController,
      required this.phoneNumberController});

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(LoginViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(LoginViewModel viewModel) =>
      [_buildColumnScroller(viewModel), _buildContinueButtonWrapper(viewModel)];

  Widget _buildColumnScroller(LoginViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildUpperColumn(viewModel),
      );

  Widget _buildUpperColumn(LoginViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(LoginViewModel viewModel) => [
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

  Widget _buildPinPutWrapper(LoginViewModel viewModel) => Center(
        child: _buildPinPut(viewModel),
      );

  Widget _buildPinPut(LoginViewModel viewModel) => Pinput(
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
        separatorBuilder: (index) => const SizedBox(width: 25),
        onCompleted: (otp) async => await viewModel.validateOtp(otp),
      );

  Widget _buildOtpValidatorWrapper(LoginViewModel viewModel) =>
      viewModel.hasOtpValidationMessage
          ? _buildOtpValidator(viewModel)
          : Container();

  Widget _buildOtpValidator(LoginViewModel viewModel) => Text(
        viewModel.otpValidationMessage!,
        style: style12R700,
      );

  Widget _buildTimerWrapper(LoginViewModel viewModel) => !viewModel.buttonActive
      ? _buildTimerSection(viewModel)
      : _buildResendButton();

  Widget _buildResendButton() =>
      TextButton(onPressed: () {}, child: _buildResendText());

  Widget _buildResendText() => Text(
        'Resend code',
        style: style14P600.copyWith(fontStyle: FontStyle.italic),
      );

  Widget _buildTimerSection(LoginViewModel viewModel) => Row(
        children: [
          _buildCountdownText(),
          horizontalSpaceSmall,
          _buildTimer(viewModel)
        ],
      );

  Widget _buildCountdownText() => Text('Resend code in ', style: style14DG400);

  Widget _buildTimer(LoginViewModel viewModel) => TimerCountdown(
        enableDescriptions: false,
        timeTextStyle: style14P600,
        endTime: DateTime.now().add(const Duration(minutes: 3, seconds: 0)),
        onEnd: viewModel.setResendButton,
        format: CountDownTimerFormat.minutesSeconds,
        colonsTextStyle: const TextStyle(color: kcPrimaryColor),
      );

  Widget _buildContinueButtonWrapper(LoginViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(LoginViewModel viewModel) => CustomElevatedButton(
        height: 55,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: viewModel.focusOtp &&
                otpController.text.length == 4 &&
                !viewModel.hasOtpValidationMessage
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
        onTap: viewModel.focusOtp &&
                otpController.text.length == 4 &&
                !viewModel.hasOtpValidationMessage
            ? () => viewModel.replaceWithHome()
            : null,
      );
}
