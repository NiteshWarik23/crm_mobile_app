sealed class ConvertLeadToDealResponse {}

class ConvertLeadToDealResponseModel extends ConvertLeadToDealResponse {
  String? message;

  ConvertLeadToDealResponseModel({this.message});

  ConvertLeadToDealResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}

class ConvertLeadToDealErrorResponseModel extends ConvertLeadToDealResponse {
  String? excType;
  String? sServerMessages;

  ConvertLeadToDealErrorResponseModel({this.excType, this.sServerMessages});

  ConvertLeadToDealErrorResponseModel.fromJson(Map<String, dynamic> json) {
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
