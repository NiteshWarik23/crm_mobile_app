sealed class DeleteLeadResponse {}

class DeleteLeadSuccessResponseModel extends DeleteLeadResponse {
  String? message;

  DeleteLeadSuccessResponseModel({this.message});

  DeleteLeadSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}

class DeleteLeadErrorResponseModel extends DeleteLeadResponse {
  String? excType;
  String? sServerMessages;

  DeleteLeadErrorResponseModel({this.excType, this.sServerMessages});

  DeleteLeadErrorResponseModel.fromJson(Map<String, dynamic> json) {
    excType = json['exc_type'];
    sServerMessages = json['_server_messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exc_type'] = excType;
    data['_server_messages'] = sServerMessages;
    return data;
  }
}
