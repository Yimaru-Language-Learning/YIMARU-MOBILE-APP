import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/widgets/custom_small_radio_button.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

import '../assessment_viewmodel.dart';
import 'assessment_loading_screen.dart';

class AssessmentFormScreen extends ViewModelWidget<AssessmentViewModel> {
  const AssessmentFormScreen({super.key});

  //final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context, AssessmentViewModel viewModel) =>
      _buildAssessmentScreens(viewModel);

  Widget _buildAssessmentScreens(AssessmentViewModel viewModel) =>
      viewModel.isBusy
          ? _buildPageLoadingIndicator()
          : _buildAssessmentScreensWrapper(viewModel);

  Widget _buildPageLoadingIndicator() => const AssessmentLoadingScreen();

  Widget _buildAssessmentScreensWrapper(AssessmentViewModel viewModel) =>
      PopScope(
          canPop: false,
          onPopInvokedWithResult: (value, data) => viewModel.previousQuestion(),
          child: _buildScaffoldWrapper(viewModel));

  Widget _buildScaffoldWrapper(AssessmentViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(AssessmentViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(AssessmentViewModel viewModel) =>
      [_buildAppBar(viewModel), _buildExpandedBody(viewModel)];

  Widget _buildAppBar(AssessmentViewModel viewModel) => LargeAppBar(
        onClose: viewModel.abort,
        showLanguageSelection: false,
        onPop: viewModel.previousQuestion,
        showBackButton: viewModel.currentQuestion == 0 ? false : true,
      );

  Widget _buildExpandedBody(AssessmentViewModel viewModel) =>
      Expanded(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(AssessmentViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAssessment(viewModel),
      );

  Widget _buildAssessment(AssessmentViewModel viewModel) => PageView.builder(
      controller: viewModel.pageController,
      itemCount: viewModel.assessments.length,
      itemBuilder: (cotext, index) =>
          _buildBody(index: index, viewModel: viewModel));

  Widget _buildBody(
          {required int index, required AssessmentViewModel viewModel}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel: viewModel, index: index),
      );

  List<Widget> _buildBodyChildren(
          {required int index, required AssessmentViewModel viewModel}) =>
      [
        _buildUpperColumnWrapper(viewModel: viewModel, index: index),
        _buildContinueButtonWrapper(viewModel: viewModel, question: index + 1)
      ];

  Widget _buildUpperColumnWrapper(
          {required int index, required AssessmentViewModel viewModel}) =>
      Expanded(
        child: _buildUpperColumn(index: index, viewModel: viewModel),
      );

  Widget _buildUpperColumn(
          {required int index, required AssessmentViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(index: index, viewModel: viewModel),
      );

  List<Widget> _buildUpperColumnChildren(
          {required int index, required AssessmentViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildTitle(index: index, viewModel: viewModel),
        verticalSpaceMedium,
        _buildAnswers(index: index, viewModel: viewModel)
      ];

  Widget _buildTitle(
          {required int index, required AssessmentViewModel viewModel}) =>
      Text(
        'Q${index + 1}. ${viewModel.assessments[index].question?.title} ',
        style: style16DG600,
      );

  Widget _buildAnswers(
          {required int index, required AssessmentViewModel viewModel}) =>
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.assessments[index].options?.length,
        itemBuilder: (context, inner) => _buildAnswer(
          title: viewModel.assessments[index].options?[inner].optionText ?? '',
          selected: viewModel.isSelectedAnswer(
              question: index + 1,
              answer: viewModel.assessments[index].options?[inner].optionText ??
                  ''),
          onTap: () => viewModel.setSelectedAnswer(
              question: index + 1,
              option: viewModel.assessments[index].options?[inner].optionText ??
                  ''),
        ),
      );

  Widget _buildAnswer(
          {required String title,
          required bool selected,
          required GestureTapCallback onTap}) =>
      CustomSmallRadioButton(
        title: title,
        onTap: onTap,
        selected: selected,
      );

  Widget _buildContinueButtonWrapper(
          {required int question, required AssessmentViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel: viewModel, question: question),
      );

  Widget _buildContinueButton(
          {required int question, required AssessmentViewModel viewModel}) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: viewModel.currentQuestion == viewModel.assessments.length - 1
            ? 'Finish'
            : 'Continue',
        backgroundColor:
            viewModel.selectedAnswers.containsKey(question.toString())
                ? kcPrimaryColor
                : kcPrimaryColor.withOpacity(0.1),
        onTap: viewModel.selectedAnswers.containsKey(question.toString())
            ?
            // viewModel.currentQuestion == viewModel.assessments.length - 1
            //         ? () => viewModel.next()
            //    :
            () => viewModel.nextQuestion()
            : null,
      );
}
