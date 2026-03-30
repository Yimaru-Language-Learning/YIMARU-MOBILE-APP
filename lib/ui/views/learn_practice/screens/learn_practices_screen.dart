import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/small_app_bar.dart';
import '../learn_practice_viewmodel.dart';

class LearnPracticesScreen extends ViewModelWidget<LearnPracticeViewModel> {
  final List<Map<String, dynamic>> practices;

  const LearnPracticesScreen({Key? key, required this.practices})
      : super(key: key);

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnPracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnPracticeViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(LearnPracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnPracticeViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildPracticeColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(LearnPracticeViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildPracticeColumnWrapper(LearnPracticeViewModel viewModel) =>
      Expanded(child: _buildPracticeColumnScrollView(viewModel));

  Widget _buildPracticeColumnScrollView(LearnPracticeViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildPracticeColumn(viewModel),
      );

  Widget _buildPracticeColumn(LearnPracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildPracticeColumnChildren(viewModel),
      );

  List<Widget> _buildPracticeColumnChildren(LearnPracticeViewModel viewModel) =>
      [
        verticalSpaceMedium,
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildListView(viewModel)
      ];

  Widget _buildTitle() => Text(
        'Learn Practices',
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        'Select a practice test your progress',
        style: style14DG400,
      );

  Widget _buildListView(LearnPracticeViewModel viewModel) => GridView.builder(
        shrinkWrap: true,
        itemCount: practices.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) =>
            _buildCard(index: index, practice: practices[index]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1.45,
        ),
      );

  Widget _buildCard(
          {required int index, required Map<String, dynamic> practice}) =>
      LearnPracticeCard(
        index: index + 1,
        practice: practice,
      );
}
