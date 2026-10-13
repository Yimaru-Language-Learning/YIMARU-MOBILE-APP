import 'package:dio/dio.dart';
import 'package:yimaru_app/models/app_update.dart';
import 'package:yimaru_app/models/faq.dart';
import 'package:yimaru_app/models/in_app_notification.dart';
import 'package:yimaru_app/models/learn_lesson.dart';
import 'package:yimaru_app/models/learn_practice.dart';
import 'package:yimaru_app/models/learn_program.dart';
import 'package:yimaru_app/models/course_catalog.dart';
import 'package:yimaru_app/models/course_lesson.dart';
import 'package:yimaru_app/models/my_subscription.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/dio_service.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';

import '../app/app.locator.dart';
import '../models/assessment_session.dart';
import '../models/course_module.dart';
import '../models/course_practice.dart';
import '../models/practice_question.dart';
import '../models/course_unit.dart';
import '../models/field_option.dart';
import '../models/learn_course.dart';
import '../models/learn_module.dart';
import '../models/proficiency_level.dart';
import '../models/subscription.dart';
import '../models/learn_subscription_request.dart';
import '../models/progress_summary.dart';
import '../ui/common/enmus.dart';
import 'read_request_failure.dart';

class ApiService {
  Future<void> recordReminderActivity(CancelToken cancellation) async {
    await _service.dio.post('$kBaseUrl/api/v1/users/me/activity',
        cancelToken: cancellation,
        options: Options(extra: {
          DioService.privateReminderRequest: true,
          DioService.backgroundReminderActivity: true,
        }));
  }

  Future<bool> getReminderPreference() async {
    final response = await _service.dio.get(
        '$kBaseUrl/api/v1/users/me/reminder-preferences',
        options: Options(extra: {DioService.privateReminderRequest: true}));
    final enabled = response.data['data']['enabled'];
    if (enabled is! bool) throw StateError('Invalid reminder preference');
    return enabled;
  }

  Future<bool> setReminderPreference(bool enabled) async {
    final response = await _service.dio.put(
        '$kBaseUrl/api/v1/users/me/reminder-preferences',
        data: {'enabled': enabled},
        options: Options(extra: {DioService.privateReminderRequest: true}));
    final saved = response.data['data']['enabled'];
    if (saved is! bool) throw StateError('Invalid reminder preference');
    return saved;
  }

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

  Future<void> registerDevice(Map<String, dynamic> data,
      {CancelToken? cancelToken, bool backgroundSync = false}) async {
    try {
      await _service.dio.post(
        '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kDevicesUrl/$kRegisterUrl',
        data: data,
        cancelToken: cancelToken,
        options: backgroundSync
            ? Options(extra: {DioService.backgroundDeviceRegistration: true})
            : null,
      );
    } on DioException {
      rethrow;
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
      if (isRetryableReadFailure(e)) rethrow;
      return [];
    }
  }

