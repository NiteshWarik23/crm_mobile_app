sealed class CreateDealResponseModel {}

class CreateDealSuccessResponseModel extends CreateDealResponseModel{
  CreateLeadData? data;

  CreateDealSuccessResponseModel({this.data});

  CreateDealSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CreateLeadData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CreateLeadData {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? firstName;
  String? namingSeries;
  String? leadName;
  String? status;
  String? noOfEmployees;
  int? annualRevenue;
  int? converted;
  String? slaStatus;
  String? communicationStatus;
  String? doctype;
  List<StatusChangeLog>? statusChangeLog;

  CreateLeadData(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.firstName,
      this.namingSeries,
      this.leadName,
      this.status,
      this.noOfEmployees,
      this.annualRevenue,
      this.converted,
      this.slaStatus,
      this.communicationStatus,
      this.doctype,
      this.statusChangeLog});

  CreateLeadData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    firstName = json['first_name'];
    namingSeries = json['naming_series'];
    leadName = json['lead_name'];
    status = json['status'];
    noOfEmployees = json['no_of_employees'];
    annualRevenue = json['annual_revenue'];
    converted = json['converted'];
    slaStatus = json['sla_status'];
    communicationStatus = json['communication_status'];
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
    data['first_name'] = firstName;
    data['naming_series'] = namingSeries;
    data['lead_name'] = leadName;
    data['status'] = status;
    data['no_of_employees'] = noOfEmployees;
    data['annual_revenue'] = annualRevenue;
    data['converted'] = converted;
    data['sla_status'] = slaStatus;
    data['communication_status'] = communicationStatus;
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
    data['log_owner'] = logOwner;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    return data;
  }
}



// Create Lead Error Response Model
class CreateDealErrorResponseModel extends CreateDealResponseModel {
  String? exception;
  String? excType;
  String? exc;

  CreateDealErrorResponseModel({this.exception, this.excType, this.exc});

  CreateDealErrorResponseModel.fromJson(Map<String, dynamic> json) {
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
