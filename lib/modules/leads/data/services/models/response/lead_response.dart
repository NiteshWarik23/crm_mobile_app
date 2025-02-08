sealed class LeadResponse {}

class LeadSuccessResponseModel extends LeadResponse{
  String? name;
  String? email;
  String? contact;
  String? status;
  int? statusColor;

  LeadSuccessResponseModel({this.name, this.email, this.contact, this.status, this.statusColor});

  LeadSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    status = json['status'];
    statusColor = json['status_color'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'contact': contact,
      'status': status,
      'status_color': statusColor,
    };
  }
}




class LeadErrorResponseModel extends LeadResponse{
  String? message;
  String? exception;
  String? excType;
  String? exc;

  LeadErrorResponseModel(
      {this.message, this.exception, this.excType, this.exc});

  LeadErrorResponseModel.fromJson(Map<String, dynamic> json) {
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

