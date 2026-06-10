import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/failure/failure_viewmodel.dart';

import '../../../widgets/custom_circular_progress_indicator.dart';

class SecondFailureScreen extends ViewModelWidget<FailureViewModel> {
  final String label;
  final GestureTapCallback onTap;

  const SecondFailureScreen(
      {super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context, FailureViewModel viewModel) =>
      _buildScaffoldWrapper();

  Widget _buildScaffoldWrapper() => Scaffold(
        backgroundColor: Colors.amber,
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
          text: 'እንግሊዝኛ\n',
          style: style25P600,
          children: [
            TextSpan(
              text: 'በማንኛውም',
              style: style25P400,
            ),
            TextSpan(
              text: ' እድሜ ',
              style: style25P600,
            ),
            TextSpan(
              text: 'ይማሩ!',
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
        'assets/images/landing_2.png',
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

  List<Widget> _buildLoadingTextChildren() => [
        _buildLoadingText(),
        horizontalSpaceSmall,
        _buildIndicatorWrapper(),
        verticalSpaceSmall,
        _buildRetryButtonWrapper()
      ];

  Widget _buildLoadingText() => Text('$label...', style: style16P600);

  Widget _buildIndicatorWrapper() => SizedBox(
        width: 16,
        height: 16,
        child: _buildIndicator(),
      );

  Widget _buildIndicator() =>
      const CustomCircularProgressIndicator(color: kcPrimaryColor);

  Widget _buildRetryButtonWrapper() => GestureDetector(
        onTap: onTap,
        child: _buildRetryButton(),
      );

  Widget _buildRetryButton() => Text(
        'Retry',
        style: style16P600.copyWith(
            fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
      );
}
