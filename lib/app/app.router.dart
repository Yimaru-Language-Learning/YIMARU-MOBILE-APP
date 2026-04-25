// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i37;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i46;
import 'package:yimaru_app/models/category.dart' as _i44;
import 'package:yimaru_app/models/course.dart' as _i42;
import 'package:yimaru_app/models/course_lesson.dart' as _i43;
import 'package:yimaru_app/models/learn_course.dart' as _i38;
import 'package:yimaru_app/models/learn_lesson.dart' as _i40;
import 'package:yimaru_app/models/learn_module.dart' as _i39;
import 'package:yimaru_app/models/subcategory.dart' as _i45;
import 'package:yimaru_app/ui/common/enmus.dart' as _i41;
import 'package:yimaru_app/ui/views/account_privacy/account_privacy_view.dart'
    as _i9;
import 'package:yimaru_app/ui/views/assessment/assessment_view.dart' as _i20;
import 'package:yimaru_app/ui/views/call_support/call_support_view.dart'
    as _i12;
import 'package:yimaru_app/ui/views/course/course_view.dart' as _i33;
import 'package:yimaru_app/ui/views/course_category/course_category_view.dart'
    as _i27;
import 'package:yimaru_app/ui/views/course_lesson/course_lesson_view.dart'
    as _i29;
import 'package:yimaru_app/ui/views/course_lesson_detail/course_lesson_detail_view.dart'
    as _i30;
import 'package:yimaru_app/ui/views/course_payment/course_payment_view.dart'
    as _i26;
import 'package:yimaru_app/ui/views/course_practice/course_practice_view.dart'
    as _i25;
import 'package:yimaru_app/ui/views/course_practice_question/course_practice_question_view.dart'
    as _i34;
import 'package:yimaru_app/ui/views/course_subcategory/course_subcategory_view.dart'
    as _i32;
import 'package:yimaru_app/ui/views/downloads/downloads_view.dart' as _i7;
import 'package:yimaru_app/ui/views/duolingo/duolingo_view.dart' as _i31;
import 'package:yimaru_app/ui/views/failure/failure_view.dart' as _i28;
import 'package:yimaru_app/ui/views/forget_password/forget_password_view.dart'
    as _i22;
import 'package:yimaru_app/ui/views/home/home_view.dart' as _i2;
import 'package:yimaru_app/ui/views/language/language_view.dart' as _i13;
import 'package:yimaru_app/ui/views/learn_course/learn_course_view.dart'
    as _i36;
import 'package:yimaru_app/ui/views/learn_lesson/learn_lesson_view.dart'
    as _i21;
import 'package:yimaru_app/ui/views/learn_lesson_detail/learn_lesson_detail_view.dart'
    as _i23;
import 'package:yimaru_app/ui/views/learn_module/learn_module_view.dart'
    as _i18;
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_view.dart'
    as _i24;
