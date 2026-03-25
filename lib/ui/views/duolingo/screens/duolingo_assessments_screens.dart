import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_assessment_card.dart';
import '../../../widgets/small_app_bar.dart';
import '../duolingo_viewmodel.dart';

class DuolingoAssessmentsScreens extends ViewModelWidget<DuolingoViewModel> {
  const DuolingoAssessmentsScreens({super.key});

  @override
  Widget build(BuildContext context, DuolingoViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(DuolingoViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(DuolingoViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(DuolingoViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildPracticeColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(DuolingoViewModel viewModel) => const SmallAppBar(
        showBackButton: false,
      );

  Widget _buildPracticeColumnWrapper(DuolingoViewModel viewModel) =>
      Expanded(child: _buildPracticeColumnScrollView(viewModel));

  Widget _buildPracticeColumnScrollView(DuolingoViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildPracticeColumn(viewModel),
      );

  Widget _buildPracticeColumn(DuolingoViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildPracticeColumnChildren(viewModel),
      );

  List<Widget> _buildPracticeColumnChildren(DuolingoViewModel viewModel) => [
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

  Widget _buildListView(DuolingoViewModel viewModel) => GridView.builder(
        shrinkWrap: true,
        itemCount: viewModel.assessments.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildCard(
            title: viewModel.assessments[index]['label'],
            onTap: () => viewModel.setSelectedAssessment(
                page: 1, assessment: viewModel.assessments[index])),
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
      DuolingoAssessmentCard(
        title: title,
        onTap: onTap,
      );
}
