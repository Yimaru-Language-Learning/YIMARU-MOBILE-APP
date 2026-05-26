import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_result_card.dart';

import '../common/app_colors.dart';

class LearnPracticeResultsWrapper
    extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeResultsWrapper({super.key});

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(LearnPracticeViewModel viewModel) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kcPrimaryColor.withOpacity(0.1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnPracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(LearnPracticeViewModel viewModel) =>
      [_buildTitle(), verticalSpaceSmall, _buildResults(viewModel)];

  Widget _buildTitle() => Text(
        LocaleKeys.conversation_review.tr(),
        style: style16DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildResults(LearnPracticeViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.answers.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => verticalSpaceSmall,
        itemBuilder: (context, index) => _buildResult(viewModel.answers[index]),
      );

  Widget _buildResult(Map<String, dynamic> answer) =>
      LearnPracticeResultCard(answer: answer);
}
