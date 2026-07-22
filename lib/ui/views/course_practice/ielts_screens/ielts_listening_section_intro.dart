import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../course_practice_viewmodel.dart';

class IeltsListeningSectionIntro extends ViewModelWidget<CoursePracticeViewModel> {
  final String title;

  const IeltsListeningSectionIntro({super.key,required this.title});

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
        //  _buildBodyState(viewModel)
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
        'Listening practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
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
    _buildTitle(),
    _buildSubtitle(),
    verticalSpaceMedium,
    _buildInstruction(),
    _buildWarning()
  ];

  Widget _buildTitle() => Text(
    title,
    style: style18P600,
    textAlign: TextAlign.center,
  );

  Widget _buildSubtitle() => Text(
    'READY TO LISTEN',
    style: style14P400,
    textAlign: TextAlign.center,
  );



  Widget _buildInstruction() => Text(
    'Once you press play, you cannot stop or restart the audio.',
    style: style14DG400,
    textAlign: TextAlign.center,
  );


  Widget _buildWarning() => Text(
    'Complete the audio to proceed',
    style: style12DG400,
    textAlign: TextAlign.center,
  );

  Widget _buildContinueButtonWrapper(
      {required BuildContext context,
        required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child:
        _buildContinueButton(context: context, viewModel: viewModel),
      );


  Widget _buildContinueButton(
      {required BuildContext context,
        required CoursePracticeViewModel viewModel}) =>
      const CustomElevatedButton(
        height: 55,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
       /* onTap: () async =>
        await _nextScreen(context: context, viewModel: viewModel),*/
      );

/*  Widget _buildBodyState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.coursePracticePrompt)
          ? const PageLoadingIndicator()
          : Container();*/
}
