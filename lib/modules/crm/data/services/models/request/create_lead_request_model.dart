import 'package:dio/dio.dart';

class CreateLeadRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String message;

  CreateLeadRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.message,
  });

  /// Converts the model into FormData
  FormData toFormData() {
    return FormData.fromMap({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'message': message,
    });
  }
}
