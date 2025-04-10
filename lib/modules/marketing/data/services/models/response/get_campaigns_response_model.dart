sealed class GetCampaignsResponseModel{}

class GetCampaignsSuccessResponseModel extends GetCampaignsResponseModel{
  List<CampaignData>? campaignData;

  GetCampaignsSuccessResponseModel({this.campaignData});

  GetCampaignsSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      campaignData = <CampaignData>[];
      json['data'].forEach((v) {
        campaignData!.add(CampaignData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> campaignData = <String, dynamic>{};
    if (this.campaignData != null) {
      campaignData['data'] = this.campaignData!.map((v) => v.toJson()).toList();
    }
    return campaignData;
  }
}

class CampaignData {
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

  CampaignData(
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
      this.buyingType});

  CampaignData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}


class GetCampaignsErrorResponseModel extends GetCampaignsResponseModel {
  String? errorMessage;

  GetCampaignsErrorResponseModel({this.errorMessage});

  GetCampaignsErrorResponseModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_message'] = errorMessage;
    return data;
  }
}
