import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:toastification/toastification.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

const double _tinySize = 5.0;
const double _smallSize = 10.0;
const double _mediumSize = 25.0;
const double _largeSize = 50.0;
const double _massiveSize = 120.0;

const Widget horizontalSpaceTiny = SizedBox(width: _tinySize);
const Widget horizontalSpaceSmall = SizedBox(width: _smallSize);
const Widget horizontalSpaceMedium = SizedBox(width: _mediumSize);
const Widget horizontalSpaceLarge = SizedBox(width: _largeSize);

const Widget verticalSpaceTiny = SizedBox(height: _tinySize);
const Widget verticalSpaceSmall = SizedBox(height: _smallSize);
const Widget verticalSpaceMedium = SizedBox(height: _mediumSize);
const Widget verticalSpaceLarge = SizedBox(height: _largeSize);
const Widget verticalSpaceMassive = SizedBox(height: _massiveSize);

Widget spacedDivider = const Column(
  children: <Widget>[
    verticalSpaceMedium,
    Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double buttonAlignment(BuildContext context) =>
    MediaQuery.of(context).size.height * 0.9;

double screenHeightFraction(
  BuildContext context, {
  int dividedBy = 1,
  double offsetBy = 0,
  double max = 3000,
}) =>
    min((screenHeight(context) - offsetBy) / dividedBy, max);

double screenWidthFraction(
  BuildContext context, {
  int dividedBy = 1,
  double offsetBy = 0,
  double max = 3000,
}) =>
    min((screenWidth(context) - offsetBy) / dividedBy, max);

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

double quarterScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 4);

double getResponsiveHorizontalSpaceMedium(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 10);

double getResponsiveSmallFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 14, max: 15);

double getResponsiveMediumFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 16, max: 17);

double getResponsiveLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 21, max: 31);

double getResponsiveExtraLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 25);

double getResponsiveMassiveFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 30);

double getResponsiveFontSize(
  BuildContext context, {
  double? fontSize,
  double? max,
}) {
  max ??= 100;

  var responsiveSize = min(
    screenWidthFraction(context, dividedBy: 10) * ((fontSize ?? 100) / 100),
    max,
  );

  return responsiveSize;
}

InputDecoration inputDecoration(
        {String? hint,
        Widget? suffix,
        required bool focus,
        required bool filled}) =>
    InputDecoration(
      filled: true,
      hintText: hint,
      border: border,
      suffixIcon: suffix,
      errorBorder: errorBorder,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      fillColor: focus || filled ? kcPrimaryColor.withOpacity(0.1) : kcWhite,
    );

Border rightBorder = Border(
  right: BorderSide(
    width: 1,
    color: kcLightGrey.withOpacity(0.25),
  ),
);

DateFormat format = DateFormat("d MMM, yyyy");

OutlineInputBorder border =
    const OutlineInputBorder(borderSide: BorderSide(color: kcPrimaryColor));
OutlineInputBorder errorBorder =
    const OutlineInputBorder(borderSide: BorderSide(color: kcPrimaryColor));
OutlineInputBorder enabledBorder =
    const OutlineInputBorder(borderSide: BorderSide(color: kcPrimaryColor));
OutlineInputBorder focusedBorder =
    const OutlineInputBorder(borderSide: BorderSide(color: kcPrimaryColor));

UnderlineInputBorder searchBorder =
    const UnderlineInputBorder(borderSide: BorderSide(color: kcPrimaryColor));

TextStyle defaultPinTextStyle = const TextStyle(
  fontSize: 22,
  color: kcDarkGrey,
);

BoxDecoration defaultPinDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(19),
  border: Border.all(
    color: kcPrimaryColor.withOpacity(0.5),
  ),
);

PinTheme defaultPin = PinTheme(
  width: 56,
  height: 56,
  textStyle: defaultPinTextStyle,
  decoration: defaultPinDecoration,
);

PinTheme focusedThemePin = defaultPin.copyWith(
  decoration: defaultPin.decoration?.copyWith(
    border: Border.all(color: kcPrimaryColor, width: 3),
  ),
);

PinTheme submittedThemePin = defaultPin.copyWith(
  decoration: defaultPin.decoration?.copyWith(
    borderRadius: BorderRadius.circular(19),
    border: Border.all(color: kcPrimaryColor),
  ),
);

PinTheme errorPinTheme = defaultPin.copyBorderWith(
  border: Border.all(color: Colors.red),
);

TextStyle style18P600 = const TextStyle(
  fontSize: 18,
  color: kcPrimaryColor,
  fontWeight: FontWeight.w600,
);

TextStyle style16W600 = const TextStyle(
  fontSize: 16,
  color: kcWhite,
  fontWeight: FontWeight.w600,
);

TextStyle style18W600 = const TextStyle(
  fontSize: 18,
  color: kcWhite,
  fontWeight: FontWeight.w600,
);

TextStyle style25W600 = const TextStyle(
  fontSize: 25,
  color: kcWhite,
  fontWeight: FontWeight.w600,
);

TextStyle style12RP600 = const TextStyle(
  fontSize: 12,
  color: kcPrimaryColor,
  fontWeight: FontWeight.w600,
);

TextStyle style12R700 = const TextStyle(
  fontSize: 12,
  color: Colors.red,
  fontWeight: FontWeight.w700,
);

TextStyle style12P400 = const TextStyle(
  fontSize: 12,
  color: kcPrimaryColor,
);

TextStyle style12DG400 = const TextStyle(
  fontSize: 12,
  color: kcDarkGrey,
);

