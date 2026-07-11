import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/duolingo_practice_review_section.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../course_practice_viewmodel.dart';

class DuolingoWritingPractice1Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  final TextEditingController practiceController;

  const DuolingoWritingPractice1Review(
      {super.key, required this.practiceController});

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.goBack();
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (cxt) => _buildSheet(viewModel),
      );

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
      SafeArea(child: _buildBodyColumn(context: context, viewModel: viewModel));

  Widget _buildBodyColumn(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            _buildBodyColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyColumnChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        _buildAppBarIndenter(context: context, viewModel: viewModel),
        _buildExpandedBody(context: context,viewModel: viewModel),
      ];

  Widget _buildAppBarIndenter(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBarWrapper(context: context, viewModel: viewModel),
      );

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceSmall,
          _buildCountdownWrapper(context: context,viewModel: viewModel),
          verticalSpaceSmall
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CoursePracticeAppBar(
        onClose: () async =>
            await _showSheet(context: context, viewModel: viewModel),
        title:
            'Writing practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildCountdownWrapper({required BuildContext context, required CoursePracticeViewModel viewModel}) => Align(
        alignment: Alignment.centerRight,
        child: _buildCountdown(context: context,viewModel: viewModel),
      );

  Widget _buildCountdown({required BuildContext context, required CoursePracticeViewModel viewModel}) =>
      const CountdownTimer(time: '00:00');

  Widget _buildExpandedBody({required BuildContext context, required CoursePracticeViewModel viewModel}) =>
      Expanded(child: _buildBodyScroller(context: context,viewModel: viewModel));

  Widget _buildBodyScroller({required BuildContext context, required CoursePracticeViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildQuestionWrapper(context: context,viewModel: viewModel),
      );

  Widget _buildQuestionWrapper({required BuildContext context, required CoursePracticeViewModel viewModel}) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildQuestionChildren(context: context,viewModel: viewModel),
      );

  List<Widget> _buildQuestionChildren({required BuildContext context, required CoursePracticeViewModel viewModel}) => [
        verticalSpaceMedium,
        _buildTitleWrapper(viewModel),
        verticalSpaceMedium,
        _buildImageContainer(viewModel),
        verticalSpaceMedium,
        _buildPracticeFormFieldWrapper(viewModel),
        verticalSpaceMedium,
        _buildPracticeReviewSection(context: context,viewModel: viewModel)
      ];
  Widget _buildTitleWrapper(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildTitle(viewModel),
      );

  Widget _buildTitle(CoursePracticeViewModel viewModel) => Text(
        'Write a description of the image below for ${viewModel.questions[viewModel.currentQuestion].dynamicPayload?.response?.first.value['seconds']} seconds',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildImageContainer(CoursePracticeViewModel viewModel) => SizedBox(
        width: 250,
        height: 300,
        child: _buildImageWrapper(viewModel),
      );

  Widget _buildImageWrapper(CoursePracticeViewModel viewModel) => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: _buildImage(viewModel),
      );

  Widget _buildImage(CoursePracticeViewModel viewModel) => CachedNetworkImage(
        fit: BoxFit.fill,
        width: double.maxFinite,
        imageUrl: viewModel.cachedImage ?? '',
      );

  Widget _buildPracticeFormFieldWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildPracticeFormField(viewModel),
      );

  Widget _buildPracticeFormField(CoursePracticeViewModel viewModel) =>
      TextFormField(
        maxLines: 5,
        maxLength: 250,
        enabled: false,
        controller: practiceController,
        decoration: inputDecoration(
            focus: true,
            hint: 'Start writing here...',
            filled: practiceController.text.isNotEmpty),
      );

  Widget _buildPracticeReviewSection({required BuildContext context, required CoursePracticeViewModel viewModel}) =>
      DuolingoPracticeReviewSection(
        onTap: viewModel.currentQuestion == viewModel.questions.length - 1
            ? viewModel.nextScreen
            : () async => await viewModel.nextQuestion(context),
        review: viewModel.answers,
      );
}
