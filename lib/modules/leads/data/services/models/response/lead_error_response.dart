

class LeadErrorResponseModel {
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