import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/dwarf_tile.dart';
import 'package:yimaru_app/ui/widgets/listenable_practice_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_small_radio_button.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
import '../course_practice_viewmodel.dart';

class DuolingoListeningPractice3Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  final TextEditingController practiceController;

  const DuolingoListeningPractice3Question(
      {super.key, required this.practiceController});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CoursePracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CoursePracticeViewModel viewModel) =>
      SafeArea(child: _buildBodyColumn(viewModel));

  Widget _buildBodyColumn(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(CoursePracticeViewModel viewModel) => [
        _buildAppBarWrapper(viewModel),
        _buildExpandedBody(viewModel),
      ];

  Widget _buildAppBarWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildAppBarChildren(viewModel),
      );

  List<Widget> _buildAppBarChildren(CoursePracticeViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarIndenter(viewModel),
      ];

  Widget _buildAppBarIndenter(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBar(viewModel),
      );

  Widget _buildAppBar(CoursePracticeViewModel viewModel) =>
      DuolingoPracticeAppBar(
        title: 'Listening practice',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildExpandedBody(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildBodyScroller(viewModel));

  Widget _buildBodyScroller(CoursePracticeViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildQuestionIndenter(viewModel),
      );

  Widget _buildQuestionIndenter(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestionWrapper(viewModel),
      );

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(CoursePracticeViewModel viewModel) => [
        verticalSpaceLarge,
        _buildTitle(),
        verticalSpaceMedium,
        _buildQuestion(),
        verticalSpaceLarge,
        _buildLabel(),
        verticalSpaceTiny,
       // _buildPracticeQuestions(viewModel),
        verticalSpaceMedium,
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildTitle() => Text(
        'Listen closely! Audio clips only play once',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion() =>
      DwarfTile(small: true, child: _buildListenablePracticeCard());

  Widget _buildListenablePracticeCard() =>
      const Expanded(child: ListenablePracticeCard());

  Widget _buildLabel() => Text(
        'Select the best response',
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  // Widget _buildPracticeQuestions(CoursePracticeViewModel viewModel) =>
  //     ListView.builder(
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemCount: viewModel.questions.length,
  //       itemBuilder: (context, index) => _buildAssessmentCard(
  //         title: viewModel.listeningAssessments[index],
  //         selected: viewModel.isSelectedListeningAssessment(
  //             viewModel.listeningAssessments[index]),
  //         onTap: () => viewModel.setSelectedListeningAssessment(
  //             viewModel.listeningAssessments[index]),
  //       ),
  //     );

  Widget _buildPracticeCard(
          {required String title,
          required bool selected,
          required GestureTapCallback onTap}) =>
      CustomSmallRadioButton(
        title: title,
        onTap: onTap,
        selected: selected,
      );

  Widget _buildContinueButtonWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Submit',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: () => viewModel.goTo(4),
        backgroundColor: kcPrimaryColor,
      );
}
