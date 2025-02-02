//This function is used to catch Dio Exception and dynamically pass the message and StatusCode
import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:dio/dio.dart';

Exception handleDioClientError(DioException e) {
  switch (e.type) {
    case DioExceptionType.cancel:
      return NetworkException(message: "Request to API server was cancelled");
    case DioExceptionType.connectionTimeout:
      return NetworkException(message: "Connection timeout with API server");
    case DioExceptionType.unknown:
      return NetworkException(
          message:
              "Connection to API server failed due to internet connection");
    case DioExceptionType.receiveTimeout:
      return NetworkException(
          message: "Receive timeout in connection with API server");
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final message = e.response?.statusMessage ??
          "Received invalid status code: $statusCode";
      return ApiServerException(message: message, statusCode: statusCode);
    case DioExceptionType.sendTimeout:
      return NetworkException(
          message: "Send timeout in connection with API server");
    default:
      return NetworkException(message: "Unexpected error occurred");
  }
}
