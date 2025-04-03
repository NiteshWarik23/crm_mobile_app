sealed class DeleteDealResponse {}

class DeleteDealSuccessResponseModel extends DeleteDealResponse {
  String? message;

  DeleteDealSuccessResponseModel({this.message});

  DeleteDealSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}

class DeleteDealErrorResponseModel extends DeleteDealResponse {
  String? excType;
  String? sServerMessages;

  DeleteDealErrorResponseModel({this.excType, this.sServerMessages});

  DeleteDealErrorResponseModel.fromJson(Map<String, dynamic> json) {
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
