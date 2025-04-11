import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/marketing/data/repositories/marketing_repository.dart';
import 'package:crm_mobile_app/modules/marketing/data/services/models/response/campaign_details_response_model.dart';
import 'package:equatable/equatable.dart';

class CampaignDetailsUsecase
    implements UsecaseWithParams<CampaignDetailsResponseModel,CampaignDetailsParams> {
  final MarketingRepository marketingRepository;
  CampaignDetailsUsecase(this.marketingRepository);

  @override
  ResultFuture<CampaignDetailsResponseModel> call(params) async {
    return await marketingRepository.getCampaignDetails(params.campaignId);
  }
}

class CampaignDetailsParams extends Equatable{
  final String campaignId;
  const CampaignDetailsParams({required this.campaignId});

  @override
  List<Object> get props => [campaignId];
}
