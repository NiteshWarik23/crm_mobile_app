sealed class CampaignDetailsResponseModel{}

class CampaignDetailsSuccessResponseModel extends CampaignDetailsResponseModel {
  CampaignDetailsData? data;

  CampaignDetailsSuccessResponseModel({this.data});

  CampaignDetailsSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CampaignDetailsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CampaignDetailsData {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? campaignId;
  String? campaignStatus;
  String? campaignObjective;
  String? facebookPage;
  String? campaignName;
  String? adAccount;
  String? buyingType;
  String? doctype;
  List<Insights>? insights;

  CampaignDetailsData(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.campaignId,
      this.campaignStatus,
      this.campaignObjective,
      this.facebookPage,
      this.campaignName,
      this.adAccount,
      this.buyingType,
      this.doctype,
      this.insights});

  CampaignDetailsData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    campaignId = json['campaign_id'];
    campaignStatus = json['campaign_status'];
    campaignObjective = json['campaign_objective'];
    facebookPage = json['facebook_page'];
    campaignName = json['campaign_name'];
    adAccount = json['ad_account'];
    buyingType = json['buying_type'];
    doctype = json['doctype'];
    if (json['insights'] != null) {
      insights = <Insights>[];
      json['insights'].forEach((v) {
        insights!.add(Insights.fromJson(v));
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
    data['campaign_id'] = campaignId;
    data['campaign_status'] = campaignStatus;
    data['campaign_objective'] = campaignObjective;
    data['facebook_page'] = facebookPage;
    data['campaign_name'] = campaignName;
    data['ad_account'] = adAccount;
    data['buying_type'] = buyingType;
    data['doctype'] = doctype;
    if (insights != null) {
      data['insights'] = insights!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Insights {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? metric;
  String? value;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  Insights(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.metric,
      this.value,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  Insights.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    metric = json['metric'];
    value = json['value'];
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
    data['metric'] = metric;
    data['value'] = value;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    return data;
  }
}



class CampaignsDetailsErrorResponseModel extends CampaignDetailsResponseModel {
  String? errorMessage;

  CampaignsDetailsErrorResponseModel({this.errorMessage});

  CampaignsDetailsErrorResponseModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_message'] = errorMessage;
    return data;
  }
}
