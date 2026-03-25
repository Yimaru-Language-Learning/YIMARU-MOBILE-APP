import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/dwarf_tile.dart';
import 'package:yimaru_app/ui/widgets/listenable_assessment_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_small_radio_button.dart';
import '../../../widgets/duolingo_assessment_app_bar.dart';
import '../duolingo_viewmodel.dart';

class DuolingoListeningAssessment3Question
    extends ViewModelWidget<DuolingoViewModel> {
  final TextEditingController assessmentController;

  const DuolingoListeningAssessment3Question(
      {super.key, required this.assessmentController});

  @override
  Widget build(BuildContext context, DuolingoViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(DuolingoViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(DuolingoViewModel viewModel) =>
      SafeArea(child: _buildBodyColumn(viewModel));

  Widget _buildBodyColumn(DuolingoViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(DuolingoViewModel viewModel) => [
        _buildAppBarWrapper(viewModel),
        _buildExpandedBody(viewModel),
      ];

  Widget _buildAppBarWrapper(DuolingoViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildAppBarChildren(viewModel),
      );

  List<Widget> _buildAppBarChildren(DuolingoViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarIndenter(viewModel),
      ];

  Widget _buildAppBarIndenter(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBar(viewModel),
      );

  Widget _buildAppBar(DuolingoViewModel viewModel) => DuolingoAssessmentAppBar(
        title: 'Listening Assessment',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildExpandedBody(DuolingoViewModel viewModel) =>
      Expanded(child: _buildBodyScroller(viewModel));

  Widget _buildBodyScroller(DuolingoViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildQuestionIndenter(viewModel),
      );

  Widget _buildQuestionIndenter(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestionWrapper(viewModel),
      );

  Widget _buildQuestionWrapper(DuolingoViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(DuolingoViewModel viewModel) => [
        verticalSpaceLarge,
        _buildTitle(),
        verticalSpaceMedium,
        _buildQuestion(),
        verticalSpaceLarge,
        _buildLabel(),
        verticalSpaceTiny,
        _buildAssessmentQuestions(viewModel),
        verticalSpaceMedium,
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildTitle() => Text(
        'Listen closely! Audio clips only play once',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion() =>
      DwarfTile(small: true, child: _buildListenableAssessmentCard());

  Widget _buildListenableAssessmentCard() =>
      const Expanded(child: ListenableAssessmentCard());

  Widget _buildLabel() => Text(
        'Select the best response',
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildAssessmentQuestions(DuolingoViewModel viewModel) =>
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.listeningAssessments.length,
        itemBuilder: (context, index) => _buildAssessmentCard(
          title: viewModel.listeningAssessments[index],
          selected: viewModel.isSelectedListeningAssessment(
              viewModel.listeningAssessments[index]),
          onTap: () => viewModel.setSelectedListeningAssessment(
              viewModel.listeningAssessments[index]),
        ),
      );

  Widget _buildAssessmentCard(
          {required String title,
          required bool selected,
          required GestureTapCallback onTap}) =>
      CustomSmallRadioButton(
        title: title,
        onTap: onTap,
        selected: selected,
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
