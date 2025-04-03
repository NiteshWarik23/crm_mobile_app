sealed class SearchDealResponse{}
// class SearchLeadSuccesssResponseModel extends SearchLeadResponse{
//   List<Data>? data;

//   SearchLeadSuccesssResponseModel({this.data});

//   SearchLeadSuccesssResponseModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   String? name;
//   String? owner;
//   String? creation;
//   String? modified;
//   String? modifiedBy;
//   int? docstatus;
//   int? idx;
//   String? organization;
//   String? website;
//   String? territory;
//   String? industry;
//   String? jobTitle;
//   String? source;
//   String? leadOwner;
//   String? facebookPage;
//   String? facebookCampaign;
//   String? facebookAd;
//   String? metaPlatform;
//   String? salutation;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? mobileNo;
//   String? namingSeries;
//   String? leadName;
//   String? middleName;
//   String? gender;
//   String? phone;
//   String? status;
//   String? noOfEmployees;
//   int? annualRevenue;
//   String? image;
//   int? converted;
//   String? sla;
//   String? slaCreation;
//   String? slaStatus;
//   String? communicationStatus;
//   String? responseBy;
//   String? firstResponseTime;
//   String? firstRespondedOn;

//   Data(
//       {this.name,
//       this.owner,
//       this.creation,
//       this.modified,
//       this.modifiedBy,
//       this.docstatus,
//       this.idx,
//       this.organization,
//       this.website,
//       this.territory,
//       this.industry,
//       this.jobTitle,
//       this.source,
//       this.leadOwner,
//       this.facebookPage,
//       this.facebookCampaign,
//       this.facebookAd,
//       this.metaPlatform,
//       this.salutation,
//       this.firstName,
//       this.lastName,
//       this.email,
//       this.mobileNo,
//       this.namingSeries,
//       this.leadName,
//       this.middleName,
//       this.gender,
//       this.phone,
//       this.status,
//       this.noOfEmployees,
//       this.annualRevenue,
//       this.image,
//       this.converted,
//       this.sla,
//       this.slaCreation,
//       this.slaStatus,
//       this.communicationStatus,
//       this.responseBy,
//       this.firstResponseTime,
//       this.firstRespondedOn});

//   Data.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     owner = json['owner'];
//     creation = json['creation'];
//     modified = json['modified'];
//     modifiedBy = json['modified_by'];
//     docstatus = json['docstatus'];
//     idx = json['idx'];
//     organization = json['organization'];
//     website = json['website'];
//     territory = json['territory'];
//     industry = json['industry'];
//     jobTitle = json['job_title'];
//     source = json['source'];
//     leadOwner = json['lead_owner'];
//     facebookPage = json['facebook_page'];
//     facebookCampaign = json['facebook_campaign'];
//     facebookAd = json['facebook_ad'];
//     metaPlatform = json['meta_platform'];
//     salutation = json['salutation'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     mobileNo = json['mobile_no'];
//     namingSeries = json['naming_series'];
//     leadName = json['lead_name'];
//     middleName = json['middle_name'];
//     gender = json['gender'];
//     phone = json['phone'];
//     status = json['status'];
//     noOfEmployees = json['no_of_employees'];
//     annualRevenue = json['annual_revenue'];
//     image = json['image'];
//     converted = json['converted'];
//     sla = json['sla'];
//     slaCreation = json['sla_creation'];
//     slaStatus = json['sla_status'];
//     communicationStatus = json['communication_status'];
//     responseBy = json['response_by'];
//     firstResponseTime = json['first_response_time'];
//     firstRespondedOn = json['first_responded_on'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['owner'] = owner;
//     data['creation'] = creation;
//     data['modified'] = modified;
//     data['modified_by'] = modifiedBy;
//     data['docstatus'] = docstatus;
//     data['idx'] = idx;
//     data['organization'] = organization;
//     data['website'] = website;
//     data['territory'] = territory;
//     data['industry'] = industry;
//     data['job_title'] = jobTitle;
//     data['source'] = source;
//     data['lead_owner'] = leadOwner;
//     data['facebook_page'] = facebookPage;
//     data['facebook_campaign'] = facebookCampaign;
//     data['facebook_ad'] = facebookAd;
//     data['meta_platform'] = metaPlatform;
//     data['salutation'] = salutation;
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['email'] = email;
//     data['mobile_no'] = mobileNo;
//     data['naming_series'] = namingSeries;
//     data['lead_name'] = leadName;
//     data['middle_name'] = middleName;
//     data['gender'] = gender;
//     data['phone'] = phone;
//     data['status'] = status;
//     data['no_of_employees'] = noOfEmployees;
//     data['annual_revenue'] = annualRevenue;
//     data['image'] = image;
//     data['converted'] = converted;
//     data['sla'] = sla;
//     data['sla_creation'] = slaCreation;
//     data['sla_status'] = slaStatus;
//     data['communication_status'] = communicationStatus;
//     data['response_by'] = responseBy;
//     data['first_response_time'] = firstResponseTime;
//     data['first_responded_on'] = firstRespondedOn;
//     return data;
//   }
// }


class SearchDealSuccesssResponseModel extends SearchDealResponse {
  List<SearchDealData>? data;

  SearchDealSuccesssResponseModel({this.data});

  SearchDealSuccesssResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SearchDealData>[];
      json['data'].forEach((v) {
        data!.add(SearchDealData.fromJson(v));
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

class SearchDealData {
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

  SearchDealData(
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

  SearchDealData.fromJson(Map<String, dynamic> json) {
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





class SearchDealErrorResponseModel extends SearchDealResponse {
  String? exception;
  String? excType;
  String? exc;

  SearchDealErrorResponseModel({this.exception, this.excType, this.exc});

  SearchDealErrorResponseModel.fromJson(Map<String, dynamic> json) {
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
