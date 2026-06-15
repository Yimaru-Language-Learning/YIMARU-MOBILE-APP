import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../course_practice_viewmodel.dart';

class DuolingoRetakeScreen extends ViewModelWidget<CoursePracticeViewModel> {
  final String title;
  final String subtitle;

  const DuolingoRetakeScreen(
      {super.key, required this.title, required this.subtitle});

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
        builder: (cxt) => _buildSheet( viewModel),
      );

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper({required BuildContext context,
    required CoursePracticeViewModel viewModel}) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildSafeWrapper(context: context, viewModel: viewModel),
      );

  Widget _buildSafeWrapper({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      SafeArea(child: _buildScaffold(context: context, viewModel: viewModel));

  Widget _buildScaffold({required BuildContext context,
    required CoursePracticeViewModel viewModel}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildScaffoldChildren({required BuildContext context,
    required CoursePracticeViewModel viewModel}) => [
        _buildAppBar(context: context, viewModel: viewModel),
        verticalSpaceMedium,
        _buildExpandedBody(viewModel)
      ];

  Widget _buildExpandedBody(  CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper( CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody( CoursePracticeViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(
     CoursePracticeViewModel viewModel) =>
      [_buildUpperColumn(viewModel), _buildLowerColumn(viewModel)];

  Widget _buildUpperColumn(  CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren( CoursePracticeViewModel viewModel) => [
    verticalSpaceMassive,
        _buildIcon(),
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubtitle(),
      ];

  Widget _buildAppBar( {required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      DuolingoPracticeAppBar(

        onClose: () async =>
        await _showSheet(context: context, viewModel: viewModel),
          title:
          'Speaking practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',

      );

  Widget _buildSheet(
     CoursePracticeViewModel viewModel) =>
      CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildIcon() => SvgPicture.asset(
        'assets/icons/complete.svg',
      );

  Widget _buildTitle() => Text(
        title,
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        subtitle,
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildLowerColumn(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildLowerColumnChildren(viewModel),
      );

  List<Widget> _buildLowerColumnChildren(CoursePracticeViewModel viewModel) => [
        _buildPracticeButton(viewModel),
        verticalSpaceSmall,
        _buildSkipButtonWrapper(viewModel)
      ];

  Widget _buildPracticeButton(CoursePracticeViewModel viewModel) =>
      const CustomElevatedButton(
        height: 55,
        safe: false,
        borderRadius: 12,
        text: 'Practice Again',
        foregroundColor: kcWhite,
      //  onTap: () => viewModel.goTo(0),
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildSkipButtonWrapper(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildSkipButton(viewModel),
      );

  Widget _buildSkipButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Continue',
        borderRadius: 12,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        onTap: viewModel.nextScreen,
        foregroundColor: kcPrimaryColor,
      );
}
