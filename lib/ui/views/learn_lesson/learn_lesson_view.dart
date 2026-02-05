import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/widgets/learn_lesson_tile.dart';
import 'package:yimaru_app/ui/widgets/module_progress.dart';
import 'package:yimaru_app/ui/widgets/motivation_card.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_lesson_viewmodel.dart';

class LearnLessonView extends StackedView<LearnLessonViewModel> {
  const LearnLessonView({Key? key}) : super(key: key);

  @override
  LearnLessonViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LearnLessonViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnLessonViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnLessonViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnLessonViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(LearnLessonViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnLessonViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          _buildLevelsColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(LearnLessonViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
      );

  Widget _buildLevelsColumnWrapper(LearnLessonViewModel viewModel) =>
      Expanded(child: _buildLevelsColumnScrollView(viewModel));

  Widget _buildLevelsColumnScrollView(LearnLessonViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildLevelsColumn(viewModel),
      );

  Widget _buildLevelsColumn(LearnLessonViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildLevelsColumnChildren(viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(LearnLessonViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceTiny,
        _buildSubtitle(),
        verticalSpaceSmall,
        _buildModuleProgress(),
        verticalSpaceMedium,
        _buildContinueButton(),
        verticalSpaceMedium,
        _buildMotivationCard(),
        verticalSpaceMedium,
        _buildHeader(),
        verticalSpaceMedium,
        _buildListView(viewModel),
        verticalSpaceMedium
      ];

  Widget _buildTitle() => Text(
        'Module 1: Greetings & Introductions',
        style: style16DG600,
      );

  Widget _buildSubtitle() => Text(
        'Learn how to introduce yourself, talk about your surroundings, and start simple conversations.',
        style: style14DG400,
      );

  Widget _buildModuleProgress() => const ModuleProgress();

  Widget _buildContinueButton() => const CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: 'Continue Lesson 1.3',
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildMotivationCard() => const MotivationCard();

  Widget _buildHeader() => Text(
        'Module 1: Greetings & Introductions',
        style: style18DG600,
      );

  Widget _buildListView(LearnLessonViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.lessons.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
            title: viewModel.lessons[index]['title'],
            status: viewModel.lessons[index]['status'],
            thumbnail: viewModel.lessons[index]['thumbnail']),
      );

  Widget _buildTile({
    required String title,
    required String thumbnail,
    required ProgressStatuses status,
  }) =>
      LearnLessonTile(
        title: title,
        status: status,
        thumbnail: thumbnail,
      );
}
