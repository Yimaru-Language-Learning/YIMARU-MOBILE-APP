// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i29;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i30;
import 'package:yimaru_app/ui/views/account_privacy/account_privacy_view.dart'
    as _i10;
import 'package:yimaru_app/ui/views/assessment/assessment_view.dart' as _i23;
import 'package:yimaru_app/ui/views/call_support/call_support_view.dart'
    as _i13;
import 'package:yimaru_app/ui/views/downloads/downloads_view.dart' as _i7;
import 'package:yimaru_app/ui/views/failure/failure_view.dart' as _i25;
import 'package:yimaru_app/ui/views/forget_password/forget_password_view.dart'
    as _i26;
import 'package:yimaru_app/ui/views/home/home_view.dart' as _i2;
import 'package:yimaru_app/ui/views/language/language_view.dart' as _i14;
import 'package:yimaru_app/ui/views/learn/learn_view.dart' as _i19;
import 'package:yimaru_app/ui/views/learn_lesson/learn_lesson_view.dart'
    as _i24;
import 'package:yimaru_app/ui/views/learn_lesson_detail/learn_lesson_detail_view.dart'
    as _i27;
import 'package:yimaru_app/ui/views/learn_level/learn_level_view.dart' as _i20;
import 'package:yimaru_app/ui/views/learn_module/learn_module_view.dart'
    as _i21;
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_view.dart'
    as _i28;
import 'package:yimaru_app/ui/views/login/login_view.dart' as _i18;
import 'package:yimaru_app/ui/views/onboarding/onboarding_view.dart' as _i3;
import 'package:yimaru_app/ui/views/ongoing_progress/ongoing_progress_view.dart'
    as _i9;
import 'package:yimaru_app/ui/views/privacy_policy/privacy_policy_view.dart'
    as _i15;
import 'package:yimaru_app/ui/views/profile/profile_view.dart' as _i5;
import 'package:yimaru_app/ui/views/profile_detail/profile_detail_view.dart'
    as _i6;
import 'package:yimaru_app/ui/views/progress/progress_view.dart' as _i8;
import 'package:yimaru_app/ui/views/register/register_view.dart' as _i17;
import 'package:yimaru_app/ui/views/startup/startup_view.dart' as _i4;
import 'package:yimaru_app/ui/views/support/support_view.dart' as _i11;
import 'package:yimaru_app/ui/views/telegram_support/telegram_support_view.dart'
    as _i12;
import 'package:yimaru_app/ui/views/terms_and_conditions/terms_and_conditions_view.dart'
    as _i16;
import 'package:yimaru_app/ui/views/welcome/welcome_view.dart' as _i22;

class Routes {
  static const homeView = '/home-view';

  static const onboardingView = '/onboarding-view';

  static const startupView = '/startup-view';

  static const profileView = '/profile-view';

  static const profileDetailView = '/profile-detail-view';

  static const downloadsView = '/downloads-view';

  static const progressView = '/progress-view';

  static const ongoingProgressView = '/ongoing-progress-view';

  static const accountPrivacyView = '/account-privacy-view';

  static const supportView = '/support-view';

  static const telegramSupportView = '/telegram-support-view';

  static const callSupportView = '/call-support-view';

  static const languageView = '/language-view';

  static const privacyPolicyView = '/privacy-policy-view';

  static const termsAndConditionsView = '/terms-and-conditions-view';

  static const registerView = '/register-view';

  static const loginView = '/login-view';

  static const learnView = '/learn-view';

  static const learnLevelView = '/learn-level-view';

  static const learnModuleView = '/learn-module-view';

  static const welcomeView = '/welcome-view';

  static const assessmentView = '/assessment-view';

  static const learnLessonView = '/learn-lesson-view';

  static const failureView = '/failure-view';

  static const forgetPasswordView = '/forget-password-view';

  static const learnLessonDetailView = '/learn-lesson-detail-view';

  static const learnPracticeView = '/learn-practice-view';

