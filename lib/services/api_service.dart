import 'package:dio/dio.dart';
import 'package:yimaru_app/models/assessment.dart';
import 'package:yimaru_app/models/course_subcategory.dart';
import 'package:yimaru_app/models/course_category.dart';
import 'package:yimaru_app/models/course_lesson.dart';
import 'package:yimaru_app/models/course_progress.dart';
import 'package:yimaru_app/models/course.dart';
import 'package:yimaru_app/models/practice.dart';
import 'package:yimaru_app/models/practice_question.dart';
import 'package:yimaru_app/models/user_model.dart';
import 'package:yimaru_app/services/dio_service.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';

import '../app/app.locator.dart';
import '../ui/common/enmus.dart';

class ApiService {
  // Dependency injection
  final _service = locator<DioService>();

  // Register
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

  // Email login
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
          'data': UserModel.fromJson(response.data['data']),
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

  // Google login
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
          'data': UserModel.fromJson(response.data['data']),
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
          'data': UserModel.fromJson(response.data['data']),
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

  // Profile completed
  Future<Map<String, dynamic>> getProfileStatus(UserModel? user) async {
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

  // Get profile
  Future<Map<String, dynamic>> getProfileData(int? userId) async {
    try {
      Response response = await _service.dio.get(
        '$kBaseUrl/$kUserBaseUrl/$kGetUserUrl',
      );

      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Profile fetched successfully',
          'data': UserModel.fromJson(response.data['data']),
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

  // Assessments
  Future<List<Assessment>> getAssessments() async {
    try {
      List<Assessment> assessments = [];

      final Response response =
          await _service.dio.get('$kBaseUrl/$kAssessmentsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        assessments = decodedData.map(
          (e) {
            return Assessment.fromJson(e);
          },
        ).toList();
        return assessments;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Course categories
  Future<List<CourseCategory>> getCourseCategories() async {
    try {
      List<CourseCategory> categories = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/$kCourseBaseUrl/$kCourseCategoryUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['categories'] as List;
        categories = decodedData.map(
          (e) {
            return CourseCategory.fromJson(e);
          },
        ).toList();
        return categories;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Course subcategory
  Future<List<CourseSubcategory>> getCourseSubcategories(int id) async {
    try {
      List<CourseSubcategory> subcategories = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kCourseBaseUrl/$kCourseCategoryUrl/$id/$kCoursesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['courses'] as List;
        subcategories = decodedData.map(
          (e) {
            return CourseSubcategory.fromJson(e);
          },
        ).toList();
        return subcategories;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Sub-courses
  Future<List<Course>> getCourses(int id) async {
    try {
      List<Course> courses = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/$kCourseBaseUrl/$kCoursesUrl/$id/$kSubcoursesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['sub_courses'] as List;
        courses = decodedData.map(
          (e) {
            return Course.fromJson(e);
          },
        ).toList();
        return courses;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Course progress
  Future<List<CourseProgress>> getCourseProgress(int id) async {
    try {
      List<CourseProgress> courseProgress = [];

      final Response response =
          await _service.dio.get('$kBaseUrl/$kCourseProgressUrl/$id');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        courseProgress = decodedData.map(
          (e) {
            return CourseProgress.fromJson(e);
          },
        ).toList();
        return courseProgress;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Course videos
  Future<List<CourseLesson>> getCourseLessons(int id) async {
    try {
      List<CourseLesson> courseLessons = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kCourseBaseUrl/$kSubcoursesUrl/$id/$kPublishedVideos');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        courseLessons = decodedData.map(
          (e) {
            return CourseLesson.fromJson(e);
          },
        ).toList();
        return courseLessons;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Complete lesson
  Future<Map<String, dynamic>> completeLesson(int id) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kLessonProgressUrl/$id/$kCompleteLessonUrl',
      );

      if (response.statusCode == 200) {
        return {'status': ResponseStatus.success, 'message': 'Video completed'};
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

  // Course practices
  Future<List<Practice>> getCoursePractices(Map<String, dynamic> data) async {
    try {
      List<Practice> coursePractices = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/$kPracticeBaseUrl/$kCoursePractice', data: data);

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        coursePractices = decodedData.map(
          (e) {
            return Practice.fromJson(e);
          },
        ).toList();
        return coursePractices;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Course practic questions
  Future<List<PracticeQuestion>> getCoursePracticeQuestions(int id) async {
    try {
      List<PracticeQuestion> coursePracticeQuestions = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/$kPracticeBaseUrl/$id/$kCoursePracticeQuestions');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        coursePracticeQuestions = decodedData.map(
          (e) {
            return PracticeQuestion.fromJson(e);
          },
        ).toList();
        return coursePracticeQuestions;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
