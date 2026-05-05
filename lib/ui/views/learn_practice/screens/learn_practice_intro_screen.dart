import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_learn_practice_sheet.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/small_app_bar.dart';
import '../../../widgets/speaking_partner_image.dart';

class LearnPracticeIntroScreen extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeIntroScreen({super.key});

  Future<void> _cancel(LearnPracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.pop();
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (cxt) => _buildSheet(viewModel),
      );

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      SafeArea(
          child: _buildColumnWrapper(context: context, viewModel: viewModel));

  Widget _buildColumnWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(context: context, viewModel: viewModel),
      );

  Widget _buildColumn(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceMedium,
          _buildBodyColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      SmallAppBar(
        showBackButton: true,
        onPop: () async =>
            await _showSheet(context: context, viewModel: viewModel),
      );

  Widget _buildSheet(LearnPracticeViewModel viewModel) =>
      CancelLearnPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
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
        TextSpan(text: 'Dawit', style: style14DG600, children: [
          TextSpan(
            text: ' - Your Speaking Partner',
            style: style14MG400,
          )
        ]),
      );

  Widget _buildTitle() => Text(
        'Let\'s practice what you just learnt!',
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        'I’ll ask you a few questions, and you can respond naturally.',
        maxLines: 1,
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
        text: 'Practice',
        foregroundColor: kcWhite,
        onTap: () => viewModel.goTo(1),
        backgroundColor: kcPrimaryColor,
      );
}
