import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_lesson.dart';
import 'package:yimaru_app/models/learn_module.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/learn_lesson_tile.dart';
import 'package:yimaru_app/ui/widgets/module_progress.dart';
import 'package:yimaru_app/ui/widgets/motivation_card.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_lesson_viewmodel.dart';

class LearnLessonView extends StackedView<LearnLessonViewModel> {
  final LearnModule module;

  const LearnLessonView({Key? key, required this.module}) : super(key: key);

  Future<void> _onPractice(
      {required int index,
      required LearnLesson lesson,
      required LearnLessonViewModel viewModel}) async {
    if (index > 1) {

      print(index);
      print(viewModel.user?.subscriptionStatus);
      if (viewModel.user?.subscriptionStatus?.toLowerCase() == 'subscribed') {
        await viewModel.navigateToLearnPractice(lesson.id ?? 0);
      } else {
        await viewModel.navigateToLearnSubscription();
      }
    } else {
      await viewModel.navigateToLearnPractice(lesson.id ?? 0);
    }
  }

  @override
  void onViewModelReady(LearnLessonViewModel viewModel) async {
    await viewModel.getLessons(module.id ?? 0);
    super.onViewModelReady(viewModel);
  }

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
        body: _buildScaffoldContainer(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldContainer(
          {required BuildContext context,
          required LearnLessonViewModel viewModel}) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffold(context: context, viewModel: viewModel),
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
        onPop: viewModel.pop,
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
        _buildModuleProgress(viewModel),
        verticalSpaceLarge,
        _buildMotivationCard(),
        verticalSpaceLarge,
        _buildHeader(),
        verticalSpaceMedium,
        _buildListViewBuilder(viewModel),
      ];

  Widget _buildTitle() => Text(
        module.name ?? '',
        style: style16DG600,
      );

  Widget _buildSubtitle() => Text(
        module.description ?? '',
        style: style14DG500,
      );

  Widget _buildModuleProgress(LearnLessonViewModel viewModel) => ModuleProgress(
        total: (viewModel.getUpdatedLearnModule(module.id ?? 0) ?? module)
                .access
                ?.totalCount ??
            0,
        completed: (viewModel.getUpdatedLearnModule(module.id ?? 0) ?? module)
                .access
                ?.completedCount ??
            0,
        progress: (viewModel.getUpdatedLearnModule(module.id ?? 0) ?? module)
                .access
                ?.progressPercent ??
            0,
      );

  Widget _buildMotivationCard() => const MotivationCard();

  Widget _buildHeader() => Text(
        LocaleKeys.lessons_in_module.tr(),
        style: style18DG700,
      );

  Widget _buildListViewBuilder(LearnLessonViewModel viewModel) =>
      viewModel.busy(StateObjects.learnLessons)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(LearnLessonViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.lessons.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(
          index: index,
          lesson: viewModel.lessons[index],
          onPracticeTap: () async => await _onPractice(
            index: index,
            viewModel: viewModel,
            lesson: viewModel.lessons[index],
          ),
          onLessonTap: () async => await viewModel.navigateToLearnLessonDetail(
              module: module,
              lesson: viewModel.lessons[index],
              hasPractice:
                  index != viewModel.lessons.length - 1 ? true : false),
        ),
      );

  Widget _buildTile({
    required int index,
    required LearnLesson lesson,
    required GestureTapCallback? onLessonTap,
    required GestureTapCallback? onPracticeTap,
  }) =>
      LearnLessonTile(
        index: index,
        lesson: lesson,
        onLessonTap: onLessonTap,
        onPracticeTap: onPracticeTap,
      );
}
