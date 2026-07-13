import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/diagram_labeling_choice_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../course_practice_viewmodel.dart';

class IeltsReadingPractice2Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsReadingPractice2Question({super.key});

  void _nextScreen(
      {required BuildContext context,
      required CoursePracticeViewModel viewModel}) {
    FocusManager.instance.primaryFocus?.unfocus();
    viewModel.nextQuestion(context);
  }

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.resetValues();
    viewModel.pop();
    viewModel.goBack();
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (cxt) => _buildSheet(viewModel),
      );

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      SafeArea(
          child:
              _buildBodyColumnWrapper(context: context, viewModel: viewModel));

  Widget _buildBodyColumnWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(context: context, viewModel: viewModel),
      );

  Widget _buildBodyColumn(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            _buildBodyColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyColumnChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        _buildAppBarWrapper(context: context, viewModel: viewModel),
        _buildQuestionExpandedWrapper(context: context, viewModel: viewModel),
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceSmall,
          _buildCountdownWrapper(context: context, viewModel: viewModel),
          verticalSpaceSmall,
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CoursePracticeAppBar(
        onClose: () async =>
            await _showSheet(context: context, viewModel: viewModel),
        title:
            'Writing practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildCountdownWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Align(
          alignment: Alignment.centerRight,
          child: _buildCountdown(context: context, viewModel: viewModel));

  Widget _buildCountdown(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CountdownTimer(
        onEnd: () => _nextScreen(context: context, viewModel: viewModel),
        duration: viewModel.countdown,
      );

  Widget _buildQuestionExpandedWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Expanded(
          child: _buildQuestionScrollerWrapper(
              context: context, viewModel: viewModel));

  Widget _buildQuestionScrollerWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      SingleChildScrollView(
          child: _buildQuestionColumn(context: context, viewModel: viewModel));

  Widget _buildQuestionColumn(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildQuestionColumnChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildQuestionColumnChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceSmall,
        _buildQuestionContainerWrapper(viewModel),
        verticalSpaceLarge,
        _buildContinueButtonWrapper(context: context, viewModel: viewModel),
      ];

  Widget _buildQuestionContainerWrapper(CoursePracticeViewModel viewModel) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kcDarkGrey.withValues(alpha: 0.1)),
        ),
        child: _buildQuestionWrapper(viewModel),
      );

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(CoursePracticeViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitleWrapper(viewModel),
        verticalSpaceSmall,
        _buildDivider(),
        verticalSpaceMedium,
        _buildImageContainer(viewModel),
        verticalSpaceMedium,
        _buildDiagramLabelingChoicesWrapper(viewModel),
        verticalSpaceMedium,
      ];

  Widget _buildTitleWrapper(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildTitle(viewModel),
      );

  Widget _buildTitle(CoursePracticeViewModel viewModel) => Text(
        viewModel.questions[viewModel.currentQuestion].dynamicPayload?.stimulus
            ?.first.value,
        style: style14MG400,
      );

  Widget _buildDivider() => const Divider(color: kcVeryLightGrey);

  Widget _buildImageContainer(CoursePracticeViewModel viewModel) => Container(
        width: 250,
        height: 300,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildImageWrapper(viewModel),
      );

  Widget _buildImageWrapper(CoursePracticeViewModel viewModel) => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: _buildImage(viewModel),
      );

  Widget _buildImage(CoursePracticeViewModel viewModel) => CachedNetworkImage(
        fit: BoxFit.fill,
        width: double.maxFinite,
        imageUrl: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[1].value,
      );

  Widget _buildDiagramLabelingChoicesWrapper(
          CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildDiagramLabelingChoices(viewModel),
      );

  Widget _buildDiagramLabelingChoices(CoursePracticeViewModel viewModel) =>
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => verticalSpaceSmall,
        itemCount: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.last.value['left'].length,
        itemBuilder: (context, index) => _buildDiagramLabelingChoiceCard(
            viewModel: viewModel, number: (index + 1).toString()),
      );

  //Widget _build

  Widget _buildDiagramLabelingChoiceCard(
          {required String number,
          required CoursePracticeViewModel viewModel}) =>
      DiagramLabelingChoiceCard(
        number: number,
        choice: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.last.value['left'],
      );

  Widget _buildContinueButtonWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(context: context, viewModel: viewModel),
      );

  Widget _buildContinueButton(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CustomElevatedButton(
          height: 55,
          borderRadius: 12,
          text: 'Submit Task',
          foregroundColor: kcWhite,
          backgroundColor: kcPrimaryColor,
          onTap: () => _nextScreen(context: context, viewModel: viewModel));
}
