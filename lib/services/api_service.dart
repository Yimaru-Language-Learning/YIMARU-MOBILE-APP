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
        '$baseUrl/$userUrl/$kRegisterUrl',
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
  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    try {
      Response response = await _service.dio.post(
        '$baseUrl/$kLoginUrl',
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
        '$baseUrl/$userUrl/$kVerifyOtpUrl',
        data: data,
      );
      if (response.statusCode == 200) {
        return {
          'status': ResponseStatus.success,
          'message': 'Otp verified successfully',
          //'data': UserModel.fromJson(response.data['data']),
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
        '$baseUrl/$userUrl/$kResendOtpUrl',
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
        '$baseUrl/$userUrl/${user?.userId}/$kProfileStatusUrl',
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

  // Update profile
  Future<Map<String, dynamic>> updateProfile(
      {required UserModel? user, required Map<String, dynamic> data}) async {
    try {
      Response response = await _service.dio.put(
        '$baseUrl/$userUrl',
        data: data,
      );

      print(response.statusCode);
      print(response.data);

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
      print('Exception ${e.toString()}');
      return {
        'message': e.toString(),
        'status': ResponseStatus.failure,
      };
    }
  }

  // Assessments
  Future<List<Assessment>> getAssessments() async {
    try {
      List<Assessment> assessments = [];

      final Response response =
          await _service.dio.get('$baseUrl/$kAssessmentsUrl');

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
