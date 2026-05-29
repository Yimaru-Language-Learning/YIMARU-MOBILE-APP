// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as _i37;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i47;
import 'package:yimaru_app/models/course.dart' as _i42;
import 'package:yimaru_app/models/course_catalog.dart' as _i44;
import 'package:yimaru_app/models/course_lesson.dart' as _i43;
import 'package:yimaru_app/models/course_module.dart' as _i45;
import 'package:yimaru_app/models/learn_course.dart' as _i38;
import 'package:yimaru_app/models/learn_lesson.dart' as _i40;
import 'package:yimaru_app/models/learn_module.dart' as _i39;
import 'package:yimaru_app/models/learn_subscription.dart' as _i46;
import 'package:yimaru_app/ui/common/enmus.dart' as _i41;
import 'package:yimaru_app/ui/views/account_privacy/account_privacy_view.dart'
    as _i9;
import 'package:yimaru_app/ui/views/assessment/assessment_view.dart' as _i29;
import 'package:yimaru_app/ui/views/call_support/call_support_view.dart'
    as _i12;
import 'package:yimaru_app/ui/views/course/course_view.dart' as _i27;
import 'package:yimaru_app/ui/views/course_catalog/course_catalog_view.dart'
    as _i31;
import 'package:yimaru_app/ui/views/course_lesson_detail/course_lesson_detail_view.dart'
    as _i25;
import 'package:yimaru_app/ui/views/course_module/course_module_view.dart'
    as _i34;
import 'package:yimaru_app/ui/views/course_payment/course_payment_view.dart'
    as _i23;
import 'package:yimaru_app/ui/views/course_unit/course_unit_view.dart' as _i32;
import 'package:yimaru_app/ui/views/downloads/downloads_view.dart' as _i7;
import 'package:yimaru_app/ui/views/duolingo/duolingo_view.dart' as _i26;
import 'package:yimaru_app/ui/views/failure/failure_view.dart' as _i24;
import 'package:yimaru_app/ui/views/forget_password/forget_password_view.dart'
    as _i20;
import 'package:yimaru_app/ui/views/home/home_view.dart' as _i2;
import 'package:yimaru_app/ui/views/landing/landing_view.dart' as _i33;
import 'package:yimaru_app/ui/views/language/language_view.dart' as _i13;
import 'package:yimaru_app/ui/views/learn_course/learn_course_view.dart'
    as _i35;
import 'package:yimaru_app/ui/views/learn_lesson/learn_lesson_view.dart'
    as _i19;
import 'package:yimaru_app/ui/views/learn_lesson_detail/learn_lesson_detail_view.dart'
    as _i21;
import 'package:yimaru_app/ui/views/learn_module/learn_module_view.dart'
    as _i18;
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_view.dart'
    as _i22;
import 'package:yimaru_app/ui/views/learn_program/learn_program_view.dart'
    as _i28;
import 'package:yimaru_app/ui/views/learn_subscription/learn_subscription_view.dart'
    as _i30;
