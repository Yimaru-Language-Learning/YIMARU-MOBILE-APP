import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';

import '../../../widgets/custom_circular_progress_indicator.dart';
import '../welcome_viewmodel.dart';

class ThirdWelcomeScreen extends ViewModelWidget<WelcomeViewModel> {
  const ThirdWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WelcomeViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(WelcomeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(WelcomeViewModel viewModel) => Stack(
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(WelcomeViewModel viewModel) =>
      [_buildBackground(), _buildColumnWrapper(), _buildSafeWrapper(viewModel)];

  Widget _buildBackground() => Image.asset(
        'assets/images/onboarding_3.png',
        fit: BoxFit.fill,
        width: double.maxFinite,
        height: double.maxFinite,
      );

  Widget _buildColumnWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildUpperColumnChildren(),
      );

  List<Widget> _buildUpperColumnChildren() => [
        verticalSpaceMassive,
        _buildIcon(),
        verticalSpaceMedium,
        _buildTitle(),
      ];

  Widget _buildIcon() => SvgPicture.asset(
        'assets/icons/logo.svg',
        height: 50,
      );

  Widget _buildTitle() => const Text(
        'Every conversation brings you closer to the life you want.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          color: kcWhite,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildSafeWrapper(WelcomeViewModel viewModel) =>
      SafeArea(child: _buildContinueButtonWrapper(viewModel));

  Widget _buildContinueButtonWrapper(WelcomeViewModel viewModel) => Align(
        alignment: Alignment.bottomCenter,
        child: _buildButtonContainer(viewModel),
      );

  Widget _buildButtonContainer(WelcomeViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 60, right: 50, left: 50),
        child: _buildContinueButtonState(viewModel),
      );

  Widget _buildContinueButtonState(WelcomeViewModel viewModel) =>
      viewModel.isBusy ? _buildIndicator() : _buildContinueButton(viewModel);

  Widget _buildIndicator() =>
      const CustomCircularProgressIndicator(color: kcWhite);

  Widget _buildContinueButton(WelcomeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Start Learning',
        backgroundColor: kcWhite,
        foregroundColor: kcPrimaryColor,
        trailingIcon: Icons.arrow_forward,
        onTap: () async => await viewModel.setFirstTimeInstall(),
      );
}
