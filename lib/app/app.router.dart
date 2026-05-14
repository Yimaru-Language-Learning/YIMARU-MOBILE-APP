// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as _i39;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i47;
import 'package:yimaru_app/models/course.dart' as _i44;
import 'package:yimaru_app/models/course_catalog.dart' as _i46;
import 'package:yimaru_app/models/course_lesson.dart' as _i45;
import 'package:yimaru_app/models/learn_course.dart' as _i40;
import 'package:yimaru_app/models/learn_lesson.dart' as _i42;
import 'package:yimaru_app/models/learn_module.dart' as _i41;
import 'package:yimaru_app/ui/common/enmus.dart' as _i43;
import 'package:yimaru_app/ui/views/account_privacy/account_privacy_view.dart'
    as _i9;
import 'package:yimaru_app/ui/views/arif_pay/arif_pay_view.dart' as _i36;
import 'package:yimaru_app/ui/views/assessment/assessment_view.dart' as _i34;
import 'package:yimaru_app/ui/views/call_support/call_support_view.dart'
    as _i12;
import 'package:yimaru_app/ui/views/course/course_view.dart' as _i30;
import 'package:yimaru_app/ui/views/course_catalog/course_catalog_view.dart'
    as _i37;
import 'package:yimaru_app/ui/views/course_lesson/course_lesson_view.dart'
    as _i27;
import 'package:yimaru_app/ui/views/course_lesson_detail/course_lesson_detail_view.dart'
    as _i28;
import 'package:yimaru_app/ui/views/course_payment/course_payment_view.dart'
    as _i25;
import 'package:yimaru_app/ui/views/course_practice/course_practice_view.dart'
    as _i24;
import 'package:yimaru_app/ui/views/course_practice_question/course_practice_question_view.dart'
    as _i31;
import 'package:yimaru_app/ui/views/course_unit/course_unit_view.dart' as _i38;
import 'package:yimaru_app/ui/views/downloads/downloads_view.dart' as _i7;
import 'package:yimaru_app/ui/views/duolingo/duolingo_view.dart' as _i29;
import 'package:yimaru_app/ui/views/failure/failure_view.dart' as _i26;
import 'package:yimaru_app/ui/views/forget_password/forget_password_view.dart'
    as _i21;
import 'package:yimaru_app/ui/views/home/home_view.dart' as _i2;
import 'package:yimaru_app/ui/views/language/language_view.dart' as _i13;
import 'package:yimaru_app/ui/views/learn_course/learn_course_view.dart'
    as _i33;
import 'package:yimaru_app/ui/views/learn_lesson/learn_lesson_view.dart'
    as _i20;
import 'package:yimaru_app/ui/views/learn_lesson_detail/learn_lesson_detail_view.dart'
    as _i22;
import 'package:yimaru_app/ui/views/learn_module/learn_module_view.dart'
    as _i18;
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_view.dart'
    as _i23;
import 'package:yimaru_app/ui/views/learn_program/learn_program_view.dart'
    as _i32;
import 'package:yimaru_app/ui/views/learn_subscription/learn_subscription_view.dart'
    as _i35;
import 'package:yimaru_app/ui/views/login/login_view.dart' as _i17;
import 'package:yimaru_app/ui/views/onboarding/onboarding_view.dart' as _i3;
import 'package:yimaru_app/ui/views/privacy_policy/privacy_policy_view.dart'
    as _i14;
import 'package:yimaru_app/ui/views/profile/profile_view.dart' as _i5;
import 'package:yimaru_app/ui/views/profile_detail/profile_detail_view.dart'
    as _i6;
import 'package:yimaru_app/ui/views/progress/progress_view.dart' as _i8;
import 'package:yimaru_app/ui/views/register/register_view.dart' as _i16;
import 'package:yimaru_app/ui/views/startup/startup_view.dart' as _i4;
import 'package:yimaru_app/ui/views/support/support_view.dart' as _i10;
import 'package:yimaru_app/ui/views/telegram_support/telegram_support_view.dart'
    as _i11;
import 'package:yimaru_app/ui/views/terms_and_conditions/terms_and_conditions_view.dart'
    as _i15;
import 'package:yimaru_app/ui/views/welcome/welcome_view.dart' as _i19;

class Routes {
  static const homeView = '/home-view';

