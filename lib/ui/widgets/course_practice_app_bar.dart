import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';

class CoursePracticeAppBar extends ViewModelWidget<CoursePracticeViewModel> {
  final bool reading;
  final String? title;
  final GestureTapCallback? onClose;

  const CoursePracticeAppBar({
    super.key,
    this.title,
    this.onClose,
    this.reading = false,
  });

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildAppBar(viewModel);

  Widget _buildAppBar(CoursePracticeViewModel viewModel) => Stack(
        alignment: Alignment.center,
        children: _buildAppBarChildren(viewModel),
      );

  List<Widget> _buildAppBarChildren(CoursePracticeViewModel viewModel) => [
        if (title != null) _buildTitleWrapper(),
        if (reading) _buildViewButtonWrapper(viewModel),
        _buildCloseButtonWrapper(),
      ];

  Widget _buildViewButtonWrapper(CoursePracticeViewModel viewModel) => Align(
        alignment: Alignment.centerRight,
        child: _buildViewButton(viewModel),
      );

  Widget _buildViewButton(CoursePracticeViewModel viewModel) => IconButton(
        icon: _buildViewIcon(),
        padding: const EdgeInsets.only(top: 5, right: 50),
        onPressed: () => viewModel.showPassageAbortDialog(viewModel
            .questions[viewModel.currentQuestion]
            .sharedStimulus
            ?.first
            .stimulus
            ?.first
            .value),
      );

  Widget _buildViewIcon() => const Icon(
        Icons.visibility,
        color: kcPrimaryColor,
      );

  Widget _buildCloseButtonWrapper() => Align(
        alignment: Alignment.centerRight,
        child: _buildCloseButton(),
      );

  Widget _buildCloseButton() => IconButton(
        onPressed: onClose,
        icon: _buildCloseIcon(),
        padding: const EdgeInsets.only(top: 5),
      );

  Widget _buildCloseIcon() => const Icon(
        Icons.close,
        color: kcPrimaryColor,
      );

  Widget _buildTitleWrapper() => Align(
        alignment: Alignment.center,
        child: _buildTitle(),
      );

  Widget _buildTitle() => Text(
        title ?? '',
        style: const TextStyle(
          fontSize: 18,
          color: kcPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      );
}
