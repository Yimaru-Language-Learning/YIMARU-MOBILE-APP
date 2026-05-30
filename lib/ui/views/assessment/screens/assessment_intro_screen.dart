import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

import '../assessment_viewmodel.dart';

class AssessmentIntroScreen extends ViewModelWidget<AssessmentViewModel> {
  final bool hasAssessments;

  const AssessmentIntroScreen({super.key, required this.hasAssessments});

  Future<void> _next(AssessmentViewModel viewModel) async =>
      viewModel.setFirstAssessment();

  @override
  Widget build(BuildContext context, AssessmentViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(AssessmentViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(AssessmentViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(AssessmentViewModel viewModel) =>
      [_buildAppBar(viewModel), _buildExpandedBody(viewModel)];

  Widget _buildExpandedBody(AssessmentViewModel viewModel) =>
      Expanded(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(AssessmentViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(AssessmentViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(AssessmentViewModel viewModel) =>
      [_buildUpperColumn(viewModel), _buildLowerColumn(viewModel)];

  Widget _buildUpperColumn(AssessmentViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(AssessmentViewModel viewModel) => [
        verticalSpaceLarge,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubtitle(),
      ];

  Widget _buildAppBar(AssessmentViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        onPop: viewModel.goBack,
        showLanguageSelection: true,
        onLanguage: () async => await viewModel.navigateToLanguage(),
        language: viewModel.selectedLanguage['code'] == 'am'
            ? 'አማ'
            : viewModel.selectedLanguage['code'],
      );

  Widget _buildTitle() => Text(
        LocaleKeys.want_quick_assessment.tr(),
        style: style25DG600,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.answer_quick_questions.tr(),
        style: style14MG400,
      );

  Widget _buildLowerColumn(AssessmentViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildLowerColumnChildren(viewModel),
      );

  List<Widget> _buildLowerColumnChildren(AssessmentViewModel viewModel) => [
        if (hasAssessments) _buildContinueButton(viewModel),
        verticalSpaceSmall,
        _buildSkipButtonWrapper(viewModel)
      ];

  Widget _buildContinueButton(AssessmentViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        safe: false,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: LocaleKeys.cont.tr(),
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _next(viewModel),
      );

  Widget _buildSkipButtonWrapper(AssessmentViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildSkipButton(viewModel),
      );

  Widget _buildSkipButton(AssessmentViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        backgroundColor: kcWhite,
        text: LocaleKeys.skip.tr(),
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        onTap: () => viewModel.next(page: 3),
      );
}
