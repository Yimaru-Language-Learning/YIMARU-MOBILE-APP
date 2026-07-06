import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/circular_countdown_timer.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../course_practice_viewmodel.dart';

class DuolingoSpeakingPractice1Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoSpeakingPractice1Question({
    super.key,
  });

  Future<void> _next(CoursePracticeViewModel viewModel) async {
    await viewModel.startRecording();
    viewModel.setCountdown(viewModel.questions[viewModel.currentQuestion]
        .dynamicPayload?.response?.first.value['seconds']);
    viewModel.nextScreen();
  }

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
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
        body: _buildScaffoldStack(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldStack(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Stack(
        children: [
          _buildScaffold(context: context, viewModel: viewModel),
          _buildStartRecState(viewModel)
        ],
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
        _buildSpeakingIndicatorWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CoursePracticeAppBar(
        onClose: () async =>
            await _showSheet(context: context, viewModel: viewModel),
        title:
            'Speaking practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildSpeakingIndicatorWrapper(CoursePracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildSpeakingIndicatorChildren(viewModel),
      );

  List<Widget> _buildSpeakingIndicatorChildren(
          CoursePracticeViewModel viewModel) =>
      [
        _buildTitle(),
        verticalSpaceMedium,
        _buildTimerStackWrapper(viewModel),
        verticalSpaceSmall,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildImageContainer(viewModel),
      ];

  Widget _buildTitle() => Text(
        'Prepare to speak about the photo',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildTimerStackWrapper(CoursePracticeViewModel viewModel) =>
      CircularCountdownTimer(
        onEnd: () => _next(viewModel),
      );

  Widget _buildSubtitle() => Text(
        'Prep time',
        style: style16DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildImageContainer(CoursePracticeViewModel viewModel) => SizedBox(
        width: 250,
        height: 300,
        child: _buildImageWrapper(viewModel),
      );

  Widget _buildImageWrapper(CoursePracticeViewModel viewModel) => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: _buildImage(viewModel),
      );

  Widget _buildImage(CoursePracticeViewModel viewModel) => CachedNetworkImage(
        fit: BoxFit.fill,
        width: double.maxFinite,
        imageUrl: viewModel.cachedImage ?? '',
      );

  Widget _buildContinueButtonWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Start Speaking',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _next(viewModel),
      );

  Widget _buildStartRecState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.recordCoursePracticeAnswer)
          ? const PageLoadingIndicator()
          : Container();
}
