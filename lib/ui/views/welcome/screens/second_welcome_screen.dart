import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';

import '../welcome_viewmodel.dart';

class SecondWelcomeScreen extends ViewModelWidget<WelcomeViewModel> {
  const SecondWelcomeScreen({super.key});

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

  List<Widget> _buildScaffoldChildren(WelcomeViewModel viewModel) => [
        _buildBackground(),
        _buildColumnWrapper(),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildBackground() => Image.asset(
        'assets/images/onboarding_2.png',
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
        'Start speaking, Confidence will follow.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          color: kcWhite,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildContinueButtonWrapper(WelcomeViewModel viewModel) => Align(
        alignment: Alignment.bottomCenter,
        child: _buildButtonContainer(viewModel),
      );

  Widget _buildButtonContainer(WelcomeViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50, right: 50, left: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(WelcomeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Start Learning',
        backgroundColor: kcWhite,
        trailingIcon: Icons.arrow_forward,
        onTap: () => viewModel.next(),
        foregroundColor: kcPrimaryColor,
      );
}
