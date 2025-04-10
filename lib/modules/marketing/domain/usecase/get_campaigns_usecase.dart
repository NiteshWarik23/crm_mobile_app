import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/marketing/data/repositories/marketing_repository.dart';
import 'package:crm_mobile_app/modules/marketing/data/services/marketing_api.dart';
import 'package:crm_mobile_app/modules/marketing/data/services/models/response/get_campaigns_response_model.dart';

class GetCampaignsUsecase
    implements FutureUsecaseWithoutParams<GetCampaignsResponseModel> {
  final MarketingRepository marketingRepository;
  GetCampaignsUsecase(this.marketingRepository);

  @override
  ResultFuture<GetCampaignsResponseModel> call() async {
    return await marketingRepository.getCampaigns();
  }
}