  static const all = <String>{
    homeView,
    onboardingView,
    startupView,
    profileView,
    profileDetailView,
    downloadsView,
    progressView,
    ongoingProgressView,
    accountPrivacyView,
    supportView,
    telegramSupportView,
    callSupportView,
    languageView,
    privacyPolicyView,
    termsAndConditionsView,
    registerView,
    loginView,
    learnView,
    learnLevelView,
    learnModuleView,
    welcomeView,
    assessmentView,
    learnLessonView,
    failureView,
    forgetPasswordView,
    learnLessonDetailView,
    learnPracticeView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.onboardingView,
      page: _i3.OnboardingView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i4.StartupView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i5.ProfileView,
    ),
    _i1.RouteDef(
      Routes.profileDetailView,
      page: _i6.ProfileDetailView,
    ),
    _i1.RouteDef(
      Routes.downloadsView,
      page: _i7.DownloadsView,
    ),
    _i1.RouteDef(
      Routes.progressView,
      page: _i8.ProgressView,
    ),
    _i1.RouteDef(
      Routes.ongoingProgressView,
      page: _i9.OngoingProgressView,
    ),
    _i1.RouteDef(
      Routes.accountPrivacyView,
      page: _i10.AccountPrivacyView,
    ),
    _i1.RouteDef(
      Routes.supportView,
      page: _i11.SupportView,
    ),
    _i1.RouteDef(
      Routes.telegramSupportView,
      page: _i12.TelegramSupportView,
    ),
    _i1.RouteDef(
      Routes.callSupportView,
      page: _i13.CallSupportView,
    ),
    _i1.RouteDef(
      Routes.languageView,
      page: _i14.LanguageView,
    ),
    _i1.RouteDef(
      Routes.privacyPolicyView,
      page: _i15.PrivacyPolicyView,
    ),
    _i1.RouteDef(
      Routes.termsAndConditionsView,
      page: _i16.TermsAndConditionsView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i17.RegisterView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i18.LoginView,
    ),
    _i1.RouteDef(
      Routes.learnView,
      page: _i19.LearnView,
    ),
    _i1.RouteDef(
      Routes.learnLevelView,
      page: _i20.LearnLevelView,
    ),
    _i1.RouteDef(
      Routes.learnModuleView,
      page: _i21.LearnModuleView,
    ),
    _i1.RouteDef(
      Routes.welcomeView,
      page: _i22.WelcomeView,
    ),
    _i1.RouteDef(
      Routes.assessmentView,
      page: _i23.AssessmentView,
    ),
    _i1.RouteDef(
      Routes.learnLessonView,
      page: _i24.LearnLessonView,
    ),
    _i1.RouteDef(
      Routes.failureView,
      page: _i25.FailureView,
    ),
    _i1.RouteDef(
      Routes.forgetPasswordView,
      page: _i26.ForgetPasswordView,
    ),
    _i1.RouteDef(
      Routes.learnLessonDetailView,
      page: _i27.LearnLessonDetailView,
    ),
    _i1.RouteDef(
      Routes.learnPracticeView,
      page: _i28.LearnPracticeView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.OnboardingView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.OnboardingView(),
        settings: data,
      );
    },
    _i4.StartupView: (data) {
      final args = data.getArgs<StartupViewArguments>(
        orElse: () => const StartupViewArguments(),
      );
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.StartupView(key: args.key, label: args.label),
        settings: data,
      );
    },
    _i5.ProfileView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.ProfileView(),
        settings: data,
      );
    },
    _i6.ProfileDetailView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.ProfileDetailView(),
        settings: data,
      );
    },
    _i7.DownloadsView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.DownloadsView(),
        settings: data,
      );
    },
    _i8.ProgressView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.ProgressView(),
        settings: data,
      );
    },
    _i9.OngoingProgressView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.OngoingProgressView(),
        settings: data,
      );
    },
    _i10.AccountPrivacyView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.AccountPrivacyView(),
        settings: data,
      );
    },
    _i11.SupportView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.SupportView(),
        settings: data,
      );
    },
    _i12.TelegramSupportView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.TelegramSupportView(),
        settings: data,
      );
    },
    _i13.CallSupportView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.CallSupportView(),
        settings: data,
      );
    },
    _i14.LanguageView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.LanguageView(),
        settings: data,
      );
    },
    _i15.PrivacyPolicyView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.PrivacyPolicyView(),
        settings: data,
      );
    },
    _i16.TermsAndConditionsView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.TermsAndConditionsView(),
        settings: data,
      );
    },
    _i17.RegisterView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.RegisterView(),
        settings: data,
      );
    },
    _i18.LoginView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i18.LoginView(),
        settings: data,
      );
    },
    _i19.LearnView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i19.LearnView(),
        settings: data,
      );
    },
    _i20.LearnLevelView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i20.LearnLevelView(),
        settings: data,
      );
    },
    _i21.LearnModuleView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i21.LearnModuleView(),
        settings: data,
      );
    },
    _i22.WelcomeView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i22.WelcomeView(),
        settings: data,
      );
    },
    _i23.AssessmentView: (data) {
      final args = data.getArgs<AssessmentViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i23.AssessmentView(key: args.key, data: args.data),
        settings: data,
      );
    },
    _i24.LearnLessonView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i24.LearnLessonView(),
        settings: data,
      );
    },
    _i25.FailureView: (data) {
      final args = data.getArgs<FailureViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i25.FailureView(key: args.key, label: args.label),
        settings: data,
      );
    },
    _i26.ForgetPasswordView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i26.ForgetPasswordView(),
        settings: data,
      );
    },
    _i27.LearnLessonDetailView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i27.LearnLessonDetailView(),
        settings: data,
      );
    },
    _i28.LearnPracticeView: (data) {
      final args = data.getArgs<LearnPracticeViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i28.LearnPracticeView(
            key: args.key,
            title: args.title,
            subtitle: args.subtitle,
            buttonLabel: args.buttonLabel),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class StartupViewArguments {
  const StartupViewArguments({
    this.key,
    this.label = 'Loading',
  });

  final _i29.Key? key;

  final String label;

  @override
  String toString() {
    return '{"key": "$key", "label": "$label"}';
  }

  @override
  bool operator ==(covariant StartupViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.label == label;
  }

  @override
  int get hashCode {
    return key.hashCode ^ label.hashCode;
  }
}

class AssessmentViewArguments {
  const AssessmentViewArguments({
    this.key,
    required this.data,
  });

  final _i29.Key? key;

  final Map<String, dynamic> data;

  @override
  String toString() {
    return '{"key": "$key", "data": "$data"}';
  }

  @override
  bool operator ==(covariant AssessmentViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.data == data;
  }

  @override
  int get hashCode {
    return key.hashCode ^ data.hashCode;
  }
}

class FailureViewArguments {
  const FailureViewArguments({
    this.key,
    required this.label,
  });

  final _i29.Key? key;

  final String label;

  @override
  String toString() {
    return '{"key": "$key", "label": "$label"}';
  }

  @override
  bool operator ==(covariant FailureViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.label == label;
  }

  @override
  int get hashCode {
    return key.hashCode ^ label.hashCode;
  }
}

class LearnPracticeViewArguments {
  const LearnPracticeViewArguments({
    this.key,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
  });

  final _i29.Key? key;

  final String title;

  final String subtitle;

  final String buttonLabel;

  @override
  String toString() {
    return '{"key": "$key", "title": "$title", "subtitle": "$subtitle", "buttonLabel": "$buttonLabel"}';
  }

  @override
  bool operator ==(covariant LearnPracticeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.buttonLabel == buttonLabel;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        buttonLabel.hashCode;
  }
}

extension NavigatorStateExtension on _i30.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnboardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.onboardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView({
    _i29.Key? key,
    String label = 'Loading',
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.startupView,
        arguments: StartupViewArguments(key: key, label: label),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileDetailView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileDetailView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDownloadsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.downloadsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProgressView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.progressView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOngoingProgressView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.ongoingProgressView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAccountPrivacyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.accountPrivacyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSupportView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.supportView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTelegramSupportView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.telegramSupportView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCallSupportView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.callSupportView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLanguageView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.languageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPrivacyPolicyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.privacyPolicyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTermsAndConditionsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.termsAndConditionsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.learnView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnLevelView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.learnLevelView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnModuleView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.learnModuleView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWelcomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.welcomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAssessmentView({
    _i29.Key? key,
    required Map<String, dynamic> data,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.assessmentView,
        arguments: AssessmentViewArguments(key: key, data: data),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnLessonView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.learnLessonView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFailureView({
    _i29.Key? key,
    required String label,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.failureView,
        arguments: FailureViewArguments(key: key, label: label),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgetPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.forgetPasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnLessonDetailView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.learnLessonDetailView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnPracticeView({
    _i29.Key? key,
    required String title,
    required String subtitle,
    required String buttonLabel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnPracticeView,
        arguments: LearnPracticeViewArguments(
            key: key,
            title: title,
            subtitle: subtitle,
            buttonLabel: buttonLabel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnboardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.onboardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView({
    _i29.Key? key,
    String label = 'Loading',
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.startupView,
        arguments: StartupViewArguments(key: key, label: label),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileDetailView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileDetailView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDownloadsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.downloadsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProgressView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.progressView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOngoingProgressView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.ongoingProgressView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAccountPrivacyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.accountPrivacyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSupportView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.supportView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTelegramSupportView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.telegramSupportView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCallSupportView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.callSupportView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLanguageView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.languageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPrivacyPolicyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.privacyPolicyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTermsAndConditionsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.termsAndConditionsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.learnView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnLevelView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.learnLevelView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnModuleView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.learnModuleView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWelcomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.welcomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAssessmentView({
    _i29.Key? key,
    required Map<String, dynamic> data,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.assessmentView,
        arguments: AssessmentViewArguments(key: key, data: data),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnLessonView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.learnLessonView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFailureView({
    _i29.Key? key,
    required String label,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.failureView,
        arguments: FailureViewArguments(key: key, label: label),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithForgetPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.forgetPasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnLessonDetailView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.learnLessonDetailView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnPracticeView({
    _i29.Key? key,
    required String title,
    required String subtitle,
    required String buttonLabel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnPracticeView,
        arguments: LearnPracticeViewArguments(
            key: key,
            title: title,
            subtitle: subtitle,
            buttonLabel: buttonLabel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
