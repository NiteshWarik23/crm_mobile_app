sealed class SearchLeadResponse{}

class SearchLeadSuccesssResponseModel extends SearchLeadResponse {
  List<SearchLeadData>? data;

  SearchLeadSuccesssResponseModel({this.data});

  SearchLeadSuccesssResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SearchLeadData>[];
      json['data'].forEach((v) {
        data!.add(SearchLeadData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchLeadData {
  String? name;
  String? owner;
  String? creation;
  String? facebookCampaign;
  String? metaPlatform;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNo;
  String? status;
  String? communicationStatus;

  SearchLeadData(
      {this.name,
      this.owner,
      this.creation,
      this.facebookCampaign,
      this.metaPlatform,
      this.firstName,
      this.lastName,
      this.email,
      this.mobileNo,
      this.status,
      this.communicationStatus});

  SearchLeadData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    facebookCampaign = json['facebook_campaign'];
    metaPlatform = json['meta_platform'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    status = json['status'];
    communicationStatus = json['communication_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['creation'] = creation;
    data['facebook_campaign'] = facebookCampaign;
    data['meta_platform'] = metaPlatform;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile_no'] = mobileNo;
    data['status'] = status;
    data['communication_status'] = communicationStatus;
    return data;
  }
}





class SearchLeadErrorResponseModel extends SearchLeadResponse {
  String? exception;
  String? excType;
  String? exc;

  SearchLeadErrorResponseModel({this.exception, this.excType, this.exc});

  SearchLeadErrorResponseModel.fromJson(Map<String, dynamic> json) {
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
