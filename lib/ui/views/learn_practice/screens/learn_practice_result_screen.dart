import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_tip_section.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_results_wrapper.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_learn_practice_sheet.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/small_app_bar.dart';

class LearnPracticeResultScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeResultScreen({super.key});

  void _navigate(LearnPracticeViewModel viewModel) async=>await viewModel.reset();

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
          child:
              _buildBodyColumnWrapper(context: context, viewModel: viewModel));

  Widget _buildBodyColumnWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(context: context, viewModel: viewModel),
      );

  Widget _buildBodyColumn(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Column(
        children:
            _buildBodyColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyColumnChildren(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildAppBar(context: context, viewModel: viewModel),
        verticalSpaceMedium,
        _buildBodyWrapper(viewModel)
      ];

  Widget _buildAppBar(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      SmallAppBar(
        title: 'Result',
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

  Widget _buildBodyWrapper(LearnPracticeViewModel viewMode) => Expanded(
        child: _buildBodyScroller(viewMode),
      );

  Widget _buildBodyScroller(LearnPracticeViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildBody(viewModel),
      );

  Widget _buildBody(LearnPracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(LearnPracticeViewModel viewModel) => [
        _buildResultsSection(viewModel),
        verticalSpaceMedium,
        _buildLearnPracticeTipSection(),
        verticalSpaceLarge,
        _buildLowerButtonsSection(viewModel)
      ];

  Widget _buildResultsSection(LearnPracticeViewModel viewModel) =>
      const LearnPracticeResultsWrapper();

  Widget _buildLearnPracticeTipSection() => const LearnPracticeTipSection();

  Widget _buildLowerButtonsSection(LearnPracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildLowerButtonsSectionChildren(viewModel),
      );

  List<Widget> _buildLowerButtonsSectionChildren(
          LearnPracticeViewModel viewModel) =>
      [
        _buildContinueButton(viewModel),
        verticalSpaceSmall,
        _buildPracticeAgainButton(viewModel),
        verticalSpaceMedium,
      ];

  Widget _buildContinueButton(LearnPracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: () => viewModel.goTo(5),
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildPracticeAgainButton(LearnPracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Retry',
        borderRadius: 12,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        onTap: () => _navigate(viewModel),
      );
}
