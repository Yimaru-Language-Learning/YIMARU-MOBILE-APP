import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/learn_subcategory_card.dart';

import '../../../models/subcategory.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/profile_app_bar.dart';
import 'learn_subcategory_viewmodel.dart';

class LearnSubcategoryView extends StackedView<LearnSubcategoryViewModel> {
  const LearnSubcategoryView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(LearnSubcategoryViewModel viewModel) async {
    await viewModel.getLearnSubcategories();
    super.onViewModelReady(viewModel);
  }

  @override
  LearnSubcategoryViewModel viewModelBuilder(BuildContext context) =>
      LearnSubcategoryViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnSubcategoryViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnSubcategoryViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnSubcategoryViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(LearnSubcategoryViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnSubcategoryViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildSubcategoryColumnWrapper(viewModel)
        ],
      );

  Widget _buildAppBar(LearnSubcategoryViewModel viewModel) => ProfileAppBar(
        name: viewModel.user?.firstName,
        profileImage: viewModel.user?.profilePicture,
      );

  Widget _buildSubcategoryColumnWrapper(LearnSubcategoryViewModel viewModel) =>
      Expanded(child: _buildSubcategoryColumnScrollView(viewModel));

  Widget _buildSubcategoryColumnScrollView(
          LearnSubcategoryViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildListViewBuilder(viewModel),
      );

  Widget _buildListViewBuilder(LearnSubcategoryViewModel viewModel) =>
      viewModel.busy(StateObjects.learnSubcategories)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(LearnSubcategoryViewModel viewModel) =>
      ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.subcategories.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => verticalSpaceSmall,
        itemBuilder: (context, index) => _buildTile(
          subcategory: viewModel.subcategories[index],
          onTap: () async => await viewModel
              .navigateToLearn(viewModel.subcategories[index].id ?? 0),
        ),
      );

  Widget _buildTile({
    required Subcategory subcategory,
    required GestureTapCallback onTap,
  }) =>
      LearnSubcategoryCard(
        onTap: onTap,
        subcategory: subcategory,
      );
}
