// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as _i39;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i48;
import 'package:yimaru_app/models/category.dart' as _i45;
import 'package:yimaru_app/models/course.dart' as _i43;
import 'package:yimaru_app/models/course_lesson.dart' as _i44;
import 'package:yimaru_app/models/lesson.dart' as _i42;
import 'package:yimaru_app/models/level.dart' as _i40;
import 'package:yimaru_app/models/module.dart' as _i47;
import 'package:yimaru_app/models/subcategory.dart' as _i46;
import 'package:yimaru_app/models/submodule.dart' as _i41;
import 'package:yimaru_app/ui/views/account_privacy/account_privacy_view.dart'
    as _i9;
import 'package:yimaru_app/ui/views/assessment/assessment_view.dart' as _i22;
import 'package:yimaru_app/ui/views/call_support/call_support_view.dart'
    as _i12;
import 'package:yimaru_app/ui/views/course/course_view.dart' as _i35;
import 'package:yimaru_app/ui/views/course_category/course_category_view.dart'
    as _i29;
import 'package:yimaru_app/ui/views/course_lesson/course_lesson_view.dart'
    as _i31;
import 'package:yimaru_app/ui/views/course_lesson_detail/course_lesson_detail_view.dart'
    as _i32;
import 'package:yimaru_app/ui/views/course_payment/course_payment_view.dart'
    as _i28;
import 'package:yimaru_app/ui/views/course_practice/course_practice_view.dart'
    as _i27;
import 'package:yimaru_app/ui/views/course_practice_question/course_practice_question_view.dart'
    as _i36;
import 'package:yimaru_app/ui/views/course_subcategory/course_subcategory_view.dart'
    as _i34;
import 'package:yimaru_app/ui/views/downloads/downloads_view.dart' as _i7;
import 'package:yimaru_app/ui/views/duolingo/duolingo_view.dart' as _i33;
import 'package:yimaru_app/ui/views/failure/failure_view.dart' as _i30;
import 'package:yimaru_app/ui/views/forget_password/forget_password_view.dart'
    as _i24;
import 'package:yimaru_app/ui/views/home/home_view.dart' as _i2;
import 'package:yimaru_app/ui/views/language/language_view.dart' as _i13;
import 'package:yimaru_app/ui/views/learn/learn_view.dart' as _i18;
import 'package:yimaru_app/ui/views/learn_lesson/learn_lesson_view.dart'
    as _i23;
import 'package:yimaru_app/ui/views/learn_lesson_detail/learn_lesson_detail_view.dart'
    as _i25;
import 'package:yimaru_app/ui/views/learn_level/learn_level_view.dart' as _i19;
import 'package:yimaru_app/ui/views/learn_module/learn_module_view.dart'
    as _i20;
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_view.dart'
    as _i26;
import 'package:yimaru_app/ui/views/learn_subcategory/learn_subcategory_view.dart'
    as _i37;
