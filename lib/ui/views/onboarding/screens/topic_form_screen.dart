import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_view.form.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_small_radio_button.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

class TopicFormScreen extends ViewModelWidget<OnboardingViewModel> {
  final TextEditingController topicController;

  const TopicFormScreen({super.key, required this.topicController});

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'profile_completed': true,
      'preferred_language': 'en',
      'favoutite_topic': viewModel.selectedTopic ?? topicController.text,
    };
    viewModel.addUserData(data);

    await viewModel.navigateToAssessment();
  }

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(OnboardingViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(OnboardingViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(OnboardingViewModel viewModel) =>
      [_buildAppBar(viewModel), _buildExpandedBody(viewModel)];

  Widget _buildAppBar(OnboardingViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        onPop: viewModel.pop,
        showLanguageSelection: true,
        onLanguage: () async => await viewModel.navigateToLanguage(),
      );

  Widget _buildExpandedBody(OnboardingViewModel viewModel) =>
      Expanded(child: _buildBodyScroller(viewModel));

  Widget _buildBodyScroller(OnboardingViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildBodyWrapper(viewModel),
      );

  Widget _buildBodyWrapper(OnboardingViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(OnboardingViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(OnboardingViewModel viewModel) =>
      [_buildUpperColumn(viewModel), _buildContinueButtonWrapper(viewModel)];

  Widget _buildUpperColumn(OnboardingViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(OnboardingViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubTitle(),
        verticalSpaceMedium,
        _buildTopics(viewModel),
        if (viewModel.showTopicTextBox) _buildTopicFormField(viewModel),
        if (viewModel.showTopicTextBox &&
            viewModel.hasTopicValidationMessage &&
            viewModel.focusTopic)
          verticalSpaceTiny,
        if (viewModel.showTopicTextBox &&
            viewModel.hasTopicValidationMessage &&
            viewModel.focusTopic)
          _buildTopicWrapper(viewModel),
        verticalSpaceMedium,
      ];

  Widget _buildTitle() => const Text(
        'Which topics interest you most?',
        style: TextStyle(
          fontSize: 25,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildSubTitle() => const Text(
        'Your favorite topics help us create fun, relatable lessons.',
        style: TextStyle(color: kcMediumGrey),
      );

  Widget _buildTopics(OnboardingViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: viewModel.topics.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTopic(
          title: viewModel.topics[index],
          selected: viewModel.isSelectedTopic(viewModel.topics[index]),
          onTap: () => viewModel.setSelectedTopic(viewModel.topics[index]),
        ),
      );

  Widget _buildTopic(
          {required String title,
          required bool selected,
          required GestureTapCallback onTap}) =>
      CustomSmallRadioButton(
        title: title,
        onTap: onTap,
        selected: selected,
      );

  Widget _buildTopicFormField(OnboardingViewModel viewModel) => TextFormField(
        maxLines: 3,
        controller: topicController,
        onTap: viewModel.setTopicsFocus,
        decoration: inputDecoration(
            focus: true,
            hint: 'Write you interest…',
            filled: topicController.text.isNotEmpty),
      );

  Widget _buildTopicWrapper(OnboardingViewModel viewModel) =>
      viewModel.hasTopicValidationMessage
          ? _buildTopicValidator(viewModel)
          : Container();

  Widget _buildTopicValidator(OnboardingViewModel viewModel) => Text(
        viewModel.topicValidationMessage!,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _buildContinueButtonWrapper(OnboardingViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(OnboardingViewModel viewModel) =>
      CustomElevatedButton(
          height: 55,
          text: 'Continue',
          borderRadius: 12,
          foregroundColor: kcWhite,
          onTap: viewModel.selectedTopic != null
              ? viewModel.selectedTopic?.toLowerCase() == 'other'
                  ? topicController.text.isNotEmpty
                      ? () async => await _next(viewModel)
                      : null
                  : () async => await _next(viewModel)
              : null,
          backgroundColor: viewModel.selectedTopic != null
              ? viewModel.selectedTopic?.toLowerCase() == 'other'
                  ? topicController.text.isNotEmpty
                      ? kcPrimaryColor
                      : kcPrimaryColor.withOpacity(0.1)
                  : kcPrimaryColor
              : kcPrimaryColor.withOpacity(0.1));
}
