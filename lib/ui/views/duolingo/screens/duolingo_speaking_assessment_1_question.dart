import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_assessment_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../duolingo_viewmodel.dart';

class DuolingoSpeakingAssessment1Question
    extends ViewModelWidget<DuolingoViewModel> {
  const DuolingoSpeakingAssessment1Question({
    super.key,
  });

  @override
  Widget build(BuildContext context, DuolingoViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(DuolingoViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(DuolingoViewModel viewModel) =>
      SafeArea(child: _buildBodyColumnWrapper(viewModel));

  Widget _buildBodyColumnWrapper(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(DuolingoViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(DuolingoViewModel viewModel) => [
        _buildAppBarWrapper(viewModel),
        _buildSpeakingIndicatorWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(DuolingoViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
        ],
      );

  Widget _buildAppBar(DuolingoViewModel viewModel) => DuolingoAssessmentAppBar(
        title: 'Speaking Assessment',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildSpeakingIndicatorWrapper(DuolingoViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildSpeakingIndicatorChildren(),
      );

  List<Widget> _buildSpeakingIndicatorChildren() => [
        _buildTitle(),
        verticalSpaceMedium,
        _buildTimerStackWrapper(),
        verticalSpaceSmall,
        _buildSubtitle(),
        verticalSpaceSmall,
        _buildImageContainer(),
      ];

  Widget _buildTitle() => Text(
        'Prepare to speak about the photo',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildTimerStackWrapper() => SizedBox(
        height: 50,
        child: _buildTimerStack(),
      );

  Widget _buildTimerStack() => Stack(
        alignment: Alignment.center,
        children: _buildTimerStackChildren(),
      );

  List<Widget> _buildTimerStackChildren() =>
      [_buildTimer(), _buildCountdownTime()];

  Widget _buildTimer() => const CircularProgressIndicator(
        value: 1.0,
        strokeWidth: 5,
        color: kcPrimaryColor,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(minWidth: 50, minHeight: 50),
      );

  Widget _buildCountdownTime() => Text(
        '0:20',
        style: style16P600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        'Prep time',
        style: style16DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildImageContainer() => SizedBox(
        width: 250,
        height: 300,
        child: _buildImageWrapper(),
      );

  Widget _buildImageWrapper() => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: _buildImage(),
      );

  Widget _buildImage() => Image.asset(
        'assets/images/image_1.png',
        fit: BoxFit.fill,
        width: double.maxFinite,
      );

  Widget _buildContinueButtonWrapper(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(DuolingoViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Start Speaking',
        foregroundColor: kcWhite,
        onTap: () => viewModel.goTo(3),
        backgroundColor: kcPrimaryColor,
      );
}
