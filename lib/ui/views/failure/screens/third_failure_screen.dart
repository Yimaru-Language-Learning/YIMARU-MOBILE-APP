import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/failure/failure_viewmodel.dart';

class ThirdFailureScreen extends ViewModelWidget<FailureViewModel> {
  final String label;
  final GestureTapCallback onTap;

  const ThirdFailureScreen(
      {super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context, FailureViewModel viewModel) =>
      _buildScaffoldWrapper();

  Widget _buildScaffoldWrapper() => Scaffold(
        
        backgroundColor: kcWhite,
        body: _buildScaffoldPadding(),
      );
  Widget _buildScaffoldPadding() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildScaffold(),
      );

  Widget _buildScaffold() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildScaffoldChildren(),
      );

  List<Widget> _buildScaffoldChildren() =>
      [_buildUpperColumn(), _buildLowerColumnWrapper()];

  Widget _buildUpperColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildUpperColumnChildren(),
      );

  List<Widget> _buildUpperColumnChildren() =>
      [verticalSpaceLarge, _buildIconWrapper(), verticalSpaceLarge];

  Widget _buildIconWrapper() => Align(
        alignment: Alignment.topLeft,
        child: _buildIcon(),
      );

  Widget _buildIcon() => SvgPicture.asset(
        'assets/icons/logo_purple.svg',
        height: 25,
      );

  Widget _buildLowerColumnWrapper() => Expanded(
        child: _buildLowerColumn(),
      );

  Widget _buildLowerColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildLowerColumnChildren(),
      );

  List<Widget> _buildLowerColumnChildren() => [
        _buildTitle(),
        verticalSpaceMedium,
        _buildImageWrapper(),
        verticalSpaceMedium,
        _buildSafeWrapper()
      ];

  Widget _buildTitle() => Text.rich(
        TextSpan(
          text: '${LocaleKeys.english.tr()}\n',
          style: style25P600,
          children: [
            TextSpan(
              text: LocaleKeys.at_any.tr(),
              style: style25P400,
            ),
            TextSpan(
              text: ' ${LocaleKeys.place.tr()} ',
              style: style25P600,
            ),
            TextSpan(
              text: LocaleKeys.learn_exclamation.tr(),
              style: style25P400,
            ),
          ],
        ),
      );

  Widget _buildImageWrapper() => Expanded(child: _buildImageClipper());

  Widget _buildImageClipper() => ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: _buildImage(),
      );

  Widget _buildImage() => Image.asset(
        'assets/images/landing_3.png',
        fit: BoxFit.cover,
      );

  Widget _buildSafeWrapper() => SafeArea(child: _buildContinueButtonWrapper());

  Widget _buildContinueButtonWrapper() => Align(
        alignment: Alignment.bottomCenter,
        child: _buildLoadingTextContainer(),
      );

  Widget _buildLoadingTextContainer() => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildLoadingTextWrapper(),
      );

  Widget _buildLoadingTextWrapper() => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildLoadingTextChildren(),
      );

  List<Widget> _buildLoadingTextChildren() =>
      [_buildLoadingText(), horizontalSpaceSmall, _buildRetryButtonWrapper()];

  Widget _buildLoadingText() => Text('$label...', style: style16P600);

  Widget _buildRetryButtonWrapper() => GestureDetector(
        onTap: onTap,
        child: _buildRetryButton(),
      );

  Widget _buildRetryButton() => Text(
        LocaleKeys.retry.tr(),
        style: style16P600.copyWith(
            fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
      );
}
