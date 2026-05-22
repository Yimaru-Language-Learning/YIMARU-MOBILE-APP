import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';

import '../../../widgets/custom_circular_progress_indicator.dart';
import '../landing_viewmodel.dart';

class FirstLandingScreen extends ViewModelWidget<LandingViewModel> {
  const FirstLandingScreen({super.key});

  @override
  Widget build(BuildContext context, LandingViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LandingViewModel viewModel) => Scaffold(
        backgroundColor: kcPrimaryColor,
        body: _buildScaffoldPadding(viewModel),
      );
  Widget _buildScaffoldPadding(LandingViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LandingViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(LandingViewModel viewModel) =>
      [_buildUpperColumn(), _buildLowerColumnWrapper(viewModel)];

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
        'assets/icons/logo.svg',
        height: 25,
      );

  Widget _buildLowerColumnWrapper(LandingViewModel viewModel) => Expanded(
        child: _buildLowerColumn(viewModel),
      );

  Widget _buildLowerColumn(LandingViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildLowerColumnChildren(viewModel),
      );

  List<Widget> _buildLowerColumnChildren(LandingViewModel viewModel) => [
        _buildTitle(),
        verticalSpaceMedium,
        _buildImageWrapper(),
        verticalSpaceMedium,
        _buildSafeWrapper(viewModel)
      ];

  Widget _buildTitle() => Text.rich(
        TextSpan(
          text: 'እንግሊዝኛ\n',
          style: style25W600,
          children: [
            TextSpan(
              text: 'በማንኛውም',
              style: style25W400,
            ),
            TextSpan(
              text: ' ሰዓት ',
              style: style25W600,
            ),
            TextSpan(
              text: 'ይማሩ!',
              style: style25W400,
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
        'assets/images/landing_1.jpg',
        fit: BoxFit.cover,
      );

  Widget _buildSafeWrapper(LandingViewModel viewModel) =>
      SafeArea(child: _buildContinueButtonWrapper(viewModel));

  Widget _buildContinueButtonWrapper(LandingViewModel viewModel) => Align(
        alignment: Alignment.bottomCenter,
        child: _buildButtonContainer(viewModel),
      );

  Widget _buildButtonContainer(LandingViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButtonState(viewModel),
      );

  Widget _buildContinueButtonState(LandingViewModel viewModel) =>
      viewModel.isBusy ? _buildIndicator() : _buildContinueButton(viewModel);

  Widget _buildIndicator() =>
      const CustomCircularProgressIndicator(color: kcWhite);

  Widget _buildContinueButton(LandingViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 25,
        text: 'Get Started',
        backgroundColor: kcWhite,
        foregroundColor: kcPrimaryColor,
        onTap: () async => await viewModel.setFirstTimeInstall(),
      );
}
