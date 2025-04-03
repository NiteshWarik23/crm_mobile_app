sealed class CreateDealTagResponseModel {}

class CreateDealTagErrorResponseModel extends CreateDealTagResponseModel {
  String? excType;
  String? sServerMessages;

  CreateDealTagErrorResponseModel({this.excType, this.sServerMessages});

  CreateDealTagErrorResponseModel.fromJson(Map<String, dynamic> json) {
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

class CreateDealTagSuccessResponseModel extends CreateDealTagResponseModel{
  String? message;

  CreateDealTagSuccessResponseModel({this.message});

  CreateDealTagSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}

