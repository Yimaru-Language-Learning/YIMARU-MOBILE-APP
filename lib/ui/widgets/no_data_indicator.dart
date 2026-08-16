import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class NoDataIndicator extends StatelessWidget {
  final String title;
  final GestureTapCallback? onPop;
  final GestureTapCallback? onRetry;

  const NoDataIndicator(
      {super.key, this.onPop, this.onRetry, required this.title});

  @override
  Widget build(BuildContext context) => _buildBodyWrapper();

  Widget _buildBodyWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(),
      );

  Widget _buildBody() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildBodyChildren(),
      );

  List<Widget> _buildBodyChildren() => [
        _buildIconWrapper(),
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildRetryButton(),
        verticalSpaceMedium,
        _buildPopButton()
      ];

  Widget _buildIconWrapper() => Transform.scale(
        scale: 2.5,
        child: _buildIcon(),
      );

  Widget _buildIcon() => SvgPicture.asset(
        'assets/icons/empty.svg',
        height: 200,
        alignment: Alignment.center,
      );

  Widget _buildTitle() => Text(
        title,
        style: style16P600,
      );

  Widget _buildSubtitle() => Text(
        'There is nothing to practice here yet. You can try again or go back to the previous page.',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildRetryButton() => CustomElevatedButton(
        height: 55,
        bottom: false,
        text: LocaleKeys.retry.tr(),
        onTap: onRetry,
        borderRadius: 12,
        leadingIcon: Icons.repeat,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildPopButton() => CustomElevatedButton(
        height: 55,
        top: false,
        bottom: false,
        onTap: onPop,
        borderRadius: 12,
        backgroundColor: kcWhite,
        text: LocaleKeys.go_back.tr(),
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        leadingIcon: Icons.arrow_back_ios_outlined,
      );
}
