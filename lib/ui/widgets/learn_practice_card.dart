import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/practice.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class LearnPracticeCard extends ViewModelWidget<LearnPracticeViewModel> {
  final int index;
  final Practice practice;
  final GestureTapCallback? onTap;

  const LearnPracticeCard(
      {super.key, this.onTap, required this.index, required this.practice});

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(LearnPracticeViewModel viewModel) => Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kcPrimaryColor.withValues(alpha: 0.25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnPracticeViewModel viewModel) => Column(
      mainAxisSize: MainAxisSize.min,
      children: _buildColumnChildren(viewModel));

  List<Widget> _buildColumnChildren(LearnPracticeViewModel viewModel) => [
        verticalSpaceTiny,
        _buildTitle(),
        verticalSpaceSmall,
        _buildStartButtonWrapper(viewModel)
      ];

  Widget _buildTitle() => Text(
        'Practice $index',
        style: style18DG700,
      );

  Widget _buildStartButtonWrapper(LearnPracticeViewModel viewModel) => SizedBox(
        height: 40,
        child: _buildStartButton(viewModel),
      );

  Widget _buildStartButton(LearnPracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 50,
        width: 200,
        borderRadius: 8,
        text: 'Practice',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        //  onTap: () => viewModel.setPractice(practice),
      );
}