  // Get assessment session
  Future<Map<String, dynamic>> getAssessmentSession() async {
    try {
      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kAssessmentUrl/$kSessionUrl');

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Assessment session fetched successfully.',
          'data': AssessmentSession.fromJson(response.data['data']),
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

  // Get assessment questions
  Future<List<PracticeQuestion>> getInitialAssessment(String level) async {
    try {
      List<PracticeQuestion> questions = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kAssessmentUrl/$kQuestionsUrl?level=$level');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        questions = decodedData.map(
          (e) {
            return PracticeQuestion.fromJson(e);
          },
        ).toList();
        return questions;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Finish assessment
  Future<Map<String, dynamic>> finishAssessment(
      Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kAssessmentUrl/$kSubmitUrl',
          data: data);

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Assessment submitted successfully.',
          'data': ProficiencyLevel.fromJson(response.data['data']),
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

  // Update knowledge-level
  Future<Map<String, dynamic>> updateKnowledgeLevel(
      Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.put(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kUserUrl/$kKnowledgeLevelUrl',
          data: data);

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Assessment submitted successfully.',
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

  // Refresh object
  /*Future<Map<String, dynamic>> refreshObject(Map<String, dynamic> data) async {
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
  }*/

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
      if (isRetryableReadFailure(e)) rethrow;
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
      if (isRetryableReadFailure(e)) rethrow;
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
      if (isRetryableReadFailure(e)) rethrow;
      return [];
    }
  }

  // Learn module practices
  Future<List<LearnPractice>> getLearnModulePractices(int id) async {
    try {
      List<LearnPractice> practices = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/api/$kApiVersionUrl/$kModulesUrl/$id/$kPracticesUrl');

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
    final rows = await _getModuleLessons(
        '$kBaseUrl/api/$kApiVersionUrl/$kModulesUrl/$id/$kLessonsUrl');
    return rows.map(LearnLesson.fromJson).toList();
  }

  Future<List<Map<String, dynamic>>> _getModuleLessons(String url) async {
    final rows = <Map<String, dynamic>>[];
    try {
      while (true) {
        final response = await _service.dio
            .get(url, queryParameters: {'limit': 200, 'offset': rows.length});
        if (response.statusCode != 200) {
          throw StateError('Unable to fetch lessons');
        }
        final data = response.data['data'];
        final page = (data['lessons'] as List?) ?? [];
        rows.addAll(page.map((row) => Map<String, dynamic>.from(row)));
        final total = (data['total_count'] as num?)?.toInt();
        if (page.isEmpty ||
            (total != null ? rows.length >= total : page.length < 200)) {
          break;
        }
      }
      return rows;
    } on DioException catch (error) {
      // A removed/hidden module is authoritative; network/server errors are not.
      if (error.response?.statusCode == 403 ||
          error.response?.statusCode == 404) {
        return [];
      }
      rethrow;
    }
  }

  // Mark lesson progress
  Future<void> markLessonProgress(Map<String, dynamic> data) async {
    try {
      await _service.dio.post(
        '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kVideosUrl/$kEngagementUrl/$kHeartbeatUrl',
        data: data,
      );
    } on DioException {
      rethrow;
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
  Future<List<PracticeQuestion>> getLearnQuestions(int id) async {
    try {
      List<PracticeQuestion> questions = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kQuestionSetsUrl/$id/$kQuestionsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        questions = decodedData.map(
          (e) {
            return PracticeQuestion.fromJson(e);
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
      if (isRetryableReadFailure(e)) rethrow;
      return [];
    }
  }

  // Complete lesson
  Future<Map<String, dynamic>> completePractice(
      {required int id, required Map<String, dynamic> data}) async {
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

  Future<List<Subscription>> getSubscriptions(String type) async {
    try {
      List<Subscription> subscriptions = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kSubscriptionPlansUrl?category=$type');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        subscriptions = decodedData.map(
          (e) {
            return Subscription.fromJson(e);
          },
        ).toList();
        return subscriptions;
      }
      return [];
    } catch (e) {
      if (isRetryableReadFailure(e)) rethrow;
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
        'payment_outcome_unknown': _paymentOutcomeUnknown(e),
      };
    } catch (_) {
      return {
        'status': ResponseStatus.failure,
        'payment_outcome_unknown': true,
      };
    }
  }

  // Create direct payment
  Future<Map<String, dynamic>> createDirectPaymentRequest(
      Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kPaymentsUrl/$kChapaUrl/$kDirectUrl',
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
        'payment_outcome_unknown': _paymentOutcomeUnknown(e),
      };
    } catch (_) {
      return {
        'status': ResponseStatus.failure,
        'payment_outcome_unknown': true,
      };
    }
  }

  // A lost response or server error does not prove that no payment was created.
  bool _paymentOutcomeUnknown(DioException error) {
    final statusCode = error.response?.statusCode;
    return statusCode == null || statusCode >= 500 || statusCode == 408;
  }

  Future<String?> getCheckoutPaymentStatus(String sessionId) async {
    try {
      final response = await _service.dio.get(
        '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kPaymentsUrl/'
        '$kVerifySubscriptionUrl/${Uri.encodeComponent(sessionId)}',
      );
      final status = response.data['data']['status'];
      return status is String ? status.toUpperCase() : null;
    } catch (_) {
      return null;
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

  Future<List<MySubscription>> getMySubscriptions() async {
    try {
      List<MySubscription> subscriptions = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kSubscriptionsUrl/$kMeUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        subscriptions = decodedData.map(
          (e) {
            return MySubscription.fromJson(e);
          },
        ).toList();
        return subscriptions;
      }
      return [];
    } catch (e) {
      if (isRetryableReadFailure(e)) rethrow;
      return [];
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
      if (isRetryableReadFailure(e)) rethrow;
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
      if (isRetryableReadFailure(e)) rethrow;
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
      if (isRetryableReadFailure(e)) rethrow;
      return [];
    }
  }

  // Get course lessons
  Future<List<CourseLesson>> getCourseLessons(int id) async {
    final rows = await _getModuleLessons(
        '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kExamPrepUrl/$kModulesUrl/$id/$kLessonsUrl');
    return rows.map(CourseLesson.fromJson).toList();
  }

  // Course catalog practices
  Future<List<CoursePractice>> getCourseCatalogPractices(int id) async {
    try {
      List<CoursePractice> practices = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kExamPrepUrl/$kCatalogCoursesUrl/$id/$kPracticesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['practices'] as List;
        practices = decodedData.map(
          (e) {
            return CoursePractice.fromJson(e);
          },
        ).toList();
        return practices;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Course unit practices
  Future<List<CoursePractice>> getCourseUnitPractices(int id) async {
    try {
      List<CoursePractice> practices = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kExamPrepUrl/$kUnitsUrl/$id/$kPracticesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['practices'] as List;
        practices = decodedData.map(
          (e) {
            return CoursePractice.fromJson(e);
          },
        ).toList();
        return practices;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Course lesson practices
  Future<List<CoursePractice>> getCourseLessonPractices(int id) async {
    try {
      List<CoursePractice> practices = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kExamPrepUrl/$kLessonsUrl/$id/$kPracticesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['practices'] as List;
        practices = decodedData.map(
          (e) {
            return CoursePractice.fromJson(e);
          },
        ).toList();
        return practices;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get course questions
  Future<List<PracticeQuestion>> getCourseQuestions(int id) async {
    try {
      List<PracticeQuestion> questions = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kQuestionSetsUrl/$id/$kQuestionsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        questions = decodedData.map(
          (e) {
            return PracticeQuestion.fromJson(e);
          },
        ).toList();
        return questions;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Check update
  Future<Map<String, dynamic>> checkUpdate(String versionCode) async {
    try {
      Response response = await _service.dio.get(
        '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kAppUrl/$kVersionUrl/$kCheckUrl?platform=ANDROID&version_code=$versionCode',
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

  Future<Map<String, dynamic>> reportIssue(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio
          .post('$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kIssuesUrl', data: data);

      if (response.statusCode == 201) {
        return {
          'status': ResponseStatus.success,
          'message': 'Issue reported successfully!',
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

  // Get faqs
  Future<List<Faq>> getFaqs() async {
    try {
      List<Faq> faqs = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kFaqsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['faqs'] as List;
        faqs = decodedData.map(
          (e) {
            return Faq.fromJson(e);
          },
        ).toList();
        return faqs;
      }
      return [];
    } catch (e) {
      if (isRetryableReadFailure(e)) rethrow;
      return [];
    }
  }

  // Rate app
  Future<Map<String, dynamic>> rateApp(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio
          .post('$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kRatingsUrl', data: data);

      if (response.statusCode == 201) {
        return {
          'status': ResponseStatus.success,
          'message': 'Rated successfully!',
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

  // Rate app
  Future<Map<String, dynamic>> iosCheckout(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
          '$kBaseUrl/$kApiUrl/$kApiVersionUrl/$kSubscriptionsUrl/$kIosCheckout',
          data: data);

      if (response.statusCode == 201) {
        return {
          'status': ResponseStatus.success,
        };
      } else {
        return {
          'status': ResponseStatus.failure,
        };
      }
    } on DioException catch (e) {
      return {
        'status': ResponseStatus.failure,
        'message': e.response?.data.toString(),
      };
    }
  }
}
