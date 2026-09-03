import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';

class LearnPracticeCompletionScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  final String level;
  const LearnPracticeCompletionScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnPracticeViewModel viewModel) => Scaffold(
        
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(LearnPracticeViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildBodyWrapper(viewModel),
      );

  Widget _buildBodyWrapper(LearnPracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(LearnPracticeViewModel viewModel) => Stack(
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(LearnPracticeViewModel viewModel) => [
        _buildUpperColumnWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];
  Widget _buildUpperColumnWrapper(LearnPracticeViewModel viewModel) => Align(
        alignment: Alignment.center,
        child: _buildUpperColumn(viewModel),
      );

  Widget _buildUpperColumn(LearnPracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(LearnPracticeViewModel viewModel) => [
        _buildIcon(),
        verticalSpaceMedium,
        _buildTitle(),
      ];

  Widget _buildIcon() => SvgPicture.asset(
        'assets/icons/mascot.svg',
      );

  Widget _buildTitle() => Text(
        '${LocaleKeys.you_have_completed.tr()} $level ',
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildContinueButtonWrapper(LearnPracticeViewModel viewModel) => Align(
        alignment: Alignment.bottomCenter,
        child: _buildContinueButtonPadding(viewModel),
      );

  Widget _buildContinueButtonPadding(LearnPracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(LearnPracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        onTap: viewModel.pop,
        foregroundColor: kcWhite,
        text: LocaleKeys.cont.tr(),
        backgroundColor: kcPrimaryColor,
      );
}
