import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/widgets/duolingo_practice_app_bar.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/wave_wrapper.dart';
import '../course_practice_viewmodel.dart';

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

  Future<void> _nextScreen(CoursePracticeViewModel viewModel) async {
    viewModel.resetValues();
    practiceController.clear();

    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 12) {
      int stimulusLastSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.last.value['seconds'];
      viewModel.setCountdown(stimulusLastSec);
    } else if (id == 13) {
      int stimulusLastSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.last.value['seconds'];
      viewModel.setCountdown(stimulusLastSec);
    } else if (id == 14) {
      int stimulusLastSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.last.value['seconds'];
      viewModel.resetSpeakingState();
      viewModel.setCountdown(stimulusLastSec);
    } else if (id == 24) {
      int responseLastSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.last.value['seconds'];
      viewModel.setCountdown(responseLastSec);
    } else if (id == 28) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      String stimulusFirst = viewModel.questions[viewModel.currentQuestion]
              .dynamicPayload?.stimulus?.first.value ??
          '';
      viewModel.setPlayCount();
      viewModel.setCountdown(responseFirstSec);
      await viewModel.playVoicePrompt(stimulusFirst);
    }else if(id == 29){
      viewModel.resetPlayCount(1);
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
    viewModel.pop();
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
        _buildContinueButtonWrapper(viewModel)
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
      DuolingoPracticeAppBar(
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

  Widget _buildContinueButtonWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: 'Start preparation',
        backgroundColor: kcPrimaryColor,
        onTap: () => _nextScreen(viewModel),
      );
}
