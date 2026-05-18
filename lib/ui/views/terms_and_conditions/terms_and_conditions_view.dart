import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_strings.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/small_app_bar.dart';
import 'terms_and_conditions_viewmodel.dart';

class TermsAndConditionsView extends StackedView<TermsAndConditionsViewModel> {
  const TermsAndConditionsView({Key? key}) : super(key: key);

  @override
  TermsAndConditionsViewModel viewModelBuilder(BuildContext context) =>
      TermsAndConditionsViewModel();

  @override
  Widget builder(
    BuildContext context,
    TermsAndConditionsViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(TermsAndConditionsViewModel viewModel) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(TermsAndConditionsViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(TermsAndConditionsViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(TermsAndConditionsViewModel viewModel) =>
      _buildColumn(viewModel);

  Widget _buildColumn(TermsAndConditionsViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(TermsAndConditionsViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarWrapper(viewModel),
        verticalSpaceSmall,
        _buildContentWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(TermsAndConditionsViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(TermsAndConditionsViewModel viewModel) => SmallAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
        title: 'Terms and Conditions',
      );

  Widget _buildContentWrapper(TermsAndConditionsViewModel viewModel) =>
      Expanded(child: _buildContentColumnWrapper(viewModel));

  Widget _buildContentColumnWrapper(TermsAndConditionsViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildMenuColumnScrollView(viewModel),
      );

  Widget _buildMenuColumnScrollView(TermsAndConditionsViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildContent(),
      );

  Widget _buildContent() => Html(
        data: ksTerms,
        shrinkWrap: true,
        style: htmlStyle,
      );
}
