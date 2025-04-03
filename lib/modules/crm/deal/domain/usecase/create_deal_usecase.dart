
import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/repositories/deal_repository.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/create_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/create_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/create_lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/create_lead_response_model.dart';
import 'package:equatable/equatable.dart';

class CreateDealUsecase
    implements
        UsecaseWithParams<CreateDealResponseModel,
            CreateDealRequestParams> {
  final DealRepository dealRepository;
  CreateDealUsecase(this.dealRepository);

  @override
  ResultFuture<CreateDealResponseModel> call(params) async {
    return await dealRepository.createDeal(params.createDealRequestModel);
  }
}

class CreateDealRequestParams extends Equatable {
  final CreateDealRequestModel createDealRequestModel;

  const CreateDealRequestParams(
      {required this.createDealRequestModel});

  @override
  List<Object> get props => [createDealRequestModel];
}
