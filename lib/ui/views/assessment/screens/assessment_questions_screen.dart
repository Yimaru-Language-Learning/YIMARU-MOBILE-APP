import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/widgets/custom_small_trailing_radio_button.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

import '../assessment_viewmodel.dart';

class AssessmentQuestionsScreen extends ViewModelWidget<AssessmentViewModel> {
  const AssessmentQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context, AssessmentViewModel viewModel) =>
      _buildAssessmentScreensWrapper(viewModel);

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
        showBackButton: viewModel.currentQuestionIndex == 0 ? false : true,
      );

  Widget _buildExpandedBody(AssessmentViewModel viewModel) =>
      Expanded(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(AssessmentViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAssessment(viewModel),
      );

  Widget _buildAssessment(AssessmentViewModel viewModel) => PageView.builder(
        controller: viewModel.pageController,
        itemCount: viewModel.assessmentQuestions.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (cotext, index) => _buildBodyScroller(viewModel),
      );

  Widget _buildBodyScroller(AssessmentViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildBody(viewModel),
      );

  Widget _buildBody(AssessmentViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(AssessmentViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitleState(viewModel),
        verticalSpaceMedium,
        _buildAnswersState(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];
  Widget _buildTitleState(AssessmentViewModel viewModel) =>
      viewModel.currentQuestionIndex == viewModel.assessmentQuestions.length
          ? Container()
          : _buildTitle(viewModel);
  Widget _buildTitle(AssessmentViewModel viewModel) => Text(
        'Q${viewModel.currentQuestionIndex + 1}. ${viewModel.assessmentQuestions[viewModel.currentQuestionIndex].questionText} ',
        style: style16DG600,
      );

  Widget _buildAnswersState(AssessmentViewModel viewModel) =>
      viewModel.currentQuestionIndex == viewModel.assessmentQuestions.length
          ? Container()
          : _buildAnswers(viewModel);

  Widget _buildAnswers(AssessmentViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.assessmentQuestions[viewModel.currentQuestionIndex]
            .options?.length,
        itemBuilder: (context, inner) => _buildAnswer(
          onTap: () => viewModel.setSelectedAnswer(
              question: viewModel.currentQuestionIndex + 1,
              option: viewModel
                  .assessmentQuestions[viewModel.currentQuestionIndex]
                  .options?[inner]),
          title: viewModel.assessmentQuestions[viewModel.currentQuestionIndex]
                  .options?[inner].optionText ??
              '',
          selected: viewModel.isSelectedAnswer(
              question: viewModel.currentQuestionIndex + 1,
              answer: viewModel
                      .assessmentQuestions[viewModel.currentQuestionIndex]
                      .options?[inner]
                      .optionText ??
                  ''),
        ),
      );

  Widget _buildAnswer(
          {required String title,
          required bool selected,
          required GestureTapCallback onTap}) =>
      CustomSmallTrailingRadioButton(
        title: title,
        onTap: onTap,
        selected: selected,
      );

  Widget _buildContinueButtonWrapper(AssessmentViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(AssessmentViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: viewModel.currentQuestionIndex ==
                viewModel.assessmentQuestions.length - 1
            ? LocaleKeys.finish_level.tr()
            : LocaleKeys.cont.tr(),
        backgroundColor: viewModel.selectedAnswers
                .containsKey('${viewModel.currentQuestionIndex + 1}')
            ? kcPrimaryColor
            : kcPrimaryColor.withValues(alpha: 0.1),
        onTap: viewModel.selectedAnswers
                .containsKey('${viewModel.currentQuestionIndex + 1}')
            ? () => viewModel.nextQuestion()
            : null,
      );
}
