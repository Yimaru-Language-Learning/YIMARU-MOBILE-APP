import 'package:dio/dio.dart';
import 'package:yimaru_app/models/app_update.dart';
import 'package:yimaru_app/models/in_app_notification.dart';
import 'package:yimaru_app/models/learn_lesson.dart';
import 'package:yimaru_app/models/learn_practice.dart';
import 'package:yimaru_app/models/learn_program.dart';
import 'package:yimaru_app/models/assessment_question.dart';
import 'package:yimaru_app/models/course_catalog.dart';
import 'package:yimaru_app/models/course_lesson.dart';
import 'package:yimaru_app/models/refresh_object.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/dio_service.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';

import '../app/app.locator.dart';
import '../models/course_module.dart';
import '../models/course_unit.dart';
import '../models/field_option.dart';
import '../models/learn_course.dart';
import '../models/learn_module.dart';
import '../models/learn_question.dart';
import '../models/learn_subscription.dart';
import '../models/assessment.dart';
import '../models/learn_subscription_request.dart';
import '../models/progress_summary.dart';
import '../ui/common/enmus.dart';

class ApiService {
  // Dependency injection
  final _service = locator<DioService>();

  // Register with email
  Future<Map<String, dynamic>> registerWithEmail(
      Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kUserBaseUrl/$kRegisterUrl',
        data: data,
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Otp sent successfully'
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': 'Unknown Error Occurred'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Login
  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kLoginUrl',
        data: data,
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Logged in successfully',
          'data': User.fromJson(response.data['data']),
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': '${response.data['message']}, ${response.data['error']}'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Google auth
  Future<Map<String, dynamic>> googleAuth(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kGoogleAuthUrl',
        data: data,
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Logged in successfully',
          'data': User.fromJson(response.data['data']),
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': '${response.data['message']}, ${response.data['error']}'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Verify otp
  Future<Map<String, dynamic>> verifyOtp(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kUserBaseUrl/$kVerifyOtpUrl',
        data: data,
      );
      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Otp verified successfully',
          'data': User.fromJson(response.data['data']),
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': '${response.data['message']}, ${response.data['error']}'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Resend otp
  Future<Map<String, dynamic>> resendOtp(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kUserBaseUrl/$kResendOtpUrl',
        data: data,
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Otp resend successfully'
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': 'Unknown Error Occurred'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Request reset code
  Future<Map<String, dynamic>> requestResetCode(
      Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kUserBaseUrl/$kRequestResetCode',
        data: data,
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Reset code sent successfully',
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': '${response.data['message']}, ${response.data['error']}'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Reset password
  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kUserBaseUrl/$kResetPassword',
        data: data,
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Password reset successfully',
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': '${response.data['message']}, ${response.data['error']}'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Get profile completion status
  Future<Map<String, dynamic>> getProfileStatus(User? user) async {
    try {
      Response response = await _service.dio.get(
        '$kBaseUrl/$kUserBaseUrl/${user?.userId}/$kProfileStatusUrl',
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Profile completion status fetched successfully',
          'data': response.data['data']['is_profile_completed'] as bool,
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': '${response.data['message']}, ${response.data['error']}'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Get profile data
  Future<Map<String, dynamic>> getProfileData(int? userId) async {
    try {
      Response response = await _service.dio.get(
        '$kBaseUrl/$kUserBaseUrl/$kGetUserUrl',
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Profile fetched successfully',
          'data': User.fromJson(response.data['data']),
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': 'Unknown Error Occurred'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Complete profile
  Future<Map<String, dynamic>> completeProfile(
      Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.put(
        '$kBaseUrl/$kUserBaseUrl',
        data: data,
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Profile updated successfully'
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': 'Unknown Error Occurred'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Update profile image
  Future<Map<String, dynamic>> updateProfileImage(
      {required int? userId, required Map<String, dynamic> data}) async {
    try {
      late FormData formData;
      if (data['profile_picture_url']
          .toString()
          .contains('com.yimaru.lms.app/')) {
        formData = FormData.fromMap({
          'file': data['profile_picture_url'].toString().isNotEmpty
              ? MultipartFile.fromFileSync(
                  data['profile_picture_url'],
                  filename:
                      data['profile_picture_url'].toString().split('/').last,
                )
              : null,
        });
      } else {
        formData = FormData.fromMap({
          'file': data['profile_picture_url'].toString().isNotEmpty
              ? MultipartFile.fromFileSync(
                  data['profile_picture_url'],
                  filename:
                      data['profile_picture_url'].toString().split('/').last,
                )
              : null,
        });
      }
      Response response = await _service.dio.post(
        '$kBaseUrl/$kUserBaseUrl/$userId/$kUpdateProfileImage',
        data: formData,
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Profile updated successfully'
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': 'Unknown Error Occurred'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Mark notifications
  Future<void> markNotificationsRead() async {
    try {
      await _service.dio.post(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kNotificationsUrl/$kMarkNotificationRead');
    } catch (e) {
      return;
    }
  }

  // Get unread notifications
  Future<int> getUnreadNotifications() async {
    try {
      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kNotificationsUrl/$kUnreadUrl');

      if (response.statusCode == 200) {
        return response.data['unread'];
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  // Get notifications
  Future<List<InAppNotification>> getAllNotifications() async {
    try {
      List<InAppNotification> notifications = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kNotificationsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['notifications'] as List;
        notifications = decodedData.map(
          (e) {
            return InAppNotification.fromJson(e);
          },
        ).toList();
        return notifications;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get assessment question sets
  Future<List<Assessment>> getAssessments() async {
    try {
      List<Assessment> assessments = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/api/$kApiVersionUrl/$kQuestionSetsUrl?set_type=INITIAL_ASSESSMENT&limit=10&offset=0');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['question_sets'] as List;
        assessments = decodedData
            .map(
              (e) {
                return Assessment.fromJson(e);
              },
            )
            .toList()
            .reversed
            .toList();
        return assessments;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get educational levels
  Future<List<FieldOption>> getEducationalLevels() async {
    try {
      List<FieldOption> levels = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kFieldOptions?field_key=education_level');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['education_level'] as List;
        levels = decodedData.map(
          (e) {
            return FieldOption.fromJson(e);
          },
        ).toList();
        return levels;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get ethiopia regions
  Future<List<FieldOption>> getEthiopiaRegions() async {
    try {
      List<FieldOption> levels = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kFieldOptions?field_key=ethiopia_regions');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['ethiopia_regions'] as List;
        levels = decodedData.map(
          (e) {
            return FieldOption.fromJson(e);
          },
        ).toList();
        return levels;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get language challenges
  Future<List<FieldOption>> getLanguageChallenges() async {
    try {
      List<FieldOption> levels = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kFieldOptions?field_key=language_challange');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['language_challange'] as List;
        levels = decodedData.map(
          (e) {
            return FieldOption.fromJson(e);
          },
        ).toList();
        return levels;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get occupations
  Future<List<FieldOption>> getOccupations() async {
    try {
      List<FieldOption> levels = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kFieldOptions?field_key=occupation');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['occupation'] as List;
        levels = decodedData.map(
          (e) {
            return FieldOption.fromJson(e);
          },
        ).toList();
        return levels;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get age group
  Future<List<FieldOption>> getAgeGroups() async {
    try {
      List<FieldOption> levels = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kFieldOptions?field_key=age_group');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['age_group'] as List;
        levels = decodedData.map(
          (e) {
            return FieldOption.fromJson(e);
          },
        ).toList();
        return levels;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get countries
  Future<List<FieldOption>> getCountries() async {
    try {
      List<FieldOption> levels = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kFieldOptions?field_key=country');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['country'] as List;
        levels = decodedData.map(
          (e) {
            return FieldOption.fromJson(e);
          },
        ).toList();
        return levels;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get topics
  Future<List<FieldOption>> getTopics() async {
    try {
      List<FieldOption> levels = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kFieldOptions?field_key=favourite_topic');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['favourite_topic'] as List;
        levels = decodedData.map(
          (e) {
            return FieldOption.fromJson(e);
          },
        ).toList();
        return levels;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get topics
  Future<List<FieldOption>> getLanguageGoals() async {
    try {
      List<FieldOption> levels = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kFieldOptions?field_key=language_goal');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['language_goal'] as List;
        levels = decodedData.map(
          (e) {
            return FieldOption.fromJson(e);
          },
        ).toList();
        return levels;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get learning goal
  Future<List<FieldOption>> getLearningGoals() async {
    try {
      List<FieldOption> levels = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kFieldOptions?field_key=learning_goal');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['learning_goal'] as List;
        levels = decodedData.map(
          (e) {
            return FieldOption.fromJson(e);
          },
        ).toList();
        return levels;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get assessment questions
  Future<List<AssessmentQuestion>> getAssessmentQuestions(int id) async {
    try {
      List<AssessmentQuestion> questions = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/api/$kApiVersionUrl/$kQuestionSetsUrl/$id/$kQuestionsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        questions = decodedData.map(
          (e) {
            return AssessmentQuestion.fromJson(e);
          },
        ).toList();
        return questions;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Complete profile
  Future<Map<String, dynamic>> refreshObject(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kFilesUrl/$kRefreshUrl',
        data: data,
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Operation successful',
          'data': RefreshObject.fromJson(response.data['data'])
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': 'Unknown Error Occurred'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Learn learn programs
  Future<List<LearnProgram>> getLearnPrograms() async {
    try {
      List<LearnProgram> learnPrograms = [];

      final Response response =
          await _service.dio.get('$kBaseUrl/api/$kApiVersionUrl/$kProgramsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['programs'] as List;
        learnPrograms = decodedData.map(
          (e) {
            return LearnProgram.fromJson(e);
          },
        ).toList();
        return learnPrograms;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Learn learn courses
  Future<List<LearnCourse>> getLearnCourses(int id) async {
    try {
      List<LearnCourse> learnCourses = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/api/$kApiVersionUrl/$kProgramsUrl/$id/$kCoursesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['courses'] as List;
        learnCourses = decodedData.map(
          (e) {
            return LearnCourse.fromJson(e);
          },
        ).toList();
        return learnCourses;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Learn course practices
  Future<List<LearnPractice>> getLearnCoursePractices(int id) async {
    try {
      List<LearnPractice> practices = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/api/$kApiVersionUrl/$kCoursesUrl/$id/$kPracticesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['practices'] as List;
        practices = decodedData.map(
          (e) {
            return LearnPractice.fromJson(e);
          },
        ).toList();
        return practices;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get learn modules
  Future<List<LearnModule>> getLearnModules(int id) async {
    try {
      List<LearnModule> modules = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/api/$kApiVersionUrl/$kCoursesUrl/$id/$kModulesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['modules'] as List;
        modules = decodedData.map(
          (e) {
            return LearnModule.fromJson(e);
          },
        ).toList();
        return modules;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Learn module practices
  Future<List<LearnPractice>> getLearnModulePractices(int id) async {
    try {
      List<LearnPractice> practices = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/api/$kApiVersionUrl/$kModulesUrl/$id/$kPracticesUrl');
      print('MODULE PRACTICES: ${response.data}');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['practices'] as List;
        practices = decodedData.map(
          (e) {
            return LearnPractice.fromJson(e);
          },
        ).toList();
        return practices;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get learn lessons
  Future<List<LearnLesson>> getLearnLessons(int id) async {
    try {
      List<LearnLesson> lessons = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/api/$kApiVersionUrl/$kModulesUrl/$id/$kLessonsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['lessons'] as List;
        lessons = decodedData.map(
          (e) {
            return LearnLesson.fromJson(e);
          },
        ).toList();
        return lessons;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Complete lesson
  Future<Map<String, dynamic>> completeLearnLesson(int id) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kLessonsUrl/$id/$kCompleteUrl',
      );

      if (response.statusCode == 200 && response.data['success']) {
        return {
          'message': 'Lesson completed',
          'status': ResponseStatus.success,
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': 'Unknown Error Occurred'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Learn lesson practices
  Future<List<LearnPractice>> getLearnLessonPractices(int id) async {
    try {
      List<LearnPractice> practices = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/api/$kApiVersionUrl/$kLessonsUrl/$id/$kPracticesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['practices'] as List;
        practices = decodedData.map(
          (e) {
            return LearnPractice.fromJson(e);
          },
        ).toList();
        return practices;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get learn questions
  Future<List<LearnQuestion>> getLearnQuestions(int id) async {
    try {
      List<LearnQuestion> questions = [];
      print('Here');

      final Response response = await _service.dio.get(
          '$kBaseUrl/api/$kApiVersionUrl/$kQuestionSetsUrl/$id/$kQuestionsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        questions = decodedData.map(
          (e) {
            return LearnQuestion.fromJson(e);
          },
        ).toList();
        return questions;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get progress summary
  Future<List<ProgressSummary>> getProgressSummary() async {
    try {
      List<ProgressSummary> summaries = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kLmsUrl/$kProgressSummary');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['programs'] as List;
        summaries = decodedData.map(
          (e) {
            return ProgressSummary.fromJson(e);
          },
        ).toList();
        return summaries;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Complete lesson
  Future<Map<String, dynamic>> completeLearnPractice(int id) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kProgressUrl/$kPracticesUrl/$id/$kCompleteUrl',
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Lesson completed'
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': 'Unknown Error Occurred'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  Future<List<LearnSubscription>> getLearnSubscriptions() async {
    try {
      List<LearnSubscription> subscriptions = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kSubscriptionsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        subscriptions = decodedData.map(
          (e) {
            return LearnSubscription.fromJson(e);
          },
        ).toList();
        return subscriptions;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Create subscription
  Future<Map<String, dynamic>> createSubscriptionRequest(
      Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kPaymentsUrl/$kSubscribeUrl',
          data: data);

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Subscription successful!',
          'data': LearnSubscriptionRequest.fromJson(response.data['data']),
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': 'Unknown Error Occurred'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Verify subscription
  Future<Map<String, dynamic>> verifySubscription(int id) async {
    try {
      Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kPaymentsUrl/$kVerifySubscriptionUrl/$id');

      if (response.statusCode == 200) {
        return {
          'message': 'Lesson completed',
          'status': ResponseStatus.success,
          'data': LearnSubscriptionRequest.fromJson(response.data['data']),
        };
      } else {
        return {
          'status': ResponseStatus.failure,
          'message': 'Unknown Error Occurred'
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }

  // Get course catalogs
  Future<List<CourseCatalog>> getCourseCatalogs() async {
    try {
      List<CourseCatalog> catalogs = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kExamPrepUrl/$kCatalogCoursesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['catalog_courses'] as List;
        catalogs = decodedData.map(
          (e) {
            return CourseCatalog.fromJson(e);
          },
        ).toList();
        return catalogs;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get course units
  Future<List<CourseUnit>> getCourseUnits(int id) async {
    try {
      List<CourseUnit> units = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kExamPrepUrl/$kCatalogCoursesUrl/$id/$kUnitsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['units'] as List;
        units = decodedData.map(
          (e) {
            return CourseUnit.fromJson(e);
          },
        ).toList();
        return units;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get course modules
  Future<List<CourseModule>> getCourseModules(int id) async {
    try {
      List<CourseModule> modules = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kExamPrepUrl/$kUnitsUrl/$id/$kModulesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['modules'] as List;
        modules = decodedData.map(
          (e) {
            return CourseModule.fromJson(e);
          },
        ).toList();
        return modules;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get course lessons
  Future<List<CourseLesson>> getCourseLessons(int id) async {
    try {
      List<CourseLesson> lessons = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kExamPrepUrl/$kModulesUrl/$id/$kLessonsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['lessons'] as List;
        lessons = decodedData.map(
          (e) {
            return CourseLesson.fromJson(e);
          },
        ).toList();
        return lessons;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Check update
  Future<Map<String, dynamic>> checkUpdate(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.get(
        '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kAppUrl/$kApiVersionUrl/$kCheckUrl',
        data: data,
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'data': AppUpdate.fromJson(response.data['data']),
        };
      } else {
        return {
          'status': ResponseStatus.failure,
        };
      }
    } on DioException {
      return {
        'status': ResponseStatus.failure,
      };
    }
  }
}