import 'package:yimaru_app/ui/views/login/login_view.dart' as _i17;
import 'package:yimaru_app/ui/views/onboarding/onboarding_view.dart' as _i3;
import 'package:yimaru_app/ui/views/payment/payment_view.dart' as _i36;
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

  static const learnLessonView = '/learn-lesson-view';

  static const forgetPasswordView = '/forget-password-view';

  static const learnLessonDetailView = '/learn-lesson-detail-view';

  static const learnPracticeView = '/learn-practice-view';

  static const coursePaymentView = '/course-payment-view';

  static const failureView = '/failure-view';

  static const courseLessonDetailView = '/course-lesson-detail-view';

  static const duolingoView = '/duolingo-view';

  static const courseView = '/course-view';

  static const learnProgramView = '/learn-program-view';

  static const assessmentView = '/assessment-view';

  static const learnSubscriptionView = '/learn-subscription-view';

  static const courseCatalogView = '/course-catalog-view';

  static const courseUnitView = '/course-unit-view';

  static const landingView = '/landing-view';

  static const courseModuleView = '/course-module-view';

  static const learnCourseView = '/learn-course-view';

  static const paymentView = '/payment-view';

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
    learnLessonView,
    forgetPasswordView,
    learnLessonDetailView,
    learnPracticeView,
    coursePaymentView,
    failureView,
    courseLessonDetailView,
    duolingoView,
    courseView,
    learnProgramView,
    assessmentView,
    learnSubscriptionView,
    courseCatalogView,
    courseUnitView,
    landingView,
    courseModuleView,
    learnCourseView,
    paymentView,
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
      Routes.learnLessonView,
      page: _i19.LearnLessonView,
    ),
    _i1.RouteDef(
      Routes.forgetPasswordView,
      page: _i20.ForgetPasswordView,
    ),
    _i1.RouteDef(
      Routes.learnLessonDetailView,
      page: _i21.LearnLessonDetailView,
    ),
    _i1.RouteDef(
      Routes.learnPracticeView,
      page: _i22.LearnPracticeView,
    ),
    _i1.RouteDef(
      Routes.coursePaymentView,
      page: _i23.CoursePaymentView,
    ),
    _i1.RouteDef(
      Routes.failureView,
      page: _i24.FailureView,
    ),
    _i1.RouteDef(
      Routes.courseLessonDetailView,
      page: _i25.CourseLessonDetailView,
    ),
    _i1.RouteDef(
      Routes.duolingoView,
      page: _i26.DuolingoView,
    ),
    _i1.RouteDef(
      Routes.courseView,
      page: _i27.CourseView,
    ),
    _i1.RouteDef(
      Routes.learnProgramView,
      page: _i28.LearnProgramView,
    ),
    _i1.RouteDef(
      Routes.assessmentView,
      page: _i29.AssessmentView,
    ),
    _i1.RouteDef(
      Routes.learnSubscriptionView,
      page: _i30.LearnSubscriptionView,
    ),
    _i1.RouteDef(
      Routes.courseCatalogView,
      page: _i31.CourseCatalogView,
    ),
    _i1.RouteDef(
      Routes.courseUnitView,
      page: _i32.CourseUnitView,
    ),
    _i1.RouteDef(
      Routes.landingView,
      page: _i33.LandingView,
    ),
    _i1.RouteDef(
      Routes.courseModuleView,
      page: _i34.CourseModuleView,
    ),
    _i1.RouteDef(
      Routes.learnCourseView,
      page: _i35.LearnCourseView,
    ),
    _i1.RouteDef(
      Routes.paymentView,
      page: _i36.PaymentView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => const HomeViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.HomeView(key: args.key),
        settings: data,
      );
    },
    _i3.OnboardingView: (data) {
      final args = data.getArgs<OnboardingViewArguments>(
        orElse: () => const OnboardingViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.OnboardingView(key: args.key),
        settings: data,
      );
    },
    _i4.StartupView: (data) {
      final args = data.getArgs<StartupViewArguments>(
        orElse: () => const StartupViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.StartupView(key: args.key, label: args.label),
        settings: data,
      );
    },
    _i5.ProfileView: (data) {
      final args = data.getArgs<ProfileViewArguments>(
        orElse: () => const ProfileViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.ProfileView(key: args.key),
        settings: data,
      );
    },
    _i6.ProfileDetailView: (data) {
      final args = data.getArgs<ProfileDetailViewArguments>(
        orElse: () => const ProfileDetailViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.ProfileDetailView(key: args.key),
        settings: data,
      );
    },
    _i7.DownloadsView: (data) {
      final args = data.getArgs<DownloadsViewArguments>(
        orElse: () => const DownloadsViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.DownloadsView(key: args.key),
        settings: data,
      );
    },
    _i8.ProgressView: (data) {
      final args = data.getArgs<ProgressViewArguments>(
        orElse: () => const ProgressViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.ProgressView(key: args.key),
        settings: data,
      );
    },
    _i9.AccountPrivacyView: (data) {
      final args = data.getArgs<AccountPrivacyViewArguments>(
        orElse: () => const AccountPrivacyViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.AccountPrivacyView(key: args.key),
        settings: data,
      );
    },
    _i10.SupportView: (data) {
      final args = data.getArgs<SupportViewArguments>(
        orElse: () => const SupportViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.SupportView(key: args.key),
        settings: data,
      );
    },
    _i11.TelegramSupportView: (data) {
      final args = data.getArgs<TelegramSupportViewArguments>(
        orElse: () => const TelegramSupportViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.TelegramSupportView(key: args.key),
        settings: data,
      );
    },
    _i12.CallSupportView: (data) {
      final args = data.getArgs<CallSupportViewArguments>(
        orElse: () => const CallSupportViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.CallSupportView(key: args.key),
        settings: data,
      );
    },
    _i13.LanguageView: (data) {
      final args = data.getArgs<LanguageViewArguments>(
        orElse: () => const LanguageViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.LanguageView(key: args.key),
        settings: data,
      );
    },
    _i14.PrivacyPolicyView: (data) {
      final args = data.getArgs<PrivacyPolicyViewArguments>(
        orElse: () => const PrivacyPolicyViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.PrivacyPolicyView(key: args.key),
        settings: data,
      );
    },
    _i15.TermsAndConditionsView: (data) {
      final args = data.getArgs<TermsAndConditionsViewArguments>(
        orElse: () => const TermsAndConditionsViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.TermsAndConditionsView(key: args.key),
        settings: data,
      );
    },
    _i16.RegisterView: (data) {
      final args = data.getArgs<RegisterViewArguments>(
        orElse: () => const RegisterViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.RegisterView(key: args.key),
        settings: data,
      );
    },
    _i17.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i17.LoginView(key: args.key),
        settings: data,
      );
    },
    _i18.LearnModuleView: (data) {
      final args = data.getArgs<LearnModuleViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i18.LearnModuleView(key: args.key, course: args.course),
        settings: data,
      );
    },
    _i19.LearnLessonView: (data) {
      final args = data.getArgs<LearnLessonViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i19.LearnLessonView(key: args.key, module: args.module),
        settings: data,
      );
    },
    _i20.ForgetPasswordView: (data) {
      final args = data.getArgs<ForgetPasswordViewArguments>(
        orElse: () => const ForgetPasswordViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i20.ForgetPasswordView(key: args.key),
        settings: data,
      );
    },
    _i21.LearnLessonDetailView: (data) {
      final args = data.getArgs<LearnLessonDetailViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i21.LearnLessonDetailView(
            key: args.key,
            index: args.index,
            lesson: args.lesson,
            module: args.module,
            hasPractice: args.hasPractice),
        settings: data,
      );
    },
    _i22.LearnPracticeView: (data) {
      final args = data.getArgs<LearnPracticeViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i22.LearnPracticeView(
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
    _i23.CoursePaymentView: (data) {
      final args = data.getArgs<CoursePaymentViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i23.CoursePaymentView(key: args.key, course: args.course),
        settings: data,
      );
    },
    _i24.FailureView: (data) {
      final args = data.getArgs<FailureViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i24.FailureView(
            key: args.key, onTap: args.onTap, label: args.label),
        settings: data,
      );
    },
    _i25.CourseLessonDetailView: (data) {
      final args = data.getArgs<CourseLessonDetailViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i25.CourseLessonDetailView(key: args.key, lesson: args.lesson),
        settings: data,
      );
    },
    _i26.DuolingoView: (data) {
      final args = data.getArgs<DuolingoViewArguments>(
        orElse: () => const DuolingoViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i26.DuolingoView(key: args.key),
        settings: data,
      );
    },
    _i27.CourseView: (data) {
      final args = data.getArgs<CourseViewArguments>(
        orElse: () => const CourseViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i27.CourseView(key: args.key),
        settings: data,
      );
    },
    _i28.LearnProgramView: (data) {
      final args = data.getArgs<LearnProgramViewArguments>(
        orElse: () => const LearnProgramViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i28.LearnProgramView(key: args.key),
        settings: data,
      );
    },
    _i29.AssessmentView: (data) {
      final args = data.getArgs<AssessmentViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i29.AssessmentView(key: args.key, data: args.data),
        settings: data,
      );
    },
    _i30.LearnSubscriptionView: (data) {
      final args = data.getArgs<LearnSubscriptionViewArguments>(
        orElse: () => const LearnSubscriptionViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i30.LearnSubscriptionView(key: args.key),
        settings: data,
      );
    },
    _i31.CourseCatalogView: (data) {
      final args = data.getArgs<CourseCatalogViewArguments>(
        orElse: () => const CourseCatalogViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i31.CourseCatalogView(key: args.key),
        settings: data,
      );
    },
    _i32.CourseUnitView: (data) {
      final args = data.getArgs<CourseUnitViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i32.CourseUnitView(key: args.key, catalog: args.catalog),
        settings: data,
      );
    },
    _i33.LandingView: (data) {
      final args = data.getArgs<LandingViewArguments>(
        orElse: () => const LandingViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i33.LandingView(key: args.key),
        settings: data,
      );
    },
    _i34.CourseModuleView: (data) {
      final args = data.getArgs<CourseModuleViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i34.CourseModuleView(
            key: args.key, module: args.module, catalog: args.catalog),
        settings: data,
      );
    },
    _i35.LearnCourseView: (data) {
      final args = data.getArgs<LearnCourseViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i35.LearnCourseView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i36.PaymentView: (data) {
      final args = data.getArgs<PaymentViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i36.PaymentView(
            key: args.key, phone: args.phone, subscription: args.subscription),
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

  final _i37.Key? key;

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

  final _i37.Key? key;

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
    this.label,
  });

  final _i37.Key? key;

  final String? label;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

  final _i38.LearnCourse course;

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

