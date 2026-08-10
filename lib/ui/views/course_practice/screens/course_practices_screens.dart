import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/course_practice_card.dart';
import '../../../widgets/small_app_bar.dart';
import '../course_practice_viewmodel.dart';

class CoursePracticesScreens extends ViewModelWidget<CoursePracticeViewModel> {
  final SubscriptionType type;
  final TextEditingController practiceController;

  const CoursePracticesScreens(
      {super.key, required this.type, required this.practiceController});

  void _reset(CoursePracticeViewModel viewModel) {
    viewModel.resetValues();
    practiceController.clear();
  }

  Future<void> _navigate(
      {required int index,
      required BuildContext context,
      required CoursePracticeViewModel viewModel}) async {

    await viewModel.updatePaymentStatus();

    if (type == SubscriptionType.duolingo) {
      if (viewModel.user?.duolingo ?? false) {
        _reset(viewModel);
        await viewModel.getCoursePracticeQuestions(
            context: context,
            id: viewModel.practices[index].questionSetId ?? 0);
      } else {
        await viewModel.navigateToCourseSubscription(SubscriptionType.duolingo);
      }
    } else {
      if (viewModel.user?.ielts ?? false) {
        _reset(viewModel);
        await viewModel.getCoursePracticeQuestions(
            context: context,
            id: viewModel.practices[index].questionSetId ?? 0);
      } else {
        await viewModel.navigateToCourseSubscription(SubscriptionType.ielts);
      }
    }
  }

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      SafeArea(
        child: _buildBody(context: context, viewModel: viewModel),
      );

  Widget _buildBody(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(context: context, viewModel: viewModel),
      );

  Widget _buildColumn(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          _buildPracticeColumnWrapper(context: context, viewModel: viewModel),
        ],
      );

  Widget _buildAppBar(CoursePracticeViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.goBack,
      );

  Widget _buildPracticeColumnWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Expanded(
        child: _buildPracticeColumnScrollView(
            context: context, viewModel: viewModel),
      );

  Widget _buildPracticeColumnScrollView(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildPracticeColumn(context: context, viewModel: viewModel),
      );

  Widget _buildPracticeColumn(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildPracticeColumnChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildPracticeColumnChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildListView(context: context, viewModel: viewModel)
      ];

  Widget _buildTitle() => Text(
        SubscriptionType.duolingo == type ? 'Duolingo' : 'IELTS',
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        'Select your target exam and start preparing',
        style: style14DG400,
      );

  Widget _buildListView(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      GridView.builder(
        shrinkWrap: true,
        itemCount: viewModel.practices.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildCard(
          title: viewModel.practices[index].title ?? '',
          onTap: () async => await _navigate(
              index: index, context: context, viewModel: viewModel),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1.5,
        ),
      );

  Widget _buildCard({
    required String title,
    required GestureTapCallback onTap,
  }) =>
      CoursePracticeCard(
        title: title,
        onTap: onTap,
      );
}
