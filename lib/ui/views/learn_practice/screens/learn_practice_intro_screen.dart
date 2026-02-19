import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_view.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/small_app_bar.dart';
import '../../../widgets/speaking_partner_image.dart';

class LearnPracticeIntroScreen extends ViewModelWidget<LearnPracticeViewModel> {
  final String title;
  final String subtitle;
  final String buttonLabel;

  const LearnPracticeIntroScreen(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.buttonLabel});

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnPracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnPracticeViewModel viewModel) =>
      SafeArea(child: _buildColumnWrapper(viewModel));

  Widget _buildColumnWrapper(LearnPracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnPracticeViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          _buildBodyColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(LearnPracticeViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onTap: viewModel.goBack,
        title: 'Practice Speaking',
      );

  Widget _buildBodyColumnWrapper(LearnPracticeViewModel viewModel) => Expanded(
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(LearnPracticeViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(LearnPracticeViewModel viewModel) => [
        _buildPracticeColumnWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildPracticeColumnWrapper(LearnPracticeViewModel viewModel) =>
      Expanded(child: _buildPracticeColumnScrollView(viewModel));

  Widget _buildPracticeColumnScrollView(LearnPracticeViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildPracticeColumn(viewModel),
      );

  Widget _buildPracticeColumn(LearnPracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildPracticeColumnChildren(viewModel),
      );

  List<Widget> _buildPracticeColumnChildren(LearnPracticeViewModel viewModel) =>
      [
        verticalSpaceMassive,
        _buildImage(),
        verticalSpaceMedium,
        _buildPartnerName(),
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildSubtitle()
      ];

  Widget _buildImage() => const SpeakingPartnerImage(
        radius: 75,
      );

  Widget _buildPartnerName() => Text.rich(
        TextSpan(text: 'Daniel', style: style14DG600, children: [
          TextSpan(
            text: ' - Your Speaking Partner',
            style: style14MG400,
          )
        ]),
      );

  Widget _buildTitle() => Text(
       title,
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
      subtitle,
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildContinueButtonWrapper(LearnPracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(LearnPracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: buttonLabel,
        foregroundColor: kcWhite,
        onTap: () => viewModel.goTo(1),
        backgroundColor: kcPrimaryColor,
      );
}
