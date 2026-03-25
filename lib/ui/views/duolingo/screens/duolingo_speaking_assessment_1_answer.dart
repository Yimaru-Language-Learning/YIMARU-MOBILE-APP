import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/countdown_timer.dart';
import 'package:yimaru_app/ui/widgets/speaking_indicator.dart';
import 'package:yimaru_app/ui/widgets/speaking_label.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_assessment_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../duolingo_viewmodel.dart';

class DuolingoSpeakingAssessment1Answer
    extends ViewModelWidget<DuolingoViewModel> {
  const DuolingoSpeakingAssessment1Answer({
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
          verticalSpaceSmall,
          _buildCountdownWrapper(),
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
        _buildImageContainer(),
        verticalSpaceSmall,
        _buildSpeakerLabel(),
        verticalSpaceSmall,
        _buildSpeakingIndicator()
      ];

  Widget _buildCountdownWrapper() =>
      const Align(alignment: Alignment.centerRight, child: CountdownTimer());

  Widget _buildTitle() => Text(
        'Speak about the photo below',
        style: style18DG700,
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

  Widget _buildSpeakerLabel() => const SpeakingLabel();

  Widget _buildSpeakingIndicator() => const SpeakingIndicator(
        size: 25,
      );

  Widget _buildContinueButtonWrapper(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(DuolingoViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Submit',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: () => viewModel.goTo(4),
        backgroundColor: kcPrimaryColor,
      );
}
