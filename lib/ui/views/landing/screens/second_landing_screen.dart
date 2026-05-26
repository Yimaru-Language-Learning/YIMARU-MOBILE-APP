import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';

import '../../../widgets/custom_circular_progress_indicator.dart';
import '../landing_viewmodel.dart';

class SecondLandingScreen extends ViewModelWidget<LandingViewModel> {
  const SecondLandingScreen({super.key});

  @override
  Widget build(BuildContext context, LandingViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LandingViewModel viewModel) => Scaffold(
        backgroundColor: Colors.amber,
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
        color: kcPrimaryColor,
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
        'assets/images/landing_2.jpg',
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
        text: 'Next',
        borderRadius: 25,
        onTap: viewModel.next,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}
