import 'package:dio/dio.dart';

class CreateDealRequestModel {
  final String? salutation;
  final String firstname;
  final String lastname;
  final String? gender;
  final String? numberOfEmployees;
  final String? industry;
  final String? leadOwner;
  final String? leadStatus;
  final String email;
  final String contact;
  final String? organization;
  final String? website;

  CreateDealRequestModel({
    this.salutation,
    required this.firstname,
    required this.lastname,
    this.gender,
    this.numberOfEmployees,
    this.industry,
    this.leadOwner,
    this.leadStatus,
    required this.email,
    required this.contact,
    this.organization,
    this.website,
  });

  /// Converts the model into FormData
  FormData toFormData() {
    return FormData.fromMap({
      'salutation': salutation,
      'first_name': firstname,
      'last_name': lastname,
      'email': email,
      'mobile_no': contact,
      'organization': organization,
      'website': website,
      //'creation': date,
    });
  }
}
