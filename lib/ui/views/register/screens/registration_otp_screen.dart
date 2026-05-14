import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/register/register_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_cursor.dart';

import '../../../../app/app.locator.dart';
import '../../../../services/smart_auth_service.dart';
import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/large_app_bar.dart';
import '../../../widgets/page_loading_indicator.dart';
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

  Widget getPadding(context) {
    double half = screenHeight(context) / 2;
    return SizedBox(height: half + 325 - half);
  }

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
  Widget build(BuildContext context, RegisterViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldStack(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldStack(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      Stack(
        children: [
          _buildScaffold(context: context, viewModel: viewModel),
          _buildVerifyOtpState(viewModel)
        ],
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            _buildScaffoldChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildScaffoldChildren(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      [
        _buildAppBar(viewModel),
        verticalSpaceMedium,
        _buildExpandedBody(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBar(RegisterViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        onPop: viewModel.goBack,
        showLanguageSelection: true,
        language: viewModel.selectedLanguage['code'],
        onLanguage: () async => await viewModel.navigateToLanguage(),
      );

  Widget _buildExpandedBody(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      Expanded(
          child: _buildColumnScroller(context: context, viewModel: viewModel));

  Widget _buildColumnScroller(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildBodyWrapper(context: context, viewModel: viewModel),
      );

  Widget _buildBodyWrapper(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(context: context, viewModel: viewModel),
      );

  Widget _buildBody(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyChildren(
          {required BuildContext context,
          required RegisterViewModel viewModel}) =>
      [
        _buildUpperColumn(viewModel),
        getPadding(context),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildUpperColumn(RegisterViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(RegisterViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildSubtitleWrapper(viewModel),
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

  Widget _buildSubtitleWrapper(RegisterViewModel viewModel) =>
      viewModel.signUpMethod == SignUpMethod.email
          ? _buildEmailSubtitleWrapper()
          : _buildPhoneSubtitleWrapper();

  Widget _buildPhoneSubtitleWrapper() => phoneNumberController.text.length == 9
      ? _buildPhoneSubtitle()
      : Container();

  Widget _buildPhoneSubtitle() => Text(
        'Code sent to your number +251${phoneNumberController.text.substring(0, 5)}****',
        softWrap: false,
        style: style14DG400,
      );

  Widget _buildEmailSubtitleWrapper() =>
      emailController.text.isNotEmpty ? _buildEmailSubtitle() : Container();

  Widget _buildEmailSubtitle() => Text(
        'Code sent to your number email ${emailController.text.substring(0, 3)}****${emailController.text.split('@').last}',
        softWrap: false,
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
        focusedPinTheme: focusedThemePin,
        submittedPinTheme: submittedThemePin,
        smsRetriever: locator<SmartAuthService>(),
        separatorBuilder: (index) => horizontalSpaceSmall,
        hapticFeedbackType: HapticFeedbackType.heavyImpact,
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

  Widget _buildResendButton(RegisterViewModel viewModel) => GestureDetector(
      onTap: () async => await viewModel.resendOtp(),
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
        colonsTextStyle: style14P400,
        endTime: viewModel.resendTime,
        onEnd: viewModel.setResendButton,
        format: CountDownTimerFormat.minutesSeconds,
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

  Widget _buildVerifyOtpState(RegisterViewModel viewModel) =>
      viewModel.busy(StateObjects.verifyOtp)
          ? const PageLoadingIndicator()
          : Container();
}