import 'package:yimaru_app/ui/views/learn_submodule/learn_submodule_view.dart'
    as _i38;
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
import 'package:yimaru_app/ui/views/welcome/welcome_view.dart' as _i21;

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

  static const learnView = '/learn-view';

  static const learnLevelView = '/learn-level-view';

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

  static const learnSubcategoryView = '/learn-subcategory-view';

  static const learnSubmoduleView = '/learn-submodule-view';

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
    learnView,
    learnLevelView,
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
    learnSubcategoryView,
    learnSubmoduleView,
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
      Routes.learnView,
      page: _i18.LearnView,
    ),
    _i1.RouteDef(
      Routes.learnLevelView,
      page: _i19.LearnLevelView,
    ),
    _i1.RouteDef(
      Routes.learnModuleView,
      page: _i20.LearnModuleView,
    ),
    _i1.RouteDef(
      Routes.welcomeView,
      page: _i21.WelcomeView,
    ),
    _i1.RouteDef(
      Routes.assessmentView,
      page: _i22.AssessmentView,
    ),
    _i1.RouteDef(
      Routes.learnLessonView,
      page: _i23.LearnLessonView,
    ),
    _i1.RouteDef(
      Routes.forgetPasswordView,
      page: _i24.ForgetPasswordView,
    ),
    _i1.RouteDef(
      Routes.learnLessonDetailView,
      page: _i25.LearnLessonDetailView,
    ),
    _i1.RouteDef(
      Routes.learnPracticeView,
      page: _i26.LearnPracticeView,
    ),
    _i1.RouteDef(
      Routes.coursePracticeView,
      page: _i27.CoursePracticeView,
    ),
    _i1.RouteDef(
      Routes.coursePaymentView,
      page: _i28.CoursePaymentView,
    ),
    _i1.RouteDef(
      Routes.courseCategoryView,
      page: _i29.CourseCategoryView,
    ),
    _i1.RouteDef(
      Routes.failureView,
      page: _i30.FailureView,
    ),
    _i1.RouteDef(
      Routes.courseLessonView,
      page: _i31.CourseLessonView,
    ),
    _i1.RouteDef(
      Routes.courseLessonDetailView,
      page: _i32.CourseLessonDetailView,
    ),
    _i1.RouteDef(
      Routes.duolingoView,
      page: _i33.DuolingoView,
    ),
    _i1.RouteDef(
      Routes.courseSubcategoryView,
      page: _i34.CourseSubcategoryView,
    ),
    _i1.RouteDef(
      Routes.courseView,
      page: _i35.CourseView,
    ),
    _i1.RouteDef(
      Routes.coursePracticeQuestionView,
      page: _i36.CoursePracticeQuestionView,
    ),
    _i1.RouteDef(
      Routes.learnSubcategoryView,
      page: _i37.LearnSubcategoryView,
    ),
    _i1.RouteDef(
      Routes.learnSubmoduleView,
      page: _i38.LearnSubmoduleView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.OnboardingView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.OnboardingView(),
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
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.ProfileView(),
        settings: data,
      );
    },
    _i6.ProfileDetailView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.ProfileDetailView(),
        settings: data,
      );
    },
    _i7.DownloadsView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.DownloadsView(),
        settings: data,
      );
    },
    _i8.ProgressView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.ProgressView(),
        settings: data,
      );
    },
    _i9.AccountPrivacyView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.AccountPrivacyView(),
        settings: data,
      );
    },
    _i10.SupportView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.SupportView(),
        settings: data,
      );
    },
    _i11.TelegramSupportView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.TelegramSupportView(),
        settings: data,
      );
    },
    _i12.CallSupportView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.CallSupportView(),
        settings: data,
      );
    },
    _i13.LanguageView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.LanguageView(),
        settings: data,
      );
    },
    _i14.PrivacyPolicyView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.PrivacyPolicyView(),
        settings: data,
      );
    },
    _i15.TermsAndConditionsView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.TermsAndConditionsView(),
        settings: data,
      );
    },
    _i16.RegisterView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.RegisterView(),
        settings: data,
      );
    },
    _i17.LoginView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.LoginView(),
        settings: data,
      );
    },
    _i18.LearnView: (data) {
      final args = data.getArgs<LearnViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i18.LearnView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i19.LearnLevelView: (data) {
      final args = data.getArgs<LearnLevelViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.LearnLevelView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i20.LearnModuleView: (data) {
      final args = data.getArgs<LearnModuleViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i20.LearnModuleView(key: args.key, level: args.level),
        settings: data,
      );
    },
    _i21.WelcomeView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i21.WelcomeView(),
        settings: data,
      );
    },
    _i22.AssessmentView: (data) {
      final args = data.getArgs<AssessmentViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i22.AssessmentView(key: args.key, data: args.data),
        settings: data,
      );
    },
    _i23.LearnLessonView: (data) {
      final args = data.getArgs<LearnLessonViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i23.LearnLessonView(key: args.key, submodule: args.submodule),
        settings: data,
      );
    },
    _i24.ForgetPasswordView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i24.ForgetPasswordView(),
        settings: data,
      );
    },
    _i25.LearnLessonDetailView: (data) {
      final args = data.getArgs<LearnLessonDetailViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i25.LearnLessonDetailView(key: args.key, lesson: args.lesson),
        settings: data,
      );
    },
    _i26.LearnPracticeView: (data) {
      final args = data.getArgs<LearnPracticeViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i26.LearnPracticeView(
            key: args.key,
            title: args.title,
            subtitle: args.subtitle,
            practices: args.practices,
            buttonLabel: args.buttonLabel),
        settings: data,
      );
    },
    _i27.CoursePracticeView: (data) {
      final args = data.getArgs<CoursePracticeViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i27.CoursePracticeView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i28.CoursePaymentView: (data) {
      final args = data.getArgs<CoursePaymentViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i28.CoursePaymentView(key: args.key, course: args.course),
        settings: data,
      );
    },
    _i29.CourseCategoryView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i29.CourseCategoryView(),
        settings: data,
      );
    },
    _i30.FailureView: (data) {
      final args = data.getArgs<FailureViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i30.FailureView(key: args.key, label: args.label),
        settings: data,
      );
    },
    _i31.CourseLessonView: (data) {
      final args = data.getArgs<CourseLessonViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i31.CourseLessonView(key: args.key, course: args.course),
        settings: data,
      );
    },
    _i32.CourseLessonDetailView: (data) {
      final args = data.getArgs<CourseLessonDetailViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i32.CourseLessonDetailView(key: args.key, lesson: args.lesson),
        settings: data,
      );
    },
    _i33.DuolingoView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i33.DuolingoView(),
        settings: data,
      );
    },
    _i34.CourseSubcategoryView: (data) {
      final args = data.getArgs<CourseSubcategoryViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i34.CourseSubcategoryView(key: args.key, category: args.category),
        settings: data,
      );
    },
    _i35.CourseView: (data) {
      final args = data.getArgs<CourseViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i35.CourseView(key: args.key, subcategory: args.subcategory),
        settings: data,
      );
    },
    _i36.CoursePracticeQuestionView: (data) {
      final args =
          data.getArgs<CoursePracticeQuestionViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i36.CoursePracticeQuestionView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i37.LearnSubcategoryView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i37.LearnSubcategoryView(),
        settings: data,
      );
    },
    _i38.LearnSubmoduleView: (data) {
      final args = data.getArgs<LearnSubmoduleViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i38.LearnSubmoduleView(key: args.key, module: args.module),
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

class LearnViewArguments {
  const LearnViewArguments({
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
  bool operator ==(covariant LearnViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode;
  }
}

class LearnLevelViewArguments {
  const LearnLevelViewArguments({
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
  bool operator ==(covariant LearnLevelViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode;
  }
}

class LearnModuleViewArguments {
  const LearnModuleViewArguments({
    this.key,
    required this.level,
  });

  final _i39.Key? key;

  final _i40.Level level;

  @override
  String toString() {
    return '{"key": "$key", "level": "$level"}';
  }

  @override
  bool operator ==(covariant LearnModuleViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.level == level;
  }

  @override
  int get hashCode {
    return key.hashCode ^ level.hashCode;
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

class LearnLessonViewArguments {
  const LearnLessonViewArguments({
    this.key,
    required this.submodule,
  });

  final _i39.Key? key;

  final _i41.Submodule submodule;

  @override
  String toString() {
    return '{"key": "$key", "submodule": "$submodule"}';
  }

  @override
  bool operator ==(covariant LearnLessonViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.submodule == submodule;
  }

  @override
  int get hashCode {
    return key.hashCode ^ submodule.hashCode;
  }
}

class LearnLessonDetailViewArguments {
  const LearnLessonDetailViewArguments({
    this.key,
    required this.lesson,
  });

  final _i39.Key? key;

  final _i42.Lesson lesson;

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
    required this.title,
    required this.subtitle,
    required this.practices,
    required this.buttonLabel,
  });

  final _i39.Key? key;

  final String title;

  final String subtitle;

  final List<Map<String, dynamic>> practices;

  final String buttonLabel;

  @override
  String toString() {
    return '{"key": "$key", "title": "$title", "subtitle": "$subtitle", "practices": "$practices", "buttonLabel": "$buttonLabel"}';
  }

  @override
  bool operator ==(covariant LearnPracticeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.practices == practices &&
        other.buttonLabel == buttonLabel;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        practices.hashCode ^
        buttonLabel.hashCode;
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

  final _i43.Course course;

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
    required this.label,
  });

  final _i39.Key? key;

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

  final _i39.Key? key;

  final _i43.Course course;

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

  final _i44.CourseLesson lesson;

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

class CourseSubcategoryViewArguments {
  const CourseSubcategoryViewArguments({
    this.key,
    required this.category,
  });

  final _i39.Key? key;

  final _i45.Category category;

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

  final _i39.Key? key;

  final _i46.Subcategory subcategory;

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

class LearnSubmoduleViewArguments {
  const LearnSubmoduleViewArguments({
    this.key,
    required this.module,
  });

  final _i39.Key? key;

  final _i47.Module module;

  @override
  String toString() {
    return '{"key": "$key", "module": "$module"}';
  }

  @override
  bool operator ==(covariant LearnSubmoduleViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.module == module;
  }

  @override
  int get hashCode {
    return key.hashCode ^ module.hashCode;
  }
}

extension NavigatorStateExtension on _i48.NavigationService {
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

  Future<dynamic> navigateToLearnView({
    _i39.Key? key,
    required int id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnView,
        arguments: LearnViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnLevelView({
    _i39.Key? key,
    required int id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnLevelView,
        arguments: LearnLevelViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnModuleView({
    _i39.Key? key,
    required _i40.Level level,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnModuleView,
        arguments: LearnModuleViewArguments(key: key, level: level),
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

  Future<dynamic> navigateToLearnLessonView({
    _i39.Key? key,
    required _i41.Submodule submodule,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnLessonView,
        arguments: LearnLessonViewArguments(key: key, submodule: submodule),
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

  Future<dynamic> navigateToLearnLessonDetailView({
    _i39.Key? key,
    required _i42.Lesson lesson,
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
    _i39.Key? key,
    required String title,
    required String subtitle,
    required List<Map<String, dynamic>> practices,
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
            practices: practices,
            buttonLabel: buttonLabel),
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
    required _i43.Course course,
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

  Future<dynamic> navigateToCourseCategoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.courseCategoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFailureView({
    _i39.Key? key,
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
    _i39.Key? key,
    required _i43.Course course,
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
    required _i44.CourseLesson lesson,
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

  Future<dynamic> navigateToDuolingoView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.duolingoView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCourseSubcategoryView({
    _i39.Key? key,
    required _i45.Category category,
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
    _i39.Key? key,
    required _i46.Subcategory subcategory,
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

  Future<dynamic> navigateToLearnSubcategoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.learnSubcategoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLearnSubmoduleView({
    _i39.Key? key,
    required _i47.Module module,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.learnSubmoduleView,
        arguments: LearnSubmoduleViewArguments(key: key, module: module),
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

  Future<dynamic> replaceWithLearnView({
    _i39.Key? key,
    required int id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnView,
        arguments: LearnViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnLevelView({
    _i39.Key? key,
    required int id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnLevelView,
        arguments: LearnLevelViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnModuleView({
    _i39.Key? key,
    required _i40.Level level,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnModuleView,
        arguments: LearnModuleViewArguments(key: key, level: level),
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

  Future<dynamic> replaceWithLearnLessonView({
    _i39.Key? key,
    required _i41.Submodule submodule,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnLessonView,
        arguments: LearnLessonViewArguments(key: key, submodule: submodule),
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

  Future<dynamic> replaceWithLearnLessonDetailView({
    _i39.Key? key,
    required _i42.Lesson lesson,
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
    _i39.Key? key,
    required String title,
    required String subtitle,
    required List<Map<String, dynamic>> practices,
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
            practices: practices,
            buttonLabel: buttonLabel),
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
    required _i43.Course course,
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

  Future<dynamic> replaceWithCourseCategoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.courseCategoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFailureView({
    _i39.Key? key,
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
    _i39.Key? key,
    required _i43.Course course,
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
    required _i44.CourseLesson lesson,
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

  Future<dynamic> replaceWithDuolingoView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.duolingoView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCourseSubcategoryView({
    _i39.Key? key,
    required _i45.Category category,
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
    _i39.Key? key,
    required _i46.Subcategory subcategory,
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

  Future<dynamic> replaceWithLearnSubcategoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.learnSubcategoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLearnSubmoduleView({
    _i39.Key? key,
    required _i47.Module module,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.learnSubmoduleView,
        arguments: LearnSubmoduleViewArguments(key: key, module: module),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