import 'package:yimaru_app/ui/views/learn_program/learn_program_view.dart'
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

  static const assessmentView = '/assessment-view';

  static const learnLessonView = '/learn-lesson-view';

  static const forgetPasswordView = '/forget-password-view';

  static const learnLessonDetailView = '/learn-lesson-detail-view';

  static const learnPracticeView = '/learn-practice-view';

  static const coursePracticeView = '/course-practice-view';

  static const coursePaymentView = '/course-payment-view';

  static const courseCategoryView = '/course-category-view';

  static const failureView = '/failure-view';

  static const courseLessonView = '/course-lesson-view';

  static const courseLessonDetailView = '/course-lesson-detail-view';

  static const duolingoView = '/duolingo-view';

  static const courseSubcategoryView = '/course-subcategory-view';

  static const courseView = '/course-view';

  static const coursePracticeQuestionView = '/course-practice-question-view';

  static const learnProgramView = '/learn-program-view';

  static const learnCourseView = '/learn-course-view';

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
    assessmentView,
    learnLessonView,
    forgetPasswordView,
    learnLessonDetailView,
    learnPracticeView,
    coursePracticeView,
    coursePaymentView,
    courseCategoryView,
    failureView,
    courseLessonView,
    courseLessonDetailView,
    duolingoView,
    courseSubcategoryView,
    courseView,
    coursePracticeQuestionView,
    learnProgramView,
    learnCourseView,
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
      Routes.assessmentView,
      page: _i20.AssessmentView,
    ),
    _i1.RouteDef(
      Routes.learnLessonView,
      page: _i21.LearnLessonView,
    ),
    _i1.RouteDef(
      Routes.forgetPasswordView,
      page: _i22.ForgetPasswordView,
    ),
    _i1.RouteDef(
      Routes.learnLessonDetailView,
      page: _i23.LearnLessonDetailView,
    ),
    _i1.RouteDef(
      Routes.learnPracticeView,
      page: _i24.LearnPracticeView,
    ),
    _i1.RouteDef(
      Routes.coursePracticeView,
      page: _i25.CoursePracticeView,
    ),
    _i1.RouteDef(
      Routes.coursePaymentView,
      page: _i26.CoursePaymentView,
    ),
    _i1.RouteDef(
      Routes.courseCategoryView,
      page: _i27.CourseCategoryView,
    ),
    _i1.RouteDef(
      Routes.failureView,
      page: _i28.FailureView,
    ),
    _i1.RouteDef(
      Routes.courseLessonView,
      page: _i29.CourseLessonView,
    ),
    _i1.RouteDef(
      Routes.courseLessonDetailView,
      page: _i30.CourseLessonDetailView,
    ),
    _i1.RouteDef(
      Routes.duolingoView,
      page: _i31.DuolingoView,
    ),
    _i1.RouteDef(
      Routes.courseSubcategoryView,
      page: _i32.CourseSubcategoryView,
    ),
    _i1.RouteDef(
      Routes.courseView,
      page: _i33.CourseView,
    ),
    _i1.RouteDef(
      Routes.coursePracticeQuestionView,
      page: _i34.CoursePracticeQuestionView,
    ),
    _i1.RouteDef(
      Routes.learnProgramView,
      page: _i35.LearnProgramView,
    ),
    _i1.RouteDef(
      Routes.learnCourseView,
      page: _i36.LearnCourseView,
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
    _i19.WelcomeView: (data) {
      final args = data.getArgs<WelcomeViewArguments>(
        orElse: () => const WelcomeViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.WelcomeView(key: args.key),
        settings: data,
      );
    },
    _i20.AssessmentView: (data) {
      final args = data.getArgs<AssessmentViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i20.AssessmentView(key: args.key, data: args.data),
        settings: data,
      );
    },
    _i21.LearnLessonView: (data) {
      final args = data.getArgs<LearnLessonViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i21.LearnLessonView(key: args.key, module: args.module),
        settings: data,
      );
    },
    _i22.ForgetPasswordView: (data) {
      final args = data.getArgs<ForgetPasswordViewArguments>(
        orElse: () => const ForgetPasswordViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i22.ForgetPasswordView(key: args.key),
        settings: data,
      );
    },
    _i23.LearnLessonDetailView: (data) {
      final args = data.getArgs<LearnLessonDetailViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i23.LearnLessonDetailView(key: args.key, lesson: args.lesson),
        settings: data,
      );
    },
    _i24.LearnPracticeView: (data) {
      final args = data.getArgs<LearnPracticeViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i24.LearnPracticeView(
            key: args.key, id: args.id, practice: args.practice),
        settings: data,
      );
    },
    _i25.CoursePracticeView: (data) {
      final args = data.getArgs<CoursePracticeViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i25.CoursePracticeView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i26.CoursePaymentView: (data) {
      final args = data.getArgs<CoursePaymentViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i26.CoursePaymentView(key: args.key, course: args.course),
        settings: data,
      );
    },
    _i27.CourseCategoryView: (data) {
      final args = data.getArgs<CourseCategoryViewArguments>(
        orElse: () => const CourseCategoryViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i27.CourseCategoryView(key: args.key),
        settings: data,
      );
    },
    _i28.FailureView: (data) {
      final args = data.getArgs<FailureViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i28.FailureView(key: args.key, label: args.label),
        settings: data,
      );
    },
    _i29.CourseLessonView: (data) {
      final args = data.getArgs<CourseLessonViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i29.CourseLessonView(key: args.key, course: args.course),
        settings: data,
      );
    },
    _i30.CourseLessonDetailView: (data) {
      final args = data.getArgs<CourseLessonDetailViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i30.CourseLessonDetailView(key: args.key, lesson: args.lesson),
        settings: data,
      );
    },
    _i31.DuolingoView: (data) {
      final args = data.getArgs<DuolingoViewArguments>(
        orElse: () => const DuolingoViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i31.DuolingoView(key: args.key),
        settings: data,
      );
    },
    _i32.CourseSubcategoryView: (data) {
      final args = data.getArgs<CourseSubcategoryViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i32.CourseSubcategoryView(key: args.key, category: args.category),
        settings: data,
      );
    },
    _i33.CourseView: (data) {
      final args = data.getArgs<CourseViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i33.CourseView(key: args.key, subcategory: args.subcategory),
        settings: data,
      );
    },
    _i34.CoursePracticeQuestionView: (data) {
      final args =
          data.getArgs<CoursePracticeQuestionViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i34.CoursePracticeQuestionView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i35.LearnProgramView: (data) {
      final args = data.getArgs<LearnProgramViewArguments>(
        orElse: () => const LearnProgramViewArguments(),
      );
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i35.LearnProgramView(key: args.key),
        settings: data,
      );
    },
    _i36.LearnCourseView: (data) {
      final args = data.getArgs<LearnCourseViewArguments>(nullOk: false);
      return _i37.MaterialPageRoute<dynamic>(
        builder: (context) => _i36.LearnCourseView(key: args.key, id: args.id),
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
    this.label = 'Loading',
  });

  final _i37.Key? key;

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

