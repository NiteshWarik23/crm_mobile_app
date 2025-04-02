class ConvertLeadToDealRequestModel {
  String? lead;

  ConvertLeadToDealRequestModel({this.lead});

  ConvertLeadToDealRequestModel.fromJson(Map<String, dynamic> json) {
    lead = json['lead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lead'] = lead;
    return data;
  }
}
