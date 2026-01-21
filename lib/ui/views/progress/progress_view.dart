import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/course_level_card.dart';
import 'package:yimaru_app/ui/widgets/skill_progress.dart';
import 'package:yimaru_app/ui/widgets/suggestion_card.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/small_app_bar.dart';
import 'progress_viewmodel.dart';

class ProgressView extends StackedView<ProgressViewModel> {
  const ProgressView({Key? key}) : super(key: key);

  @override
  ProgressViewModel viewModelBuilder(BuildContext context) =>
      ProgressViewModel();

  @override
  Widget builder(
    BuildContext context,
    ProgressViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(ProgressViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(ProgressViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(ProgressViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(ProgressViewModel viewModel) => _buildColumn(viewModel);

  Widget _buildColumn(ProgressViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(ProgressViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarWrapper(viewModel),
        verticalSpaceSmall,
        _buildContentWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(ProgressViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(ProgressViewModel viewModel) => SmallAppBar(
        title: 'My Progress',
        onTap: viewModel.pop,
      );

  Widget _buildContentWrapper(ProgressViewModel viewModel) =>
      Expanded(child: _buildContentScrollView(viewModel));

  Widget _buildContentScrollView(ProgressViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildContentColumn(viewModel),
      );

  Widget _buildContentColumn(ProgressViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildContentChildren(viewModel),
      );

  List<Widget> _buildContentChildren(ProgressViewModel viewModel) => [
        verticalSpaceMedium,
        _buildCourseProgressSection(viewModel),
        verticalSpaceMedium,
        _buildSkillTitleWrapper(),
        verticalSpaceMedium,
        _buildSkillsWrapper(viewModel),
        verticalSpaceLarge,
        _buildSuggestionCard(),
        verticalSpaceMassive
      ];

  Widget _buildCourseProgressSection(ProgressViewModel viewModel) => SizedBox(
        height: 250,
        width: double.maxFinite,
        child: _buildListView(viewModel),
      );

  Widget _buildListView(ProgressViewModel viewModel) => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.progresses.length,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) => _buildCourseLeveCard(
          viewModel: viewModel,
          icon: viewModel.progresses[index]['icon'],
          title: viewModel.progresses[index]['title'],
          color: viewModel.progresses[index]['color'],
          status: viewModel.progresses[index]['status'],
          subTitle: viewModel.progresses[index]['subTitle'],
          isCompleted: viewModel.progresses[index]['isCompleted'],
        ),
      );

  Widget _buildCourseLeveCard(
          {required Color color,
          required String title,
          required String icon,
          required String status,
          required String subTitle,
          required bool isCompleted,
          required ProgressViewModel viewModel}) =>
      CourseLevelCard(
        icon: icon,
        title: title,
        color: color,
        status: status,
        subTitle: subTitle,
        isCompleted: isCompleted,
        onTap: viewModel.navigateToOngoingProgress,
      );

  Widget _buildSkillTitleWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildSkillTitle(),
      );

  Widget _buildSkillTitle() => const Text(
        'Skill Proficiency',
        style: TextStyle(
          fontSize: 18,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildSkillsWrapper(ProgressViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildSkills(viewModel),
      );

  Widget _buildSkills(ProgressViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.skillsLevel.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildSkill(
          skill: viewModel.skillsLevel[index]['skill'],
          progress: viewModel.skillsLevel[index]['progress'],
        ),
      );

  Widget _buildSkill({
    required String skill,
    required double progress,
  }) =>
      SkillProgress(
        skill: skill,
        progress: progress,
      );

  Widget _buildSuggestionCard() => const SuggestionCard();
}
