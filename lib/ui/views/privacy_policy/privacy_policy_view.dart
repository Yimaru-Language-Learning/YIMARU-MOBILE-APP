import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/privacy_policy_tile.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/small_app_bar.dart';
import 'privacy_policy_viewmodel.dart';

class PrivacyPolicyView extends StackedView<PrivacyPolicyViewModel> {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  PrivacyPolicyViewModel viewModelBuilder(BuildContext context) =>
      PrivacyPolicyViewModel();

  @override
  Widget builder(
    BuildContext context,
    PrivacyPolicyViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(PrivacyPolicyViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(PrivacyPolicyViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(PrivacyPolicyViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(PrivacyPolicyViewModel viewModel) =>
      _buildColumn(viewModel);

  Widget _buildColumn(PrivacyPolicyViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(PrivacyPolicyViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarWrapper(viewModel),
        verticalSpaceSmall,
        _buildContentWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(PrivacyPolicyViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(PrivacyPolicyViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onTap: viewModel.pop,
        title: 'Privacy Policy',
      );

  Widget _buildContentWrapper(PrivacyPolicyViewModel viewModel) =>
      Expanded(child: _buildContentColumnWrapper(viewModel));

  Widget _buildContentColumnWrapper(PrivacyPolicyViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildMenuColumnScrollView(viewModel),
      );

  Widget _buildMenuColumnScrollView(PrivacyPolicyViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildMenuColumn(viewModel),
      );

  Widget _buildMenuColumn(PrivacyPolicyViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildMenuColumnChildren(viewModel),
      );

  List<Widget> _buildMenuColumnChildren(PrivacyPolicyViewModel viewModel) =>
      [verticalSpaceLarge, _buildListView(viewModel)];

  Widget _buildListView(PrivacyPolicyViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.privacyPolicies.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) =>
            _buildTile(viewModel.privacyPolicies[index]['title']),
      );

  Widget _buildTile(String title) => PrivacyPolicyTile(title: title);
}
