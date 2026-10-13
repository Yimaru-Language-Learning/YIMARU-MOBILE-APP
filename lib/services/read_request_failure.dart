import 'package:dio/dio.dart';

/// Read failures that can recover without changing the user's request.
bool isRetryableReadFailure(Object error) {
  if (error is! DioException) return false;
  final status = error.response?.statusCode;
  if (status != null) return status >= 500 && status < 600;
  return error.type == DioExceptionType.connectionError ||
      error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.sendTimeout ||
      error.type == DioExceptionType.receiveTimeout;
}
