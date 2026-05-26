import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

import '../../../common/enmus.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../assessment_viewmodel.dart';

class StartLessonScreen extends ViewModelWidget<AssessmentViewModel> {
  const StartLessonScreen({super.key});

  Future<void> _start(AssessmentViewModel viewModel) async {
    if (viewModel.proficiencyLevel != null) {
      Map<String, dynamic> data = {
        'knowledge_level': viewModel.proficiencyLevel?.toUpperCase()
      };

      viewModel.addUserData(data);
    }

    await viewModel.completeProfile();
  }

  @override
  Widget build(BuildContext context, AssessmentViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(AssessmentViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldStack(viewModel),
      );

  Widget _buildScaffoldStack(AssessmentViewModel viewModel) =>
      Stack(children: [_buildScaffold(viewModel), _buildState(viewModel)]);

  Widget _buildScaffold(AssessmentViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(AssessmentViewModel viewModel) => [
        _buildAppBar(viewModel),
        verticalSpaceMedium,
        _buildExpandedBody(viewModel)
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

  Widget _buildExpandedBody(AssessmentViewModel viewModel) =>
      Expanded(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(AssessmentViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(AssessmentViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(AssessmentViewModel viewModel) =>
      [_buildUpperColumn(viewModel), _buildContinueButtonWrapper(viewModel)];

  Widget _buildUpperColumn(AssessmentViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(AssessmentViewModel viewModel) => [
        verticalSpaceLarge,
        _buildIcon(),
        verticalSpaceMedium,
        _buildTitle(viewModel),
        verticalSpaceSmall,
        _buildSubtitle(),
      ];

  Widget _buildIcon() => SvgPicture.asset('assets/icons/mascot.svg');

  Widget _buildTitle(AssessmentViewModel viewModel) => Text.rich(
        TextSpan(
          text: LocaleKeys.welcome_abroad.tr(),
          style: style25DG600,
          children: [
            TextSpan(
              style: style25DG600,
              text: ', ${viewModel.userData['first_name']}!',
            ),
          ],
        ),
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.ready_to_explore.tr(),
        style: style14MG400,
      );

  Widget _buildContinueButtonWrapper(AssessmentViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(AssessmentViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: LocaleKeys.finish.tr(),
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _start(viewModel),
      );

  Widget _buildState(AssessmentViewModel viewModel) =>
      viewModel.busy(StateObjects.profileCompletion)
          ? const PageLoadingIndicator()
          : Container();
}
