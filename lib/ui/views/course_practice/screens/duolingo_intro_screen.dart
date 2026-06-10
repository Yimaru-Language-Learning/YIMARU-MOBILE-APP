import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/duolingo/duolingo_viewmodel.dart';
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
  final DuolingoAssessments type;

  const DuolingoIntroScreen(
      {super.key,
      required this.type,
      required this.title,
      required this.subtitle});

  IconData _getIcon() {
    if (type == DuolingoAssessments.speaking) {
      return Icons.waves;
    } else if (type == DuolingoAssessments.writing) {
      return Iconsax.pen_add;
    } else if (type == DuolingoAssessments.listening) {
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
      _buildScaffoldWrapper(context:context, viewModel:viewModel);

  Widget _buildScaffoldWrapper(  {required BuildContext context,
    required CoursePracticeViewModel viewModel}) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(context:context, viewModel:viewModel),
      );

  Widget _buildScaffold(  {required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      SafeArea(child: _buildBodyColumnWrapper(context:context, viewModel:viewModel));

  Widget _buildBodyColumnWrapper(  {required BuildContext context,
    required CoursePracticeViewModel viewModel}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(context:context, viewModel:viewModel),
      );

  Widget _buildBodyColumn(  {required BuildContext context,
    required CoursePracticeViewModel viewModel}) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(context:context, viewModel:viewModel),
      );

  List<Widget> _buildBodyColumnChildren(  {required BuildContext context,
    required CoursePracticeViewModel viewModel}) => [
        _buildAppBarWrapper(context:context, viewModel:viewModel),
        _buildSpeakingIndicatorWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(  {required BuildContext context,
  required CoursePracticeViewModel viewModel}) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context:context, viewModel:viewModel),
          verticalSpaceMedium,
        ],
      );

  Widget _buildAppBar(  {required BuildContext context,
required CoursePracticeViewModel viewModel}) => DuolingoPracticeAppBar(
        title: 'Speaking practice',
    onClose: () async =>
    await _showSheet(context: context, viewModel: viewModel),
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
    onClose: viewModel.pop,
    onContinue: viewModel.pop,
    user: viewModel.user?.firstName ?? '',
    onCancel: () async => await _cancel(viewModel),
  );

  Widget _buildSpeakingIndicatorWrapper(CoursePracticeViewModel viewModel) => Column(
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

  Widget _buildContinueButtonWrapper(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: 'Start Preparation',
        onTap: viewModel.nextScreen,
        backgroundColor: kcPrimaryColor,
      );
}