class WelcomeViewArguments {
  const WelcomeViewArguments({this.key});

  final _i37.Key? key;

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
    required this.lesson,
  });

  final _i37.Key? key;

  final _i40.LearnLesson lesson;

  @override
  String toString() {
    return '{"key": "$key", "lesson": "$lesson"}';
  }

  @override
  bool operator ==(covariant LearnLessonDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.lesson == lesson;
  }

  @override
  int get hashCode {
    return key.hashCode ^ lesson.hashCode;
  }
}

class LearnPracticeViewArguments {
  const LearnPracticeViewArguments({
    this.key,
    required this.id,
    required this.practice,
  });

  final _i37.Key? key;

  final int id;

  final _i41.LearnPractices practice;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id", "practice": "$practice"}';
  }

  @override
  bool operator ==(covariant LearnPracticeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id && other.practice == practice;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode ^ practice.hashCode;
  }
}

class CoursePracticeViewArguments {
  const CoursePracticeViewArguments({
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

class CourseCategoryViewArguments {
  const CourseCategoryViewArguments({this.key});

  final _i37.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant CourseCategoryViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class FailureViewArguments {
  const FailureViewArguments({
    this.key,
    required this.label,
  });

  final _i37.Key? key;

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

class CourseLessonViewArguments {
  const CourseLessonViewArguments({
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

class CourseSubcategoryViewArguments {
  const CourseSubcategoryViewArguments({
    this.key,
    required this.category,
  });

  final _i37.Key? key;

  final _i44.Category category;

  @override
  String toString() {
    return '{"key": "$key", "category": "$category"}';
  }

  @override
  bool operator ==(covariant CourseSubcategoryViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.category == category;
  }

  @override
  int get hashCode {
    return key.hashCode ^ category.hashCode;
  }
}

class CourseViewArguments {
  const CourseViewArguments({
    this.key,
    required this.subcategory,
  });

  final _i37.Key? key;

  final _i45.Subcategory subcategory;

  @override
  String toString() {
    return '{"key": "$key", "subcategory": "$subcategory"}';
  }

  @override
  bool operator ==(covariant CourseViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.subcategory == subcategory;
  }

  @override
  int get hashCode {
    return key.hashCode ^ subcategory.hashCode;
  }
}

class CoursePracticeQuestionViewArguments {
  const CoursePracticeQuestionViewArguments({
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

extension NavigatorStateExtension on _i46.NavigationService {
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

  Future<dynamic> navigateToWelcomeView({
    _i37.Key? key,
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
    required _i40.LearnLesson lesson,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnLessonDetailView,
        arguments: LearnLessonDetailViewArguments(key: key, lesson: lesson),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnPracticeView({
    _i37.Key? key,
    required int id,
    required _i41.LearnPractices practice,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnPracticeView,
        arguments:
            LearnPracticeViewArguments(key: key, id: id, practice: practice),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCoursePracticeView({
    _i37.Key? key,
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

  Future<dynamic> navigateToCourseCategoryView({
    _i37.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.courseCategoryView,
        arguments: CourseCategoryViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFailureView({
    _i37.Key? key,
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

  Future<dynamic> navigateToCourseLessonView({
    _i37.Key? key,
    required _i42.Course course,
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

  Future<dynamic> navigateToCourseSubcategoryView({
    _i37.Key? key,
    required _i44.Category category,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.courseSubcategoryView,
        arguments: CourseSubcategoryViewArguments(key: key, category: category),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCourseView({
    _i37.Key? key,
    required _i45.Subcategory subcategory,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.courseView,
        arguments: CourseViewArguments(key: key, subcategory: subcategory),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCoursePracticeQuestionView({
    _i37.Key? key,
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

  Future<dynamic> replaceWithWelcomeView({
    _i37.Key? key,
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
    required _i40.LearnLesson lesson,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnLessonDetailView,
        arguments: LearnLessonDetailViewArguments(key: key, lesson: lesson),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnPracticeView({
    _i37.Key? key,
    required int id,
    required _i41.LearnPractices practice,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnPracticeView,
        arguments:
            LearnPracticeViewArguments(key: key, id: id, practice: practice),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCoursePracticeView({
    _i37.Key? key,
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

  Future<dynamic> replaceWithCourseCategoryView({
    _i37.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.courseCategoryView,
        arguments: CourseCategoryViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFailureView({
    _i37.Key? key,
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

  Future<dynamic> replaceWithCourseLessonView({
    _i37.Key? key,
    required _i42.Course course,
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

  Future<dynamic> replaceWithCourseSubcategoryView({
    _i37.Key? key,
    required _i44.Category category,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.courseSubcategoryView,
        arguments: CourseSubcategoryViewArguments(key: key, category: category),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCourseView({
    _i37.Key? key,
    required _i45.Subcategory subcategory,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.courseView,
        arguments: CourseViewArguments(key: key, subcategory: subcategory),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCoursePracticeQuestionView({
    _i37.Key? key,
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
}
