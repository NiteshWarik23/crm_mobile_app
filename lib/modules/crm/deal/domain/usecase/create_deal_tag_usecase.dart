import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/repositories/deal_repository.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/create_deal_tag_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/create_deal_tag_response_model.dart';
import 'package:equatable/equatable.dart';

class CreateDealTagUsecase
    implements
        UsecaseWithParams<CreateDealTagResponseModel, CreateDealTagRequestParams> {
  final DealRepository dealRepository;
  CreateDealTagUsecase(this.dealRepository);

  @override
  ResultFuture<CreateDealTagResponseModel> call(params) async {
    return await dealRepository.createDealTag(params.createDealTagRequestModel);
  }
}

class CreateDealTagRequestParams extends Equatable {
  final CreateDealTagRequestModel createDealTagRequestModel;

  const CreateDealTagRequestParams({required this.createDealTagRequestModel});

  @override
  List<Object> get props => [createDealTagRequestModel];
}
