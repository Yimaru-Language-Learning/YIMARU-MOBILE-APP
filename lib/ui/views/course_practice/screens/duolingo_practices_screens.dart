import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_practice_card.dart';
import '../../../widgets/small_app_bar.dart';
import '../course_practice_viewmodel.dart';

class DuolingoPracticesScreens
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoPracticesScreens({super.key});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CoursePracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CoursePracticeViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(CoursePracticeViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildPracticeColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(CoursePracticeViewModel viewModel) => const SmallAppBar(
        showBackButton: false,
      );

  Widget _buildPracticeColumnWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildPracticeColumnScrollView(viewModel));

  Widget _buildPracticeColumnScrollView(CoursePracticeViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildPracticeColumn(viewModel),
      );

  Widget _buildPracticeColumn(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildPracticeColumnChildren(viewModel),
      );

  List<Widget> _buildPracticeColumnChildren(
          CoursePracticeViewModel viewModel) =>
      [
        verticalSpaceMedium,
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildListView(viewModel)
      ];

  Widget _buildTitle() => Text(
        'Duolingo',
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        'Select your target exam and start preparing',
        style: style14DG400,
      );

  Widget _buildListView(CoursePracticeViewModel viewModel) => GridView.builder(
        shrinkWrap: true,
        itemCount: viewModel.practices.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildCard(
            title: viewModel.practices[index].title ?? '', onTap: () {}
            // onTap: () => viewModel.setSelectedAssessment(
            //     page: 1, assessment: viewModel.assessments[index])
            ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1.45,
        ),
      );

  Widget _buildCard({
    required String title,
    required GestureTapCallback onTap,
  }) =>
      DuolingoPracticeCard(
        title: title,
        onTap: onTap,
      );
}
