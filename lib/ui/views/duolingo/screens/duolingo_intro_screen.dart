import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/duolingo/duolingo_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/duolingo_assessment_app_bar.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/wave_wrapper.dart';

class DuolingoIntroScreen extends ViewModelWidget<DuolingoViewModel> {
  final String title;
  final String subtitle;
  final DuolingoAssessmentType type;

  const DuolingoIntroScreen(
      {super.key,
      required this.type,
      required this.title,
      required this.subtitle});

  IconData _getIcon() {
    if (type == DuolingoAssessmentType.speaking) {
      return Icons.waves;
    } else if (type == DuolingoAssessmentType.writing) {
      return Iconsax.pen_add;
    } else if (type == DuolingoAssessmentType.listening) {
      return Icons.hearing;
    } else {
      return Icons.book;
    }
  }

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
          verticalSpaceMedium,
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
        _buildSpeakingIconWrapper(),
        verticalSpaceMedium,
        _buildTitle(),
        _buildSubtitle(),
      ];

  Widget _buildTitle() => Text(
        title,
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        subtitle,
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildSpeakingIconWrapper() =>
      WaveWrapper(height: 125, child: _buildSpeakingIcon());

  Widget _buildSpeakingIcon() => Icon(
        _getIcon(),
        size: 30,
        color: kcPrimaryColor,
      );

  Widget _buildContinueButtonWrapper(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(DuolingoViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: 'Start Preparation',
        onTap: () => viewModel.goTo(2),
        backgroundColor: kcPrimaryColor,
      );
}
