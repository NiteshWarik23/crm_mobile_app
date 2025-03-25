import 'package:dio/dio.dart';

class CreateLeadRequestModel {
 

 final String salutation;
 final String firstname;
 final String lastname ;
 final String email ;
 final String contact ;
 final String organization ;
 final String website ;
final  String date;

  CreateLeadRequestModel({
    required this.salutation,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.contact,
    required this.organization,
    required this.website,
    required this.date,
  });

  /// Converts the model into FormData
  FormData toFormData() {
    return FormData.fromMap({
      'salutation' : salutation,
      'first_name': firstname,
      'last_name': lastname,
      'email': email,
      'mobile_no': contact,
      'organization': organization,
      'website': website,
      'creation' : date,
    });
  }
}
