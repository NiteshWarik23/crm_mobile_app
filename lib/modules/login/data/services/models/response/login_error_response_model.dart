import 'package:crm_mobile_app/modules/login/data/services/models/response/login_response.dart';

class LoginErrorResponseModel {
  String? message;
  String? exception;
  String? excType; 
  String? exc;

  LoginErrorResponseModel(
      {this.message, this.exception, this.excType, this.exc});

  LoginErrorResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    exception = json['exception'];
    excType = json['exc_type'];
    exc = json['exc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['exception'] = exception;
    data['exc_type'] = excType;
    data['exc'] = exc;
    return data;
  }
}
