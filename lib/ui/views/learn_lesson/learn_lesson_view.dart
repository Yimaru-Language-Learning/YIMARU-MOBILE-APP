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
  final String title;
  final String topics;
  final String subtitle;
  final String description;
  final List<Map<String, dynamic>> practices;

  const LearnLessonView(
      {Key? key,
      required this.title,
      required this.topics,
      required this.subtitle,
      required this.practices,
      required this.description})
      : super(key: key);

  Widget getPadding(context) {
    double half = screenHeight(context) / 2;
    return SizedBox(
      height: half + 275 - half,
    );
  }

  @override
  LearnLessonViewModel viewModelBuilder(BuildContext context) =>
      LearnLessonViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnLessonViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required LearnLessonViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required LearnLessonViewModel viewModel}) =>
      SafeArea(child: _buildBody(context: context, viewModel: viewModel));

  Widget _buildBody(
          {required BuildContext context,
          required LearnLessonViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(context: context, viewModel: viewModel),
      );

  Widget _buildColumn(
          {required BuildContext context,
          required LearnLessonViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
          _buildLevelsColumnWrapper(context: context, viewModel: viewModel),
        ],
      );

  Widget _buildAppBar(LearnLessonViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildLevelsColumnWrapper(
          {required BuildContext context,
          required LearnLessonViewModel viewModel}) =>
      Expanded(
          child: _buildLevelsColumnScrollView(
              context: context, viewModel: viewModel));

  Widget _buildLevelsColumnScrollView(
          {required BuildContext context,
          required LearnLessonViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildLevelsColumn(context: context, viewModel: viewModel),
      );

  Widget _buildLevelsColumn(
          {required BuildContext context,
          required LearnLessonViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            _buildLevelsColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildLevelsColumnChildren(
          {required BuildContext context,
          required LearnLessonViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceTiny,
        _buildSubtitle(),
        verticalSpaceSmall,
        _buildTopics(),
        verticalSpaceSmall,
        // _buildModuleProgress(),
        // verticalSpaceMedium,
        //   _buildContinueButton(),
        // verticalSpaceMedium,
        // _buildMotivationCard(),
        // verticalSpaceMedium,
        //_buildHeader(),
        //verticalSpaceMedium,
        // _buildListView(viewModel),
        getPadding(context),
        _buildStartButton(viewModel),
        verticalSpaceSmall,
        _buildPracticeButton(viewModel)
      ];

  Widget _buildTitle() => Text(
        title,
        style: style16DG600,
      );

  Widget _buildSubtitle() => Text(
        subtitle,
        style: style14DG600,
      );

  Widget _buildTopics() => Text(
        topics,
        style: style14DG500,
      );

  Widget _buildModuleProgress() => const ModuleProgress();

  Widget _buildStartButton(LearnLessonViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Start $title',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await viewModel.navigateToLearnLessonDetail(
            title: title, practices: practices, description: description),
      );

  Widget _buildPracticeButton(LearnLessonViewModel viewModel) =>
      CustomElevatedButton(
          height: 55,
          borderRadius: 12,
          text: 'Practice',
          backgroundColor: kcWhite,
          borderColor: kcPrimaryColor,
          foregroundColor: kcPrimaryColor,
          onTap: () async =>
              await viewModel.navigateToLearnPractice(practices));

  Widget _buildMotivationCard() => const MotivationCard();

  Widget _buildHeader() => Text(
        title,
        style: style18DG700,
      );

  Widget _buildListView(LearnLessonViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.lessons.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
          title: viewModel.lessons[index]['title'],
          status: viewModel.lessons[index]['status'],
          thumbnail: viewModel.lessons[index]['thumbnail'],
          onLessonTap: () async => await viewModel.navigateToLearnLessonDetail(
              title: title, practices: practices, description: description),
          // onPracticeTap: () async => await viewModel.navigateToLearnPractice(),
        ),
      );

  Widget _buildTile({
    required String title,
    required String thumbnail,
    GestureTapCallback? onLessonTap,
    required ProgressStatuses status,
    GestureTapCallback? onPracticeTap,
  }) =>
      LearnLessonTile(
        title: title,
        status: status,
        thumbnail: thumbnail,
        onLessonTap: onLessonTap,
        onPracticeTap: onPracticeTap,
      );
}
