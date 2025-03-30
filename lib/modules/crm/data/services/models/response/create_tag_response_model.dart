sealed class CreateTagResponseModel {}

class CreateTagErrorResponseModel extends CreateTagResponseModel {
  String? excType;
  String? sServerMessages;

  CreateTagErrorResponseModel({this.excType, this.sServerMessages});

  CreateTagErrorResponseModel.fromJson(Map<String, dynamic> json) {
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

class CreateTagSuccessResponseModel extends CreateTagResponseModel{
  String? message;

  CreateTagSuccessResponseModel({this.message});

  CreateTagSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}

