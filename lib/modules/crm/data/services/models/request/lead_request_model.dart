import 'dart:convert';

class LeadsQueryParamsRequestModel {
  List<String>? fields;

  LeadsQueryParamsRequestModel({this.fields});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fields'] = fields;
    return data;
  }
}

class OffsetLimitRequestModel {
  int? limitStart;
  int? limit;

  OffsetLimitRequestModel({required this.limitStart,required this.limit});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit_start'] = limitStart;
    data['limit'] = limit;
    return data;
  }
}

class CRMLeadQueryParams {
  final List<String> fields;

  CRMLeadQueryParams({required this.fields});

  // Convert the model to a Map for query parameters
  Map<String, String> toQueryParams() {
    return {
      "fields": jsonEncode(fields), // Convert the list to a JSON-encoded string
    };
  }
}