  static const onboardingView = '/onboarding-view';

  static const startupView = '/startup-view';

  static const profileView = '/profile-view';

  static const profileDetailView = '/profile-detail-view';

  static const downloadsView = '/downloads-view';

  static const progressView = '/progress-view';

  static const accountPrivacyView = '/account-privacy-view';

  static const supportView = '/support-view';

  static const telegramSupportView = '/telegram-support-view';

  static const callSupportView = '/call-support-view';

  static const languageView = '/language-view';

  static const privacyPolicyView = '/privacy-policy-view';

  static const termsAndConditionsView = '/terms-and-conditions-view';

  static const registerView = '/register-view';

  static const loginView = '/login-view';

  static const learnModuleView = '/learn-module-view';

  static const welcomeView = '/welcome-view';

  static const learnLessonView = '/learn-lesson-view';

  static const forgetPasswordView = '/forget-password-view';

  static const learnLessonDetailView = '/learn-lesson-detail-view';

  static const learnPracticeView = '/learn-practice-view';

  static const coursePracticeView = '/course-practice-view';

  static const coursePaymentView = '/course-payment-view';

  static const failureView = '/failure-view';

  static const courseLessonView = '/course-lesson-view';

  static const courseLessonDetailView = '/course-lesson-detail-view';

  static const duolingoView = '/duolingo-view';

  static const courseView = '/course-view';

  static const coursePracticeQuestionView = '/course-practice-question-view';

  static const learnProgramView = '/learn-program-view';

  static const learnCourseView = '/learn-course-view';

  static const assessmentView = '/assessment-view';

  static const learnSubscriptionView = '/learn-subscription-view';

  static const arifPayView = '/arif-pay-view';

  static const courseCatalogView = '/course-catalog-view';

  static const courseUnitView = '/course-unit-view';

