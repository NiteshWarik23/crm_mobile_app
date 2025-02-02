sealed class LoginResponse {}

class LoginSuccessResponseModel extends LoginResponse{
  String? message;
  String? homePage;
  String? fullName;

  LoginSuccessResponseModel({this.message, this.homePage, this.fullName});

  LoginSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    homePage = json['home_page'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['home_page'] = homePage;
    data['full_name'] = fullName;
    return data;
  }
}



class LoginErrorResponseModel extends LoginResponse{
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

