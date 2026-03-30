import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/course_payment_card.dart';
import 'package:yimaru_app/ui/widgets/course_pricing_card.dart';

import '../../../models/course.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/small_app_bar.dart';
import 'course_payment_viewmodel.dart';

class CoursePaymentView extends StackedView<CoursePaymentViewModel> {
  final Course course;

  const CoursePaymentView({Key? key, required this.course}) : super(key: key);

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
          verticalSpaceMedium,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildPracticeColumnChildren(viewModel),
      );

  List<Widget> _buildPracticeColumnChildren(CoursePaymentViewModel viewModel) =>
      [
        verticalSpaceMedium,
        _buildTitleWrapper(),
        verticalSpaceMedium,
        _buildFirstCard(),
        verticalSpaceMedium,
        _buildSecondCard(),
        verticalSpaceLarge,
        _buildSubtitleWrapper(),
        verticalSpaceSmall,
        _buildCoursePricingCard(),
        verticalSpaceMedium,
        _buildSubscribeButton(viewModel),
        verticalSpaceMedium,
        _buildSecurePaymentWrapper()
      ];

  Widget _buildTitleWrapper() => Align(
        alignment: Alignment.center,
        child: _buildTitle(),
      );

  Widget _buildTitle() => Text(
        'Unlock All Lessons & Practices',
        style: style18DG700,
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

  Widget _buildSubtitleWrapper() => Align(
        alignment: Alignment.centerLeft,
        child: _buildSubtitle(),
      );

  Widget _buildSubtitle() => Text(
        'Choose Your Learning Plan',
        style: style16DG600,
      );

  Widget _buildCoursePricingCard() => const CoursePricingCard();

  Widget _buildSubscribeButton(CoursePaymentViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Subscribe Now',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await viewModel.navigateToCourseLesson(course),
      );

  Widget _buildSecurePaymentWrapper() => Align(
        alignment: Alignment.center,
        child: _buildSecurePayment(),
      );

  Widget _buildSecurePayment() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildSecurePaymentChildren(),
      );

  List<Widget> _buildSecurePaymentChildren() =>
      [_buildTileLeading(), horizontalSpaceTiny, _buildTileTitle()];

  Widget _buildTileLeading() => const Icon(
        Icons.lock_outline_rounded,
        size: 16,
        color: kcMediumGrey,
      );

  Widget _buildTileTitle() => Text(
        'Unlock All Lessons & Practices',
        style: style14MG400,
        textAlign: TextAlign.center,
      );
}
