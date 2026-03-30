import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/smart_auth_service.dart';
import 'package:yimaru_app/ui/widgets/custom_cursor.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/large_app_bar.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../login_view.form.dart';
import '../login_viewmodel.dart';

class LoginOtpScreen extends ViewModelWidget<LoginViewModel> {
  final TextEditingController otpController;
  final TextEditingController phoneNumberController;

  const LoginOtpScreen(
      {super.key,
      required this.otpController,
      required this.phoneNumberController});

  Widget getPadding(context) {
    double half = screenHeight(context) / 2;
    return SizedBox(
      height: half + 325 - half,
    );
  }

  Future<void> _verifyOtp(LoginViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();
    Map<String, dynamic> data = {
      'otp': otpController.text,
      'phone_number': '251${phoneNumberController.text}',
    };

    viewModel.clearUserData();
    viewModel.addUserData(data);

    await viewModel.verifyOtp();
  }

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldStack(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldStack(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      Stack(
        children: [
          _buildScaffold(context: context, viewModel: viewModel),
          _buildVerifyOtpState(viewModel)
        ],
      );

  Widget _buildScaffold(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            _buildScaffoldChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildScaffoldChildren(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      [
        _buildAppBar(viewModel),
        verticalSpaceMedium,
        _buildExpandedBody(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBar(LoginViewModel viewModel) => const LargeAppBar(
        showBackButton: false,
        showLanguageSelection: true,
      );

  Widget _buildExpandedBody(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      Expanded(
          child: _buildColumnScroller(context: context, viewModel: viewModel));

  Widget _buildColumnScroller(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildBodyWrapper(context: context, viewModel: viewModel),
      );

  Widget _buildBodyWrapper(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(context: context, viewModel: viewModel),
      );

  Widget _buildBody(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyChildren(
          {required BuildContext context, required LoginViewModel viewModel}) =>
      [
        _buildUpperColumn(viewModel),
        getPadding(context),
        _buildContinueButtonWrapper(viewModel)
      ];

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
        length: 6,
        controller: otpController,
        defaultPinTheme: defaultPin,
        cursor: const CustomCursor(),
        errorPinTheme: errorPinTheme,
        onTap: viewModel.setOtpFocus,
        focusNode: viewModel.focusNode,
        errorTextStyle: validationStyle,
        focusedPinTheme: focusedThemePin,
        submittedPinTheme: submittedThemePin,
        smsRetriever: locator<SmartAuthService>(),
        separatorBuilder: (index) => horizontalSpaceSmall,
        hapticFeedbackType: HapticFeedbackType.heavyImpact,
        onCompleted: (otp) async => await _verifyOtp(viewModel),
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
      : _buildResendButton(viewModel);

  Widget _buildResendButton(LoginViewModel viewModel) => TextButton(
      onPressed: () async => await viewModel.resendOtp(),
      style:
          const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
      child: _buildResendText());

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
        colonsTextStyle: style14P400,
        endTime: viewModel.resendTime,
        onEnd: viewModel.setResendButton,
        format: CountDownTimerFormat.minutesSeconds,
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
        backgroundColor:
            otpController.text.length == 6 && !viewModel.hasOtpValidationMessage
                ? kcPrimaryColor
                : kcPrimaryColor.withOpacity(0.1),
        onTap:
            otpController.text.length == 6 && !viewModel.hasOtpValidationMessage
                ? () async => await _verifyOtp(viewModel)
                : null,
      );

  Widget _buildVerifyOtpState(LoginViewModel viewModel) =>
      viewModel.busy(StateObjects.verifyOtp)
          ? const PageLoadingIndicator()
          : Container();
}
