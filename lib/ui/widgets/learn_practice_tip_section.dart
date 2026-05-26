import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';

class LearnPracticeTipSection extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeTipSection({super.key});

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(LearnPracticeViewModel viewModel) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kcBlue.withOpacity(0.1),
        ),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnPracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(LearnPracticeViewModel viewModel) =>
      [_buildTitleWrapper(), verticalSpaceTiny, _buildContent(viewModel)];

  Widget _buildTitleWrapper() => Row(
        children: [_buildLeading(), horizontalSpaceSmall, _buildTitle()],
      );

  Widget _buildLeading() => const Icon(
        Icons.lightbulb_outline_rounded,
        color: kcBlue,
      );

  Widget _buildTitle() => Text(
        LocaleKeys.quick_tip.tr(),
        style: style16B600,
      );

  Widget _buildContent(LearnPracticeViewModel viewModel) => Text(
        viewModel.practices.firstOrNull?.quickTips ?? '',
        style: style14B400,
        textAlign: TextAlign.start,
      );
}
