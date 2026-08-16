import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/course_practice_app_bar.dart';
import 'package:yimaru_app/ui/widgets/custom_circular_progress_indicator.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/ui_helpers.dart';
import '../../../../widgets/cancel_practice_sheet.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/wave_wrapper.dart';
import '../../course_practice_viewmodel.dart';

class DuolingoIntroScreen extends ViewModelWidget<CoursePracticeViewModel> {
  final String title;
  final String subtitle;
  final CoursePracticeType type;
  final TextEditingController practiceController;

  const DuolingoIntroScreen(
      {super.key,
      required this.type,
      required this.title,
      required this.subtitle,
      required this.practiceController});

  Future<void> _nextScreen(
      {required BuildContext context,
      required CoursePracticeViewModel viewModel}) async {
    viewModel.resetValues();
    practiceController.clear();

    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 12 /*Duolingo - Speak about the photo*/) {
      String image = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.last.value;
      int stimulusFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value['seconds'];
      await viewModel.cacheNetworkImage(image: image, context: context);
      viewModel.setCountdown(stimulusFirstSec);
    } else if (id == 13 /*Duolingo - Read then speak*/) {
      int stimulusFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value['seconds'];
      viewModel.setCountdown(stimulusFirstSec);
    } else if (id == 36 /*Duolingo - Speaking sample*/) {
      int stimulusFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value['seconds'];
      viewModel.setCountdown(stimulusFirstSec);
    } else if (id == 14 /*Duolingo - Interactive speaking*/) {
      int stimulusLastSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value['seconds'];
      viewModel.resetSpeakingState();
      viewModel.setCountdown(stimulusLastSec);
    } else if (id == 22 /*Duolingo - Write about the photo*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      String image = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value;
      await viewModel.cacheNetworkImage(image: image, context: context);
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 23 /*Duolingo - Writing sample*/) {
      int stimulusFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value['seconds'];
      viewModel.setCountdown(stimulusFirstSec);
    } else if (id == 24 /*Duolingo - Interactive writing part 1*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 25 /*Duolingo - Interactive writing part 2*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 28 /*Duolingo - Listen and type*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?[0].value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 56 /*Duolingo - Interactive listening part 1*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      String stimulusFirst = viewModel.questions[viewModel.currentQuestion]
              .dynamicPayload?.stimulus?.first.value ??
          '';
      viewModel.setCountdown(responseFirstSec);
      viewModel.setPlayCount();
      await viewModel.playVoicePrompt(stimulusFirst);
    } else if (id == 29 /*Interactive listening part 2*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?[0].value['seconds'];
      viewModel.setCountdown(responseFirstSec);
      viewModel.resetPlayCount(1);
    } else if (id == 57 /*Duolingo - Interactive listening part 3*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 49 /*Duolingo - Read and select*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?[0].value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 3 /*Duolingo - Fill in the blank*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 51 /*Duolingo - Interactive reading - complete the sentence*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 52 /*Duolingo - Interactive reading - complete the passage*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 53 /*Duolingo - Interactive reading - identify the idea*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 54 /*Duolingo - Interactive reading - title the passage*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 55 /*Duolingo - Interactive reading - highlight the answer*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 50 /*Duolingo - Read and complete*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    }

    viewModel.nextScreen();
  }

  IconData _getIcon() {
    if (type == CoursePracticeType.speaking) {
      return Icons.waves;
    } else if (type == CoursePracticeType.writing) {
      return Iconsax.pen_add;
    } else if (type == CoursePracticeType.listening) {
      return Icons.hearing;
    } else {
      return Icons.book;
    }
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
        _buildSpeakingIndicatorWrapper(viewModel),
        _buildContinueButtonWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceMedium,
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

  Widget _buildContinueButtonWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child:
            _buildContinueButtonState(context: context, viewModel: viewModel),
      );

  Widget _buildContinueButtonState(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      viewModel.busy(StateObjects.cacheImage) ||
              viewModel.busy(StateObjects.coursePracticePrompt)
          ? const CustomCircularProgressIndicator(color: kcPrimaryColor)
          : _buildContinueButton(context: context, viewModel: viewModel);

  Widget _buildContinueButton(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: LocaleKeys.start_preparation.tr(),
        backgroundColor: kcPrimaryColor,
        onTap: () async =>
            await _nextScreen(context: context, viewModel: viewModel),
      );
}
