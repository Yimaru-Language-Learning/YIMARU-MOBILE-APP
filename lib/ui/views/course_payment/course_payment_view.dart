import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/course_payment_card.dart';
import 'package:yimaru_app/ui/widgets/custom_list_tile.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/small_app_bar.dart';
import 'course_payment_viewmodel.dart';

class CoursePaymentView extends StackedView<CoursePaymentViewModel> {
  const CoursePaymentView({Key? key}) : super(key: key);

  @override
  CoursePaymentViewModel viewModelBuilder(BuildContext context) =>
      CoursePaymentViewModel();

  @override
  Widget builder(
    BuildContext context,
    CoursePaymentViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CoursePaymentViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CoursePaymentViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(CoursePaymentViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(CoursePaymentViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          _buildPracticeColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(CoursePaymentViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        showBackButton: true,
      );

  Widget _buildPracticeColumnWrapper(CoursePaymentViewModel viewModel) =>
      Expanded(child: _buildPracticeColumnScrollView(viewModel));

  Widget _buildPracticeColumnScrollView(CoursePaymentViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildPracticeColumn(viewModel),
      );

  Widget _buildPracticeColumn(CoursePaymentViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildPracticeColumnChildren(viewModel),
      );

  List<Widget> _buildPracticeColumnChildren(CoursePaymentViewModel viewModel) =>
      [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildFirstCard(),
        verticalSpaceMedium,
        _buildSecondCard()
      ];

  Widget _buildTitle() => Text(
        'Unlock All Lessons & Practices',
        style: style20DG700,
      );

  Widget _buildFirstCard() => const CoursePaymentCard(
        icon: Icons.school,
        title: '50+ New Lessons',
        subtitle: 'Access fresh, advanced content',
      );

  Widget _buildSecondCard() => const CoursePaymentCard(
        icon: Icons.developer_board,
        title: 'Mastery Through Practice',
        subtitle: 'Practice All Question Types & Take Mock Exams',
      );
}