class LearnLessonViewArguments {
  const LearnLessonViewArguments({
    this.key,
    required this.module,
  });

  final _i37.Key? key;

  final _i39.LearnModule module;

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

  final _i37.Key? key;

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
    required this.index,
    required this.lesson,
    required this.module,
    required this.hasPractice,
  });

  final _i37.Key? key;

  final int index;

  final _i40.LearnLesson lesson;

  final _i39.LearnModule module;

  final bool hasPractice;

  @override
  String toString() {
    return '{"key": "$key", "index": "$index", "lesson": "$lesson", "module": "$module", "hasPractice": "$hasPractice"}';
  }

  @override
  bool operator ==(covariant LearnLessonDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.index == index &&
        other.lesson == lesson &&
        other.module == module &&
        other.hasPractice == hasPractice;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        index.hashCode ^
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

  final _i37.Key? key;

  final String? level;

  final int id;

  final String label;

  final String title;

  final _i41.LearnPractices practice;

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

class CoursePaymentViewArguments {
  const CoursePaymentViewArguments({
    this.key,
    required this.course,
  });

  final _i37.Key? key;

  final _i42.Course course;

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

  final _i37.Key? key;

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

class CourseLessonDetailViewArguments {
  const CourseLessonDetailViewArguments({
    this.key,
    required this.lesson,
  });

  final _i37.Key? key;

  final _i43.CourseLesson lesson;

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

  final _i37.Key? key;

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

  final _i37.Key? key;

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

class LearnProgramViewArguments {
  const LearnProgramViewArguments({this.key});

  final _i37.Key? key;

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

class AssessmentViewArguments {
  const AssessmentViewArguments({
    this.key,
    required this.data,
  });

  final _i37.Key? key;

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

  final _i37.Key? key;

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

class CourseCatalogViewArguments {
  const CourseCatalogViewArguments({this.key});

  final _i37.Key? key;

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

  final _i37.Key? key;

  final _i44.CourseCatalog catalog;

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

class LandingViewArguments {
  const LandingViewArguments({this.key});

  final _i37.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LandingViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class CourseModuleViewArguments {
  const CourseModuleViewArguments({
    this.key,
    required this.module,
    required this.catalog,
  });

  final _i37.Key? key;

  final _i45.CourseModule? module;

  final _i44.CourseCatalog catalog;

  @override
  String toString() {
    return '{"key": "$key", "module": "$module", "catalog": "$catalog"}';
  }

  @override
  bool operator ==(covariant CourseModuleViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.module == module &&
        other.catalog == catalog;
  }

  @override
  int get hashCode {
    return key.hashCode ^ module.hashCode ^ catalog.hashCode;
  }
}

class LearnCourseViewArguments {
  const LearnCourseViewArguments({
    this.key,
    required this.id,
  });

  final _i37.Key? key;

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

class PaymentViewArguments {
  const PaymentViewArguments({
    this.key,
    required this.phone,
    required this.subscription,
  });

  final _i37.Key? key;

  final String phone;

  final _i46.LearnSubscription subscription;

  @override
  String toString() {
    return '{"key": "$key", "phone": "$phone", "subscription": "$subscription"}';
  }

  @override
  bool operator ==(covariant PaymentViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.phone == phone &&
        other.subscription == subscription;
  }

  @override
  int get hashCode {
    return key.hashCode ^ phone.hashCode ^ subscription.hashCode;
  }
}

extension NavigatorStateExtension on _i47.NavigationService {
  Future<dynamic> navigateToHomeView({
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
    String? label,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
    required _i38.LearnCourse course,
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

  Future<dynamic> navigateToLearnLessonView({
    _i37.Key? key,
    required _i39.LearnModule module,
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
    _i37.Key? key,
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
    _i37.Key? key,
    required int index,
    required _i40.LearnLesson lesson,
    required _i39.LearnModule module,
    required bool hasPractice,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnLessonDetailView,
        arguments: LearnLessonDetailViewArguments(
            key: key,
            index: index,
            lesson: lesson,
            module: module,
            hasPractice: hasPractice),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnPracticeView({
    _i37.Key? key,
    String? level,
    required int id,
    required String label,
    required String title,
    required _i41.LearnPractices practice,
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

  Future<dynamic> navigateToCoursePaymentView({
    _i37.Key? key,
    required _i42.Course course,
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
    _i37.Key? key,
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

  Future<dynamic> navigateToCourseLessonDetailView({
    _i37.Key? key,
    required _i43.CourseLesson lesson,
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
    _i37.Key? key,
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
    _i37.Key? key,
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

  Future<dynamic> navigateToLearnProgramView({
    _i37.Key? key,
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

  Future<dynamic> navigateToAssessmentView({
    _i37.Key? key,
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
    _i37.Key? key,
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

  Future<dynamic> navigateToCourseCatalogView({
    _i37.Key? key,
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
    _i37.Key? key,
    required _i44.CourseCatalog catalog,
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

  Future<dynamic> navigateToLandingView({
    _i37.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.landingView,
        arguments: LandingViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCourseModuleView({
    _i37.Key? key,
    required _i45.CourseModule? module,
    required _i44.CourseCatalog catalog,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.courseModuleView,
        arguments: CourseModuleViewArguments(
            key: key, module: module, catalog: catalog),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnCourseView({
    _i37.Key? key,
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

  Future<dynamic> navigateToPaymentView({
    _i37.Key? key,
    required String phone,
    required _i46.LearnSubscription subscription,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.paymentView,
        arguments: PaymentViewArguments(
            key: key, phone: phone, subscription: subscription),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView({
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
    String? label,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
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
    _i37.Key? key,
    required _i38.LearnCourse course,
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

  Future<dynamic> replaceWithLearnLessonView({
    _i37.Key? key,
    required _i39.LearnModule module,
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
    _i37.Key? key,
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
    _i37.Key? key,
    required int index,
    required _i40.LearnLesson lesson,
    required _i39.LearnModule module,
    required bool hasPractice,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnLessonDetailView,
        arguments: LearnLessonDetailViewArguments(
            key: key,
            index: index,
            lesson: lesson,
            module: module,
            hasPractice: hasPractice),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnPracticeView({
    _i37.Key? key,
    String? level,
    required int id,
    required String label,
    required String title,
    required _i41.LearnPractices practice,
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

  Future<dynamic> replaceWithCoursePaymentView({
    _i37.Key? key,
    required _i42.Course course,
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
    _i37.Key? key,
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

  Future<dynamic> replaceWithCourseLessonDetailView({
    _i37.Key? key,
    required _i43.CourseLesson lesson,
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
    _i37.Key? key,
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
    _i37.Key? key,
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

  Future<dynamic> replaceWithLearnProgramView({
    _i37.Key? key,
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

  Future<dynamic> replaceWithAssessmentView({
    _i37.Key? key,
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
    _i37.Key? key,
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

  Future<dynamic> replaceWithCourseCatalogView({
    _i37.Key? key,
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
    _i37.Key? key,
    required _i44.CourseCatalog catalog,
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

  Future<dynamic> replaceWithLandingView({
    _i37.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.landingView,
        arguments: LandingViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCourseModuleView({
    _i37.Key? key,
    required _i45.CourseModule? module,
    required _i44.CourseCatalog catalog,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.courseModuleView,
        arguments: CourseModuleViewArguments(
            key: key, module: module, catalog: catalog),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnCourseView({
    _i37.Key? key,
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

  Future<dynamic> replaceWithPaymentView({
    _i37.Key? key,
    required String phone,
    required _i46.LearnSubscription subscription,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.paymentView,
        arguments: PaymentViewArguments(
            key: key, phone: phone, subscription: subscription),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
