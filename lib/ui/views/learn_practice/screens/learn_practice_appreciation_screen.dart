import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_learn_practice_sheet.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/small_app_bar.dart';

class LearnPracticeAppreciationScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeAppreciationScreen({super.key});

  Future<void> _cancel(LearnPracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.pop();
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (cxt) => _buildSheet(viewModel),
      );

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldContainer(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      SafeArea(
          child:
              _buildBodyColumnWrapper(context: context, viewModel: viewModel));

  Widget _buildBodyColumnWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(context: context, viewModel: viewModel),
      );

  Widget _buildBodyColumn(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            _buildBodyColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyColumnChildren(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      [
        _buildAppBarWrapper(context: context, viewModel: viewModel),
        _buildSpeakingIndicatorWrapper(viewModel),
        _buildLowerButtonsSectionWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceMedium,
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      SmallAppBar(
        showBackButton: true,
        onPop: () async =>
            await _showSheet(context: context, viewModel: viewModel),
      );

  Widget _buildSheet(LearnPracticeViewModel viewModel) =>
      CancelLearnPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );
  Widget _buildSpeakingIndicatorWrapper(LearnPracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildSpeakingIndicatorChildren(viewModel),
      );

  List<Widget> _buildSpeakingIndicatorChildren(
          LearnPracticeViewModel viewModel) =>
      [
        _buildIcon(),
        verticalSpaceMedium,
        _buildTitle(viewModel),
        _buildSubtitle(),
      ];

  Widget _buildIcon() => SvgPicture.asset('assets/icons/success.svg');

  Widget _buildTitle(LearnPracticeViewModel viewModel) => Text(
        '${LocaleKeys.great_work.tr()}, ${viewModel.user?.firstName}',
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.you_have_finished_practice.tr(),
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildLowerButtonsSectionWrapper(LearnPracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(LearnPracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: () => viewModel.goTo(4),
        backgroundColor: kcPrimaryColor,
        text: LocaleKeys.view_results.tr(),
      );
}
