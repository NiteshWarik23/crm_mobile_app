
sealed class LeadResponse{}

class LeadsListSuccessResponseModel extends LeadResponse{
  List<LeadData>? data;

  LeadsListSuccessResponseModel({this.data});

  LeadsListSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LeadData>[];
      json['data'].forEach((v) {
        data!.add(LeadData.fromJson(v));
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

class LeadData {
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

  LeadData(
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

  LeadData.fromJson(Map<String, dynamic> json) {
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



// Lead Error Response Model
class LeadsListErrorResponseModel extends LeadResponse{
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
