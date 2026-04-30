import 'package:dio/dio.dart';
import 'package:yimaru_app/models/learn_lesson.dart';
import 'package:yimaru_app/models/learn_practice.dart';
import 'package:yimaru_app/models/learn_program.dart';
import 'package:yimaru_app/models/level.dart';
import 'package:yimaru_app/models/assessment_question.dart';
import 'package:yimaru_app/models/subcategory.dart';
import 'package:yimaru_app/models/category.dart';
import 'package:yimaru_app/models/course_lesson.dart';
import 'package:yimaru_app/models/course_progress.dart';
import 'package:yimaru_app/models/course.dart';
import 'package:yimaru_app/models/practice.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/dio_service.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';

import '../app/app.locator.dart';
import '../models/learn_course.dart';
import '../models/learn_module.dart';
import '../models/learn_question.dart';
import '../models/lesson.dart';
import '../models/module.dart';
import '../models/assessment.dart';
import '../models/submodule.dart';
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

  // Get assessment question sets
  Future<List<Assessment>> getAssessments() async {
    try {
      List<Assessment> assessments = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/api/$kApiVersionUrl/$kQuestionSetsUrl?set_type=INITIAL_ASSESSMENT&limit=10&offset=0');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['question_sets'] as List;
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
  Future<List<LearnCourse>> getLearnCourse(int id) async {
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

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
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

  /* TO BE MODIFIED*/

  // Get categories
  Future<List<Category>> getCategories() async {
    try {
      List<Category> categories = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/api/$kApiVersionUrl/$kCourseManagementUrl/$kCategoryUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['categories'] as List;
        categories = decodedData.map(
          (e) {
            return Category.fromJson(e);
          },
        ).toList();
        return categories;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get course subcategory
  Future<List<Subcategory>> getSubcategories(int id) async {
    try {
      List<Subcategory> subcategories = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/$kCourseBaseUrl/$kCategoryUrl/$id/$kCoursesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['courses'] as List;
        subcategories = decodedData.map(
          (e) {
            return Subcategory.fromJson(e);
          },
        ).toList();
        return subcategories;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get courses
  // Future<List<Course>> getCourses(int id) async {
  //   try {
  //     List<Course> courses = [];
  //
  //     final Response response = await _service.dio
  //         .get('$kBaseUrl/$kCourseBaseUrl/$kCoursesUrl/$id/$kSubcoursesUrl');
  //
  //     if (response.statusCode == 200) {
  //       var data = response.data;
  //       var decodedData = data['data']['sub_courses'] as List;
  //       courses = decodedData.map(
  //         (e) {
  //           return Course.fromJson(e);
  //         },
  //       ).toList();
  //       return courses;
  //     }
  //     return [];
  //   } catch (e) {
  //     return [];
  //   }
  // }

  // Get course progress
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

  // Get course lessons
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
  Future<List<Practice>> getCoursePractices(int id) async {
    try {
      List<Practice> coursePractices = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kPracticeBaseUrl/$kCoursePractice?owner_type=SUB_COURSE&owner_id=$id');

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

  // Get course practic questions
  Future<List<AssessmentQuestion>> getCoursePracticeQuestions(int id) async {
    try {
      List<AssessmentQuestion> coursePracticeQuestions = [];

      final Response response = await _service.dio
          .get('$kBaseUrl/$kPracticeBaseUrl/$id/$kCoursePracticeQuestions');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        coursePracticeQuestions = decodedData.map(
          (e) {
            return AssessmentQuestion.fromJson(e);
          },
        ).toList();
        return coursePracticeQuestions;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get course practice question
  Future<AssessmentQuestion?> getCoursePracticeQuestion(int id) async {
    try {
      final Response response =
          await _service.dio.get('$kBaseUrl/$kCoursePracticeQuestion/$id');

      if (response.statusCode == 200) {
        AssessmentQuestion question =
            AssessmentQuestion.fromJson(response.data['data']);

        return question;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Get learn subcategories
  Future<List<Subcategory>> getLearnSubcategories() async {
    try {
      List<Subcategory> learnSubcategories = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/api/$kApiVersionUrl/$kCourseManagementUrl/$kLearnSubcategoriesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['sub_categories'] as List;
        learnSubcategories = decodedData.map(
          (e) {
            return Subcategory.fromJson(e);
          },
        ).toList();
        return learnSubcategories;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get courses
  Future<List<Course>> getCourses(int id) async {
    try {
      List<Course> courses = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/api/$kApiVersionUrl/$kCourseManagementUrl/$kSubcategoriesUrl/$id/$kCoursesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['courses'] as List;
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

  // Get levels
  Future<List<Level>> getLevels(int id) async {
    try {
      List<Level> levels = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/api/$kApiVersionUrl/$kCourseManagementUrl/$kCoursesUrl/$id/$kLevelsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['levels'] as List;
        levels = decodedData.map(
          (e) {
            return Level.fromJson(e);
          },
        ).toList();
        return levels;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get modules
  Future<List<Module>> getModules(int id) async {
    try {
      List<Module> modules = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/api/$kApiVersionUrl/$kCourseManagementUrl/$kLevelsUrl/$id/$kModulesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['modules'] as List;
        modules = decodedData.map(
          (e) {
            return Module.fromJson(e);
          },
        ).toList();
        return modules;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get submodules
  Future<List<Submodule>> getSubmodules(int id) async {
    try {
      List<Submodule> submodules = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/api/$kApiVersionUrl/$kCourseManagementUrl/$kModulesUrl/$id/$kSubmodulesUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data']['sub_modules'] as List;
        submodules = decodedData.map(
          (e) {
            return Submodule.fromJson(e);
          },
        ).toList();
        return submodules;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Get lessons
  Future<List<Lesson>> getLessons(int id) async {
    try {
      List<Lesson> lessons = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/api/$kApiVersionUrl/$kCourseManagementUrl/$kSubmodulesUrl/$id/$kLessonsUrl');

      if (response.statusCode == 200) {
        var data = response.data;
        var decodedData = data['data'] as List;
        lessons = decodedData.map(
          (e) {
            return Lesson.fromJson(e);
          },
        ).toList();
        return lessons;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Practices
  Future<List<Practice>> getPractices(int id) async {
    try {
      List<Practice> coursePractices = [];

      final Response response = await _service.dio.get(
          '$kBaseUrl/$kPracticeBaseUrl/$kCoursePractice?owner_type=SUB_MODULE&owner_id=$id');

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

  // Questions
  Future<List<AssessmentQuestion>> getQuestions(int id) async {
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
}
