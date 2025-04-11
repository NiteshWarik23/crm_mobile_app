import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/marketing/data/services/models/response/campaign_details_response_model.dart';
import 'package:crm_mobile_app/modules/marketing/data/services/models/response/get_campaigns_response_model.dart';

abstract class MarketingRepository {
  ResultFuture<GetCampaignsResponseModel> getCampaigns();
  ResultFuture<CampaignDetailsResponseModel> getCampaignDetails(String campaignId);
}
