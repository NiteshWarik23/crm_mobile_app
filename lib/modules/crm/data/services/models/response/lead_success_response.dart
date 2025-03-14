class LeadsListSuccessResponseModel {
  List<Data>? data;

  LeadsListSuccessResponseModel({this.data});

  LeadsListSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