TextStyle style14P400 = const TextStyle(
  color: kcPrimaryColor,
);

TextStyle style14B400 = const TextStyle(
  color: kcBlue,
);

TextStyle style14P600 = const TextStyle(
  color: kcPrimaryColor,
  fontWeight: FontWeight.w600,
);

TextStyle style25P600 = const TextStyle(
  fontSize: 25,
  color: kcPrimaryColor,
  fontWeight: FontWeight.w600,
);

TextStyle style25DG600 = const TextStyle(
  fontSize: 25,
  color: kcDarkGrey,
  fontWeight: FontWeight.w600,
);

TextStyle style16P600 = const TextStyle(
  fontSize: 16,
  color: kcPrimaryColor,
  fontWeight: FontWeight.w600,
);

TextStyle style16DG500 = const TextStyle(
  fontSize: 16,
  color: kcDarkGrey,
);

TextStyle style16DG600 = const TextStyle(
  fontSize: 16,
  color: kcDarkGrey,
  fontWeight: FontWeight.w600,
);

TextStyle style16B600 = const TextStyle(
  fontSize: 16,
  color: kcBlue,
  fontWeight: FontWeight.w600,
);

TextStyle style18DG500 = const TextStyle(
  fontSize: 18,
  color: kcDarkGrey,
  fontWeight: FontWeight.w500,
);

TextStyle style18DG600 = const TextStyle(
  fontSize: 18,
  color: kcDarkGrey,
  fontWeight: FontWeight.w600,
);

TextStyle style18G700 = const TextStyle(
  fontSize: 18,
  color: kcDeepGreen,
  fontWeight: FontWeight.w700,
);

TextStyle style18DG700 = const TextStyle(
  fontSize: 18,
  color: kcDarkGrey,
  fontWeight: FontWeight.w700,
);

TextStyle style20DG700 = const TextStyle(
  fontSize: 20,
  color: kcDarkGrey,
  fontWeight: FontWeight.w700,
);

TextStyle style16DG400 = const TextStyle(
  fontSize: 16,
  color: kcDarkGrey,
);

TextStyle style14LG400 = const TextStyle(
  color: kcLightGrey,
);

TextStyle style14MG400 = const TextStyle(
  color: kcMediumGrey,
);
TextStyle style14DG500 =
    const TextStyle(color: kcDarkGrey, fontWeight: FontWeight.w500);

TextStyle style18MG500 =
const TextStyle(fontSize: 18,color: kcMediumGrey, fontWeight: FontWeight.w500);


TextStyle style14DG400 = const TextStyle(
  color: kcDarkGrey,
);

TextStyle style14DG600 = const TextStyle(
  color: kcDarkGrey,
  fontWeight: FontWeight.w600,
);

TextStyle validationStyle = const TextStyle(
  fontSize: 12,
  color: Colors.red,
  fontWeight: FontWeight.w700,
);

Duration kDuration = const Duration(seconds: 1);

Style htmlDefaultStyle = Style(color: kcDarkGrey, fontSize: FontSize(16));

Map<String, Style> htmlStyle = {
  "p": htmlDefaultStyle,
  "h1": htmlDefaultStyle,
  "h2": htmlDefaultStyle,
  "h3": htmlDefaultStyle,
  "h4": htmlDefaultStyle,
  "h5": htmlDefaultStyle,
  "h6": htmlDefaultStyle,
  "li": Style(
    color: kcDarkGrey,
    margin: Margins.zero,
    fontSize: FontSize(16),
    padding: HtmlPaddings.zero,
    fontWeight: FontWeight.w400,
    listStyleType: ListStyleType.circle,
    verticalAlign: VerticalAlign.baseline,
  ),
};

ChewieProgressColors buildChewieProgressIndicator = ChewieProgressColors(
  bufferedColor: kcIndigo,
  playedColor: kcPrimaryColor,
  backgroundColor: kcBackgroundColor,
);

Widget buildToastDescription(String message) => Text(
      message,
      maxLines: 4,
      style: style14DG500,
    );

Icon buildCloseIcon() => const Icon(
      Icons.close,
      color: kcPrimaryColor,
    );

void showErrorToast(String message) {
  toastification.show(
    showIcon: true,
    dragToClose: true,
    icon: buildCloseIcon(),
    showProgressBar: false,
    applyBlurEffect: false,
    alignment: Alignment.topCenter,
    primaryColor: kcBackgroundColor,
    type: ToastificationType.success,
    style: ToastificationStyle.fillColored,
    description: buildToastDescription(message),
    autoCloseDuration: const Duration(seconds: 3),
    margin: const EdgeInsets.symmetric(horizontal: 15),
    borderSide: const BorderSide(color: kcPrimaryColor),
  );
}

Icon buildCheckIcon() => const Icon(
      Icons.check,
      color: kcPrimaryColor,
    );

void showSuccessToast(String message) {
  toastification.show(
    showIcon: true,
    dragToClose: true,
    showProgressBar: false,
    applyBlurEffect: false,
    icon: buildCheckIcon(),
    alignment: Alignment.topCenter,
    primaryColor: kcBackgroundColor,
    type: ToastificationType.success,
    style: ToastificationStyle.fillColored,
    description: buildToastDescription(message),
    autoCloseDuration: const Duration(seconds: 3),
    margin: const EdgeInsets.symmetric(horizontal: 15),
    borderSide: const BorderSide(color: kcPrimaryColor),
  );
}
