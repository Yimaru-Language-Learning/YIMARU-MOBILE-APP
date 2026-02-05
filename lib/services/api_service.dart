import 'package:dio/dio.dart';
import 'package:yimaru_app/models/assessment.dart';
import 'package:yimaru_app/models/user_model.dart';
import 'package:yimaru_app/services/dio_service.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';

import '../app/app.locator.dart';
import '../ui/common/enmus.dart';

class ApiService {
  final _service = locator<DioService>();

  // Register
  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kUserUrl/$kRegisterUrl',
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
    } catch (e) {
      return {
        'message': e.toString(),
        'status': ResponseStatus.failure,
      };
    }
  }

  // Login
  Future<Map<String, dynamic>> emailLogin(Map<String, dynamic> data) async {
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
    } catch (e) {
      return {
        'message': e.toString(),
        'status': ResponseStatus.failure,
      };
    }
  }

  // Google login
  Future<Map<String, dynamic>> googleLogin(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kGoogleLoginUrl',
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
    } catch (e) {
      return {
        'message': e.toString(),
        'status': ResponseStatus.failure,
      };
    }
  }

  // Verify otp
  Future<Map<String, dynamic>> verifyOtp(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kUserUrl/$kVerifyOtpUrl',
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
    } catch (e) {
      return {
        'message': e.toString(),
        'status': ResponseStatus.failure,
      };
    }
  }

  // Resend otp
  Future<Map<String, dynamic>> resendOtp(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
        '$kBaseUrl/$kUserUrl/$kResendOtpUrl',
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
    } catch (e) {
      return {
        'message': e.toString(),
        'status': ResponseStatus.failure,
      };
    }
  }

  // Profile completed
  Future<Map<String, dynamic>> getProfileStatus(UserModel? user) async {
    try {
      Response response = await _service.dio.get(
        '$kBaseUrl/$kUserUrl/${user?.userId}/$kProfileStatusUrl',
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
    } catch (e) {
      return {
        'message': e.toString(),
        'status': ResponseStatus.failure,
      };
    }
  }

  // Get profile
  Future<Map<String, dynamic>> getProfileData(int? userId) async {
    try {
      Response response = await _service.dio.get(
        '$kBaseUrl/$kUserUrl/$kGetUserUrl/$userId',
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
    } catch (e) {
      return {
        'message': e.toString(),
        'status': ResponseStatus.failure,
      };
    }
  }

  // Complete profile
  Future<Map<String, dynamic>> completeProfile(
      Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.put(
        '$kBaseUrl/$kUserUrl',
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
    } catch (e) {
      return {
        'message': e.toString(),
        'status': ResponseStatus.failure,
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
          .contains('com.example.yimaru_app/')) {
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
        '$kBaseUrl/$kUserUrl/$userId/$kUpdateProfileImage',
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
    } catch (e) {
      return {
        'message': e.toString(),
        'status': ResponseStatus.failure,
      };
    }
  }

  //
  // // Update profile
  // Future<Map<String, dynamic>> updateProfile(
  //     Map<String, dynamic> data) async {
  //   try {
  //     late FormData formData;
  //
  //     if (data['profile_picture_url']
  //         .toString()
  //         .contains('com.ke.wede.customer.app/')) {
  //       formData = FormData.fromMap({
  //         'gender': data['gender'],
  //         'region': data['region'],
  //         'country': data['country'],
  //         'last_name': data['last_name'],
  //         'nick_name': data['nick_name'],
  //         'birth_day': data['birth_day'],
  //         'age_group': data['age_group'],
  //         'occupation': data['occupation'],
  //         'first_name': data['first_name'],
  //         'learning_goal': data['learning_goal'],
  //         'language_goal': data['language_goal'],
  //         'education_level': data['education_level'],
  //         'favoutite_topic': data['favoutite_topic'],
  //         'knowledge_level': data['knowledge_level'],
  //         'profile_completed': data['profile_completed'],
  //         'preferred_language': data['preferred_language'],
  //         'language_challange': data['language_challange'],
  //         'profile_picture_url': data['profile_picture_url']
  //             .toString()
  //             .isNotEmpty
  //             ? MultipartFile.fromFileSync(
  //           data['profile_picture_url'],
  //           filename:
  //           data['profile_picture_url'].toString().split('/').last,
  //         )
  //             : null,
  //       });
  //     } else {
  //       formData = FormData.fromMap({
  //         'gender': data['gender'],
  //         'region': data['region'],
  //         'country': data['country'],
  //         'last_name': data['last_name'],
  //         'nick_name': data['nick_name'],
  //         'birth_day': data['birth_day'],
  //         'age_group': data['age_group'],
  //         'occupation': data['occupation'],
  //         'first_name': data['first_name'],
  //         'learning_goal': data['learning_goal'],
  //         'language_goal': data['language_goal'],
  //         'education_level': data['education_level'],
  //         'favoutite_topic': data['favoutite_topic'],
  //         'knowledge_level': data['knowledge_level'],
  //         'profile_completed': data['profile_completed'],
  //         'preferred_language': data['preferred_language'],
  //         'language_challange': data['language_challange'],
  //         'profile_picture_url': data['profile_picture_url']
  //             .toString()
  //             .isNotEmpty
  //             ? MultipartFile.fromFileSync(
  //           data['profile_picture_url'],
  //           filename:
  //           data['profile_picture_url'].toString().split('/').last,
  //         )
  //             : null,
  //       });
  //     }
  //     Response response = await _service.dio.put(
  //       '$baseUrl/$kUserUrl',
  //       data: formData,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       return {
  //         'status': ResponseStatus.success,
  //         'message': 'Profile updated successfully'
  //       };
  //     } else {
  //       return {
  //         'status': ResponseStatus.failure,
  //         'message': 'Unknown Error Occurred'
  //       };
  //     }
  //   } catch (e) {
  //     return {
  //       'message': e.toString(),
  //       'status': ResponseStatus.failure,
  //     };
  //   }
  // }
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
}
