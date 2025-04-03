
sealed class UpdateDealStatusResponse {}


class UpdateDealStatusResponseModel extends UpdateDealStatusResponse {
  Message? message;

  UpdateDealStatusResponseModel({this.message});

  UpdateDealStatusResponseModel.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? organization;
  String? website;
  String? territory;
  String? industry;
  String? jobTitle;
  String? source;
  String? leadOwner;
  String? facebookPage;
  String? facebookCampaign;
  String? facebookAd;
  String? metaPlatform;
  String? salutation;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNo;
  String? namingSeries;
  String? leadName;
  String? middleName;
  String? gender;
  String? phone;
  String? status;
  String? noOfEmployees;
  double? annualRevenue;
  String? image;
  int? converted;
  String? sla;
  String? slaCreation;
  String? slaStatus;
  String? communicationStatus;
  String? responseBy;
  String? firstResponseTime;
  String? firstRespondedOn;
  String? doctype;
  List<StatusChangeLog>? statusChangeLog;

  Message(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.organization,
      this.website,
      this.territory,
      this.industry,
      this.jobTitle,
      this.source,
      this.leadOwner,
      this.facebookPage,
      this.facebookCampaign,
      this.facebookAd,
      this.metaPlatform,
      this.salutation,
      this.firstName,
      this.lastName,
      this.email,
      this.mobileNo,
      this.namingSeries,
      this.leadName,
      this.middleName,
      this.gender,
      this.phone,
      this.status,
      this.noOfEmployees,
      this.annualRevenue,
      this.image,
      this.converted,
      this.sla,
      this.slaCreation,
      this.slaStatus,
      this.communicationStatus,
      this.responseBy,
      this.firstResponseTime,
      this.firstRespondedOn,
      this.doctype,
      this.statusChangeLog});

  Message.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    organization = json['organization'];
    website = json['website'];
    territory = json['territory'];
    industry = json['industry'];
    jobTitle = json['job_title'];
    source = json['source'];
    leadOwner = json['lead_owner'];
    facebookPage = json['facebook_page'];
    facebookCampaign = json['facebook_campaign'];
    facebookAd = json['facebook_ad'];
    metaPlatform = json['meta_platform'];
    salutation = json['salutation'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    namingSeries = json['naming_series'];
    leadName = json['lead_name'];
    middleName = json['middle_name'];
    gender = json['gender'];
    phone = json['phone'];
    status = json['status'];
    noOfEmployees = json['no_of_employees'];
    annualRevenue = json['annual_revenue'];
    image = json['image'];
    converted = json['converted'];
    sla = json['sla'];
    slaCreation = json['sla_creation'];
    slaStatus = json['sla_status'];
    communicationStatus = json['communication_status'];
    responseBy = json['response_by'];
    firstResponseTime = json['first_response_time'];
    firstRespondedOn = json['first_responded_on'];
    doctype = json['doctype'];
    if (json['status_change_log'] != null) {
      statusChangeLog = <StatusChangeLog>[];
      json['status_change_log'].forEach((v) {
        statusChangeLog!.add(StatusChangeLog.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['creation'] = creation;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['organization'] = organization;
    data['website'] = website;
    data['territory'] = territory;
    data['industry'] = industry;
    data['job_title'] = jobTitle;
    data['source'] = source;
    data['lead_owner'] = leadOwner;
    data['facebook_page'] = facebookPage;
    data['facebook_campaign'] = facebookCampaign;
    data['facebook_ad'] = facebookAd;
    data['meta_platform'] = metaPlatform;
    data['salutation'] = salutation;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile_no'] = mobileNo;
    data['naming_series'] = namingSeries;
    data['lead_name'] = leadName;
    data['middle_name'] = middleName;
    data['gender'] = gender;
    data['phone'] = phone;
    data['status'] = status;
    data['no_of_employees'] = noOfEmployees;
    data['annual_revenue'] = annualRevenue;
    data['image'] = image;
    data['converted'] = converted;
    data['sla'] = sla;
    data['sla_creation'] = slaCreation;
    data['sla_status'] = slaStatus;
    data['communication_status'] = communicationStatus;
    data['response_by'] = responseBy;
    data['first_response_time'] = firstResponseTime;
    data['first_responded_on'] = firstRespondedOn;
    data['doctype'] = doctype;
    if (statusChangeLog != null) {
      data['status_change_log'] =
          statusChangeLog!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusChangeLog {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? from;
  String? to;
  String? fromDate;
  String? toDate;
  double? duration;
  String? lastStatusChangeLog;
  String? logOwner;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  StatusChangeLog(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.from,
      this.to,
      this.fromDate,
      this.toDate,
      this.duration,
      this.lastStatusChangeLog,
      this.logOwner,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  StatusChangeLog.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    from = json['from'];
    to = json['to'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    duration = json['duration'];
    lastStatusChangeLog = json['last_status_change_log'];
    logOwner = json['log_owner'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['creation'] = creation;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['from'] = from;
    data['to'] = to;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['duration'] = duration;
    data['last_status_change_log'] = lastStatusChangeLog;
    data['log_owner'] = logOwner;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    return data;
  }
}




class UpdateDealStatusErrorResponseModel extends UpdateDealStatusResponse {
  String? excType;
  String? sServerMessages;

  UpdateDealStatusErrorResponseModel({this.excType, this.sServerMessages});

  UpdateDealStatusErrorResponseModel.fromJson(Map<String, dynamic> json) {
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
