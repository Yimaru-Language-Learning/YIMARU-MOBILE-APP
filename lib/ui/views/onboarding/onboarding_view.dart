import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:yimaru_app/ui/views/onboarding/screens/age_group_form_screen.dart';
import 'package:yimaru_app/ui/views/onboarding/screens/challenge_form_screen.dart';
import 'package:yimaru_app/ui/views/onboarding/screens/country_region_form_screen.dart';
import 'package:yimaru_app/ui/views/onboarding/screens/educational_background_form_screen.dart';
import 'package:yimaru_app/ui/views/onboarding/screens/full_name_form_screen.dart';
import 'package:yimaru_app/ui/views/onboarding/screens/gender_form_screen.dart';
import 'package:yimaru_app/ui/views/onboarding/screens/language_goal_form_screen.dart';
import 'package:yimaru_app/ui/views/onboarding/screens/learning_goal_form_screen.dart';
import 'package:yimaru_app/ui/views/onboarding/screens/occupation_form_screen.dart';
import 'package:yimaru_app/ui/views/onboarding/screens/topic_form_screen.dart';

import '../../common/validators/form_validator.dart';
import 'onboarding_viewmodel.dart';
import 'onboarding_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'topic', validator: FormValidator.validateForm),
  FormTextField(
      name: 'fullName', validator: FormValidator.validateFullNameForm),
  FormTextField(name: 'region', validator: FormValidator.validateForm),
  FormTextField(name: 'challenge', validator: FormValidator.validateForm),
  FormTextField(name: 'occupation', validator: FormValidator.validateForm),
  FormTextField(name: 'languageGoal', validator: FormValidator.validateForm),
])
class OnboardingView extends StackedView<OnboardingViewModel>
    with $OnboardingView {
  const OnboardingView({Key? key}) : super(key: key);

  void _initUserData(OnboardingViewModel viewModel) {
    fullNameController.text = viewModel.googleUser?.displayName ?? '';
  }

  void _initClearData() {
    topicController.clear();
    regionController.clear();
    fullNameController.clear();
    challengeController.clear();
    occupationController.clear();
    languageGoalController.clear();
  }

  void _clearDataOnNavigation(OnboardingViewModel viewModel) {
    if (viewModel.currentPage == 0) {
      fullNameController.clear();
      viewModel.resetFullNameFormScreen();
    } else if (viewModel.currentPage == 1) {
      viewModel.resetGenderFormScreen();
    } else if (viewModel.currentPage == 2) {
      viewModel.resetAgeGroupFormScreen();
    } else if (viewModel.currentPage == 3) {
      viewModel.resetEducationalBackgroundFormScreen();
    } else if (viewModel.currentPage == 4) {
      occupationController.clear();
      viewModel.resetOccupationFormScreen();
    } else if (viewModel.currentPage == 5) {
      viewModel.resetCountryRegionFormScreen();
    } else if (viewModel.currentPage == 6) {
      viewModel.resetLearningGoalFormScreen();
    } else if (viewModel.currentPage == 7) {
      languageGoalController.clear();
      viewModel.resetLanguageGoalFormScreen();
    } else if (viewModel.currentPage == 8) {
      challengeController.clear();
      viewModel.resetChallengeFormScreen();
    } else if (viewModel.currentPage == 9) {
      topicController.clear();
      viewModel.resetTopicFormScreen();
    }
  }

  void _pop(OnboardingViewModel viewModel) {
    {
      _clearDataOnNavigation(viewModel);
      viewModel.goBack();
    }
  }

  @override
  void onViewModelReady(OnboardingViewModel viewModel) {
    _initClearData();
    _initUserData(viewModel);
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  OnboardingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OnboardingViewModel();

  @override
  Widget builder(
    BuildContext context,
    OnboardingViewModel viewModel,
    Widget? child,
  ) =>
      _buildOnboardingScreensWrapper(viewModel);

  Widget _buildOnboardingScreensWrapper(OnboardingViewModel viewModel) =>
      PopScope(
          canPop: viewModel.currentPage == 0 ? true : false,
          onPopInvokedWithResult: (value, data) => _pop(viewModel),
          child: _buildOnboardingScreens(viewModel));

  Widget _buildOnboardingScreens(OnboardingViewModel viewModel) => IndexedStack(
        index: viewModel.currentPage,
        children: _buildScreens(),
      );

  List<Widget> _buildScreens() => [
        _buildFullNameForm(),
        _buildGenderForm(),
        _buildAgeGroupForm(),
        _buildEducationalBackgroundForm(),
        _buildOccupationForm(),
        _buildCountryRegionForm(),
        _buildLearningGoalForm(),
        _buildLanguageGoalForm(),
        _buildChallengeForm(),
        _buildTopicForm(),
      ];

  Widget _buildFullNameForm() =>
      FullNameFormScreen(fullNameController: fullNameController);

  Widget _buildGenderForm() => const GenderFormScreen();

  Widget _buildAgeGroupForm() => const AgeGroupFormScreen();

  Widget _buildEducationalBackgroundForm() =>
      const EducationalBackgroundFormScreen();

  Widget _buildOccupationForm() =>
      OccupationFormScreen(occupationController: occupationController);

  Widget _buildCountryRegionForm() => CountryRegionFormScreen(
        regionController: regionController,
      );

  Widget _buildLearningGoalForm() => const LearningGoalFormScreen();

  Widget _buildLanguageGoalForm() =>
      LanguageGoalFormScreen(languageGoalController: languageGoalController);

  Widget _buildChallengeForm() =>
      ChallengeFormScreen(challengeController: challengeController);

  Widget _buildTopicForm() => TopicFormScreen(topicController: topicController);
}
