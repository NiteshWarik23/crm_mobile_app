class LeadsListErrorResponseModel {
  String? exception;
  String? excType;
  String? exc;

  LeadsListErrorResponseModel({this.exception, this.excType, this.exc});

  LeadsListErrorResponseModel.fromJson(Map<String, dynamic> json) {
    exception = json['exception'];
    excType = json['exc_type'];
    exc = json['exc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exception'] = exception;
    data['exc_type'] = excType;
    data['exc'] = exc;
    return data;
  }
}