  static const all = <String>{
    homeView,
    onboardingView,
    startupView,
    profileView,
    profileDetailView,
    downloadsView,
    progressView,
    accountPrivacyView,
    supportView,
    telegramSupportView,
    callSupportView,
    languageView,
    privacyPolicyView,
    termsAndConditionsView,
    registerView,
    loginView,
    learnModuleView,
    welcomeView,
    learnLessonView,
    forgetPasswordView,
    learnLessonDetailView,
    learnPracticeView,
    coursePracticeView,
    coursePaymentView,
    failureView,
    courseLessonView,
    courseLessonDetailView,
    duolingoView,
    courseView,
    coursePracticeQuestionView,
    learnProgramView,
    learnCourseView,
    assessmentView,
    learnSubscriptionView,
    arifPayView,
    courseCatalogView,
    courseUnitView,
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
      Routes.accountPrivacyView,
      page: _i9.AccountPrivacyView,
    ),
    _i1.RouteDef(
      Routes.supportView,
      page: _i10.SupportView,
    ),
    _i1.RouteDef(
      Routes.telegramSupportView,
      page: _i11.TelegramSupportView,
    ),
    _i1.RouteDef(
      Routes.callSupportView,
      page: _i12.CallSupportView,
    ),
    _i1.RouteDef(
      Routes.languageView,
      page: _i13.LanguageView,
    ),
    _i1.RouteDef(
      Routes.privacyPolicyView,
      page: _i14.PrivacyPolicyView,
    ),
    _i1.RouteDef(
      Routes.termsAndConditionsView,
      page: _i15.TermsAndConditionsView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i16.RegisterView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i17.LoginView,
    ),
    _i1.RouteDef(
      Routes.learnModuleView,
      page: _i18.LearnModuleView,
    ),
    _i1.RouteDef(
      Routes.welcomeView,
      page: _i19.WelcomeView,
    ),
    _i1.RouteDef(
      Routes.learnLessonView,
      page: _i20.LearnLessonView,
    ),
    _i1.RouteDef(
      Routes.forgetPasswordView,
      page: _i21.ForgetPasswordView,
    ),
    _i1.RouteDef(
      Routes.learnLessonDetailView,
      page: _i22.LearnLessonDetailView,
    ),
    _i1.RouteDef(
      Routes.learnPracticeView,
      page: _i23.LearnPracticeView,
    ),
    _i1.RouteDef(
      Routes.coursePracticeView,
      page: _i24.CoursePracticeView,
    ),
    _i1.RouteDef(
      Routes.coursePaymentView,
      page: _i25.CoursePaymentView,
    ),
    _i1.RouteDef(
      Routes.failureView,
      page: _i26.FailureView,
    ),
    _i1.RouteDef(
      Routes.courseLessonView,
      page: _i27.CourseLessonView,
    ),
    _i1.RouteDef(
      Routes.courseLessonDetailView,
      page: _i28.CourseLessonDetailView,
    ),
    _i1.RouteDef(
      Routes.duolingoView,
      page: _i29.DuolingoView,
    ),
    _i1.RouteDef(
      Routes.courseView,
      page: _i30.CourseView,
    ),
    _i1.RouteDef(
      Routes.coursePracticeQuestionView,
      page: _i31.CoursePracticeQuestionView,
    ),
    _i1.RouteDef(
      Routes.learnProgramView,
      page: _i32.LearnProgramView,
    ),
    _i1.RouteDef(
      Routes.learnCourseView,
      page: _i33.LearnCourseView,
    ),
    _i1.RouteDef(
      Routes.assessmentView,
      page: _i34.AssessmentView,
    ),
    _i1.RouteDef(
      Routes.learnSubscriptionView,
      page: _i35.LearnSubscriptionView,
    ),
    _i1.RouteDef(
      Routes.arifPayView,
      page: _i36.ArifPayView,
    ),
    _i1.RouteDef(
      Routes.courseCatalogView,
      page: _i37.CourseCatalogView,
    ),
    _i1.RouteDef(
      Routes.courseUnitView,
      page: _i38.CourseUnitView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => const HomeViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.HomeView(key: args.key),
        settings: data,
      );
    },
    _i3.OnboardingView: (data) {
      final args = data.getArgs<OnboardingViewArguments>(
        orElse: () => const OnboardingViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.OnboardingView(key: args.key),
        settings: data,
      );
    },
    _i4.StartupView: (data) {
      final args = data.getArgs<StartupViewArguments>(
        orElse: () => const StartupViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.StartupView(key: args.key, label: args.label),
        settings: data,
      );
    },
    _i5.ProfileView: (data) {
      final args = data.getArgs<ProfileViewArguments>(
        orElse: () => const ProfileViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.ProfileView(key: args.key),
        settings: data,
      );
    },
    _i6.ProfileDetailView: (data) {
      final args = data.getArgs<ProfileDetailViewArguments>(
        orElse: () => const ProfileDetailViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.ProfileDetailView(key: args.key),
        settings: data,
      );
    },
    _i7.DownloadsView: (data) {
      final args = data.getArgs<DownloadsViewArguments>(
        orElse: () => const DownloadsViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.DownloadsView(key: args.key),
        settings: data,
      );
    },
    _i8.ProgressView: (data) {
      final args = data.getArgs<ProgressViewArguments>(
        orElse: () => const ProgressViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.ProgressView(key: args.key),
        settings: data,
      );
    },
    _i9.AccountPrivacyView: (data) {
      final args = data.getArgs<AccountPrivacyViewArguments>(
        orElse: () => const AccountPrivacyViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.AccountPrivacyView(key: args.key),
        settings: data,
      );
    },
    _i10.SupportView: (data) {
      final args = data.getArgs<SupportViewArguments>(
        orElse: () => const SupportViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.SupportView(key: args.key),
        settings: data,
      );
    },
    _i11.TelegramSupportView: (data) {
      final args = data.getArgs<TelegramSupportViewArguments>(
        orElse: () => const TelegramSupportViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.TelegramSupportView(key: args.key),
        settings: data,
      );
    },
    _i12.CallSupportView: (data) {
      final args = data.getArgs<CallSupportViewArguments>(
        orElse: () => const CallSupportViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.CallSupportView(key: args.key),
        settings: data,
      );
    },
    _i13.LanguageView: (data) {
      final args = data.getArgs<LanguageViewArguments>(
        orElse: () => const LanguageViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.LanguageView(key: args.key),
        settings: data,
      );
    },
    _i14.PrivacyPolicyView: (data) {
      final args = data.getArgs<PrivacyPolicyViewArguments>(
        orElse: () => const PrivacyPolicyViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.PrivacyPolicyView(key: args.key),
        settings: data,
      );
    },
    _i15.TermsAndConditionsView: (data) {
      final args = data.getArgs<TermsAndConditionsViewArguments>(
        orElse: () => const TermsAndConditionsViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.TermsAndConditionsView(key: args.key),
        settings: data,
      );
    },
    _i16.RegisterView: (data) {
      final args = data.getArgs<RegisterViewArguments>(
        orElse: () => const RegisterViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.RegisterView(key: args.key),
        settings: data,
      );
    },
    _i17.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i17.LoginView(key: args.key),
        settings: data,
      );
    },
    _i18.LearnModuleView: (data) {
      final args = data.getArgs<LearnModuleViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i18.LearnModuleView(key: args.key, course: args.course),
        settings: data,
      );
    },
    _i19.WelcomeView: (data) {
      final args = data.getArgs<WelcomeViewArguments>(
        orElse: () => const WelcomeViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.WelcomeView(key: args.key),
        settings: data,
      );
    },
    _i20.LearnLessonView: (data) {
      final args = data.getArgs<LearnLessonViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i20.LearnLessonView(key: args.key, module: args.module),
        settings: data,
      );
    },
    _i21.ForgetPasswordView: (data) {
      final args = data.getArgs<ForgetPasswordViewArguments>(
        orElse: () => const ForgetPasswordViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i21.ForgetPasswordView(key: args.key),
        settings: data,
      );
    },
    _i22.LearnLessonDetailView: (data) {
      final args = data.getArgs<LearnLessonDetailViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i22.LearnLessonDetailView(
            key: args.key,
            lesson: args.lesson,
            module: args.module,
            hasPractice: args.hasPractice),
        settings: data,
      );
    },
    _i23.LearnPracticeView: (data) {
      final args = data.getArgs<LearnPracticeViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i23.LearnPracticeView(
            key: args.key,
            level: args.level,
            id: args.id,
            label: args.label,
            title: args.title,
            practice: args.practice,
            subtitle: args.subtitle),
        settings: data,
      );
    },
    _i24.CoursePracticeView: (data) {
      final args = data.getArgs<CoursePracticeViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i24.CoursePracticeView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i25.CoursePaymentView: (data) {
      final args = data.getArgs<CoursePaymentViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i25.CoursePaymentView(key: args.key, course: args.course),
        settings: data,
      );
    },
    _i26.FailureView: (data) {
      final args = data.getArgs<FailureViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i26.FailureView(
            key: args.key, onTap: args.onTap, label: args.label),
        settings: data,
      );
    },
    _i27.CourseLessonView: (data) {
      final args = data.getArgs<CourseLessonViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i27.CourseLessonView(key: args.key, course: args.course),
        settings: data,
      );
    },
    _i28.CourseLessonDetailView: (data) {
      final args = data.getArgs<CourseLessonDetailViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i28.CourseLessonDetailView(key: args.key, lesson: args.lesson),
        settings: data,
      );
    },
    _i29.DuolingoView: (data) {
      final args = data.getArgs<DuolingoViewArguments>(
        orElse: () => const DuolingoViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i29.DuolingoView(key: args.key),
        settings: data,
      );
    },
    _i30.CourseView: (data) {
      final args = data.getArgs<CourseViewArguments>(
        orElse: () => const CourseViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i30.CourseView(key: args.key),
        settings: data,
      );
    },
    _i31.CoursePracticeQuestionView: (data) {
      final args =
          data.getArgs<CoursePracticeQuestionViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i31.CoursePracticeQuestionView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i32.LearnProgramView: (data) {
      final args = data.getArgs<LearnProgramViewArguments>(
        orElse: () => const LearnProgramViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i32.LearnProgramView(key: args.key),
        settings: data,
      );
    },
    _i33.LearnCourseView: (data) {
      final args = data.getArgs<LearnCourseViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i33.LearnCourseView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i34.AssessmentView: (data) {
      final args = data.getArgs<AssessmentViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i34.AssessmentView(key: args.key, data: args.data),
        settings: data,
      );
    },
    _i35.LearnSubscriptionView: (data) {
      final args = data.getArgs<LearnSubscriptionViewArguments>(
        orElse: () => const LearnSubscriptionViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i35.LearnSubscriptionView(key: args.key),
        settings: data,
      );
    },
    _i36.ArifPayView: (data) {
      final args = data.getArgs<ArifPayViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i36.ArifPayView(key: args.key, phone: args.phone),
        settings: data,
      );
    },
    _i37.CourseCatalogView: (data) {
      final args = data.getArgs<CourseCatalogViewArguments>(
        orElse: () => const CourseCatalogViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i37.CourseCatalogView(key: args.key),
        settings: data,
      );
    },
    _i38.CourseUnitView: (data) {
      final args = data.getArgs<CourseUnitViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i38.CourseUnitView(key: args.key, catalog: args.catalog),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeViewArguments {
  const HomeViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant HomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class OnboardingViewArguments {
  const OnboardingViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant OnboardingViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class StartupViewArguments {
  const StartupViewArguments({
    this.key,
    this.label = 'Loading',
  });

  final _i39.Key? key;

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

class ProfileViewArguments {
  const ProfileViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ProfileDetailViewArguments {
  const ProfileDetailViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ProfileDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class DownloadsViewArguments {
  const DownloadsViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant DownloadsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ProgressViewArguments {
  const ProgressViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ProgressViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AccountPrivacyViewArguments {
  const AccountPrivacyViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant AccountPrivacyViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SupportViewArguments {
  const SupportViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SupportViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TelegramSupportViewArguments {
  const TelegramSupportViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TelegramSupportViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class CallSupportViewArguments {
  const CallSupportViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant CallSupportViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class LanguageViewArguments {
  const LanguageViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LanguageViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class PrivacyPolicyViewArguments {
  const PrivacyPolicyViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant PrivacyPolicyViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TermsAndConditionsViewArguments {
  const TermsAndConditionsViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TermsAndConditionsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class RegisterViewArguments {
  const RegisterViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant RegisterViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LoginViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class LearnModuleViewArguments {
  const LearnModuleViewArguments({
    this.key,
    required this.course,
  });

  final _i39.Key? key;

  final _i40.LearnCourse course;

  @override
  String toString() {
    return '{"key": "$key", "course": "$course"}';
  }

  @override
  bool operator ==(covariant LearnModuleViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.course == course;
  }

  @override
  int get hashCode {
    return key.hashCode ^ course.hashCode;
  }
}

class WelcomeViewArguments {
  const WelcomeViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant WelcomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class LearnLessonViewArguments {
  const LearnLessonViewArguments({
    this.key,
    required this.module,
  });

  final _i39.Key? key;

  final _i41.LearnModule module;

  @override
  String toString() {
    return '{"key": "$key", "module": "$module"}';
  }

  @override
  bool operator ==(covariant LearnLessonViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.module == module;
  }

  @override
  int get hashCode {
    return key.hashCode ^ module.hashCode;
  }
}

class ForgetPasswordViewArguments {
  const ForgetPasswordViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ForgetPasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class LearnLessonDetailViewArguments {
  const LearnLessonDetailViewArguments({
    this.key,
    required this.lesson,
    required this.module,
    required this.hasPractice,
  });

  final _i39.Key? key;

  final _i42.LearnLesson lesson;

  final _i41.LearnModule module;

  final bool hasPractice;

  @override
  String toString() {
    return '{"key": "$key", "lesson": "$lesson", "module": "$module", "hasPractice": "$hasPractice"}';
  }

  @override
  bool operator ==(covariant LearnLessonDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.lesson == lesson &&
        other.module == module &&
        other.hasPractice == hasPractice;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        lesson.hashCode ^
        module.hashCode ^
        hasPractice.hashCode;
  }
}

class LearnPracticeViewArguments {
  const LearnPracticeViewArguments({
    this.key,
    this.level,
    required this.id,
    required this.label,
    required this.title,
    required this.practice,
    required this.subtitle,
  });

  final _i39.Key? key;

  final String? level;

  final int id;

  final String label;

  final String title;

  final _i43.LearnPractices practice;

  final String subtitle;

  @override
  String toString() {
    return '{"key": "$key", "level": "$level", "id": "$id", "label": "$label", "title": "$title", "practice": "$practice", "subtitle": "$subtitle"}';
  }

  @override
  bool operator ==(covariant LearnPracticeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.level == level &&
        other.id == id &&
        other.label == label &&
        other.title == title &&
        other.practice == practice &&
        other.subtitle == subtitle;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        level.hashCode ^
        id.hashCode ^
        label.hashCode ^
        title.hashCode ^
        practice.hashCode ^
        subtitle.hashCode;
  }
}

class CoursePracticeViewArguments {
  const CoursePracticeViewArguments({
    this.key,
    required this.id,
  });

  final _i39.Key? key;

  final int id;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id"}';
  }

  @override
  bool operator ==(covariant CoursePracticeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode;
  }
}

class CoursePaymentViewArguments {
  const CoursePaymentViewArguments({
    this.key,
    required this.course,
  });

  final _i39.Key? key;

  final _i44.Course course;

  @override
  String toString() {
    return '{"key": "$key", "course": "$course"}';
  }

  @override
  bool operator ==(covariant CoursePaymentViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.course == course;
  }

  @override
  int get hashCode {
    return key.hashCode ^ course.hashCode;
  }
}

class FailureViewArguments {
  const FailureViewArguments({
    this.key,
    required this.onTap,
    required this.label,
  });

  final _i39.Key? key;

  final void Function() onTap;

  final String label;

  @override
  String toString() {
    return '{"key": "$key", "onTap": "$onTap", "label": "$label"}';
  }

  @override
  bool operator ==(covariant FailureViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.onTap == onTap && other.label == label;
  }

  @override
  int get hashCode {
    return key.hashCode ^ onTap.hashCode ^ label.hashCode;
  }
}

class CourseLessonViewArguments {
  const CourseLessonViewArguments({
    this.key,
    required this.course,
  });

  final _i39.Key? key;

  final _i44.Course course;

  @override
  String toString() {
    return '{"key": "$key", "course": "$course"}';
  }

  @override
  bool operator ==(covariant CourseLessonViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.course == course;
  }

  @override
  int get hashCode {
    return key.hashCode ^ course.hashCode;
  }
}

class CourseLessonDetailViewArguments {
  const CourseLessonDetailViewArguments({
    this.key,
    required this.lesson,
  });

  final _i39.Key? key;

  final _i45.CourseLesson lesson;

  @override
  String toString() {
    return '{"key": "$key", "lesson": "$lesson"}';
  }

  @override
  bool operator ==(covariant CourseLessonDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.lesson == lesson;
  }

  @override
  int get hashCode {
    return key.hashCode ^ lesson.hashCode;
  }
}

class DuolingoViewArguments {
  const DuolingoViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant DuolingoViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class CourseViewArguments {
  const CourseViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant CourseViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class CoursePracticeQuestionViewArguments {
  const CoursePracticeQuestionViewArguments({
    this.key,
    required this.id,
  });

  final _i39.Key? key;

  final int id;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id"}';
  }

  @override
  bool operator ==(covariant CoursePracticeQuestionViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode;
  }
}

class LearnProgramViewArguments {
  const LearnProgramViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LearnProgramViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class LearnCourseViewArguments {
  const LearnCourseViewArguments({
    this.key,
    required this.id,
  });

  final _i39.Key? key;

  final int id;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id"}';
  }

  @override
  bool operator ==(covariant LearnCourseViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode;
  }
}

class AssessmentViewArguments {
  const AssessmentViewArguments({
    this.key,
    required this.data,
  });

  final _i39.Key? key;

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

class LearnSubscriptionViewArguments {
  const LearnSubscriptionViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LearnSubscriptionViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ArifPayViewArguments {
  const ArifPayViewArguments({
    this.key,
    required this.phone,
  });

  final _i39.Key? key;

  final String phone;

  @override
  String toString() {
    return '{"key": "$key", "phone": "$phone"}';
  }

  @override
  bool operator ==(covariant ArifPayViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.phone == phone;
  }

  @override
  int get hashCode {
    return key.hashCode ^ phone.hashCode;
  }
}

class CourseCatalogViewArguments {
  const CourseCatalogViewArguments({this.key});

  final _i39.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant CourseCatalogViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class CourseUnitViewArguments {
  const CourseUnitViewArguments({
    this.key,
    required this.catalog,
  });

  final _i39.Key? key;

  final _i46.CourseCatalog catalog;

  @override
  String toString() {
    return '{"key": "$key", "catalog": "$catalog"}';
  }

  @override
  bool operator ==(covariant CourseUnitViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.catalog == catalog;
  }

  @override
  int get hashCode {
    return key.hashCode ^ catalog.hashCode;
  }
}

extension NavigatorStateExtension on _i47.NavigationService {
  Future<dynamic> navigateToHomeView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnboardingView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.onboardingView,
        arguments: OnboardingViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView({
    _i39.Key? key,
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

  Future<dynamic> navigateToProfileView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.profileView,
        arguments: ProfileViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileDetailView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.profileDetailView,
        arguments: ProfileDetailViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDownloadsView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.downloadsView,
        arguments: DownloadsViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProgressView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.progressView,
        arguments: ProgressViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAccountPrivacyView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.accountPrivacyView,
        arguments: AccountPrivacyViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSupportView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.supportView,
        arguments: SupportViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTelegramSupportView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.telegramSupportView,
        arguments: TelegramSupportViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCallSupportView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.callSupportView,
        arguments: CallSupportViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLanguageView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.languageView,
        arguments: LanguageViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPrivacyPolicyView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.privacyPolicyView,
        arguments: PrivacyPolicyViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTermsAndConditionsView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.termsAndConditionsView,
        arguments: TermsAndConditionsViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.registerView,
        arguments: RegisterViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnModuleView({
    _i39.Key? key,
    required _i40.LearnCourse course,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnModuleView,
        arguments: LearnModuleViewArguments(key: key, course: course),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWelcomeView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.welcomeView,
        arguments: WelcomeViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnLessonView({
    _i39.Key? key,
    required _i41.LearnModule module,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnLessonView,
        arguments: LearnLessonViewArguments(key: key, module: module),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgetPasswordView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.forgetPasswordView,
        arguments: ForgetPasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnLessonDetailView({
    _i39.Key? key,
    required _i42.LearnLesson lesson,
    required _i41.LearnModule module,
    required bool hasPractice,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnLessonDetailView,
        arguments: LearnLessonDetailViewArguments(
            key: key, lesson: lesson, module: module, hasPractice: hasPractice),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnPracticeView({
    _i39.Key? key,
    String? level,
    required int id,
    required String label,
    required String title,
    required _i43.LearnPractices practice,
    required String subtitle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnPracticeView,
        arguments: LearnPracticeViewArguments(
            key: key,
            level: level,
            id: id,
            label: label,
            title: title,
            practice: practice,
            subtitle: subtitle),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCoursePracticeView({
    _i39.Key? key,
    required int id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.coursePracticeView,
        arguments: CoursePracticeViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCoursePaymentView({
    _i39.Key? key,
    required _i44.Course course,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.coursePaymentView,
        arguments: CoursePaymentViewArguments(key: key, course: course),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFailureView({
    _i39.Key? key,
    required void Function() onTap,
    required String label,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.failureView,
        arguments: FailureViewArguments(key: key, onTap: onTap, label: label),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCourseLessonView({
    _i39.Key? key,
    required _i44.Course course,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.courseLessonView,
        arguments: CourseLessonViewArguments(key: key, course: course),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCourseLessonDetailView({
    _i39.Key? key,
    required _i45.CourseLesson lesson,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.courseLessonDetailView,
        arguments: CourseLessonDetailViewArguments(key: key, lesson: lesson),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDuolingoView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.duolingoView,
        arguments: DuolingoViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCourseView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.courseView,
        arguments: CourseViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCoursePracticeQuestionView({
    _i39.Key? key,
    required int id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.coursePracticeQuestionView,
        arguments: CoursePracticeQuestionViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnProgramView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnProgramView,
        arguments: LearnProgramViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnCourseView({
    _i39.Key? key,
    required int id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnCourseView,
        arguments: LearnCourseViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAssessmentView({
    _i39.Key? key,
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

  Future<dynamic> navigateToLearnSubscriptionView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnSubscriptionView,
        arguments: LearnSubscriptionViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToArifPayView({
    _i39.Key? key,
    required String phone,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.arifPayView,
        arguments: ArifPayViewArguments(key: key, phone: phone),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCourseCatalogView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.courseCatalogView,
        arguments: CourseCatalogViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCourseUnitView({
    _i39.Key? key,
    required _i46.CourseCatalog catalog,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.courseUnitView,
        arguments: CourseUnitViewArguments(key: key, catalog: catalog),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnboardingView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.onboardingView,
        arguments: OnboardingViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView({
    _i39.Key? key,
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

  Future<dynamic> replaceWithProfileView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.profileView,
        arguments: ProfileViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileDetailView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.profileDetailView,
        arguments: ProfileDetailViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDownloadsView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.downloadsView,
        arguments: DownloadsViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProgressView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.progressView,
        arguments: ProgressViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAccountPrivacyView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.accountPrivacyView,
        arguments: AccountPrivacyViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSupportView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.supportView,
        arguments: SupportViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTelegramSupportView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.telegramSupportView,
        arguments: TelegramSupportViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCallSupportView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.callSupportView,
        arguments: CallSupportViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLanguageView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.languageView,
        arguments: LanguageViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPrivacyPolicyView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.privacyPolicyView,
        arguments: PrivacyPolicyViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTermsAndConditionsView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.termsAndConditionsView,
        arguments: TermsAndConditionsViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.registerView,
        arguments: RegisterViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginView,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnModuleView({
    _i39.Key? key,
    required _i40.LearnCourse course,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnModuleView,
        arguments: LearnModuleViewArguments(key: key, course: course),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWelcomeView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.welcomeView,
        arguments: WelcomeViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnLessonView({
    _i39.Key? key,
    required _i41.LearnModule module,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnLessonView,
        arguments: LearnLessonViewArguments(key: key, module: module),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithForgetPasswordView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.forgetPasswordView,
        arguments: ForgetPasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnLessonDetailView({
    _i39.Key? key,
    required _i42.LearnLesson lesson,
    required _i41.LearnModule module,
    required bool hasPractice,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnLessonDetailView,
        arguments: LearnLessonDetailViewArguments(
            key: key, lesson: lesson, module: module, hasPractice: hasPractice),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnPracticeView({
    _i39.Key? key,
    String? level,
    required int id,
    required String label,
    required String title,
    required _i43.LearnPractices practice,
    required String subtitle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnPracticeView,
        arguments: LearnPracticeViewArguments(
            key: key,
            level: level,
            id: id,
            label: label,
            title: title,
            practice: practice,
            subtitle: subtitle),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCoursePracticeView({
    _i39.Key? key,
    required int id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.coursePracticeView,
        arguments: CoursePracticeViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCoursePaymentView({
    _i39.Key? key,
    required _i44.Course course,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.coursePaymentView,
        arguments: CoursePaymentViewArguments(key: key, course: course),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFailureView({
    _i39.Key? key,
    required void Function() onTap,
    required String label,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.failureView,
        arguments: FailureViewArguments(key: key, onTap: onTap, label: label),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCourseLessonView({
    _i39.Key? key,
    required _i44.Course course,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.courseLessonView,
        arguments: CourseLessonViewArguments(key: key, course: course),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCourseLessonDetailView({
    _i39.Key? key,
    required _i45.CourseLesson lesson,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.courseLessonDetailView,
        arguments: CourseLessonDetailViewArguments(key: key, lesson: lesson),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDuolingoView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.duolingoView,
        arguments: DuolingoViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCourseView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.courseView,
        arguments: CourseViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCoursePracticeQuestionView({
    _i39.Key? key,
    required int id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.coursePracticeQuestionView,
        arguments: CoursePracticeQuestionViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnProgramView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnProgramView,
        arguments: LearnProgramViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnCourseView({
    _i39.Key? key,
    required int id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnCourseView,
        arguments: LearnCourseViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAssessmentView({
    _i39.Key? key,
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

  Future<dynamic> replaceWithLearnSubscriptionView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnSubscriptionView,
        arguments: LearnSubscriptionViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithArifPayView({
    _i39.Key? key,
    required String phone,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.arifPayView,
        arguments: ArifPayViewArguments(key: key, phone: phone),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCourseCatalogView({
    _i39.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.courseCatalogView,
        arguments: CourseCatalogViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCourseUnitView({
    _i39.Key? key,
    required _i46.CourseCatalog catalog,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.courseUnitView,
        arguments: CourseUnitViewArguments(key: key, catalog: catalog),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
