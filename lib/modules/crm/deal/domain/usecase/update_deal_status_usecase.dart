import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/repositories/deal_repository.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/update_deal_status_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/update_deal_status_response_model.dart';
import 'package:equatable/equatable.dart';

class UpdateDealStatusUsecase
    implements
        UsecaseWithParams<UpdateDealStatusResponse,
            UpdateDealStatusRequestParams> {
  final DealRepository dealRepository;
  UpdateDealStatusUsecase(this.dealRepository);

  @override
  ResultFuture<UpdateDealStatusResponse> call(params) async {
    return await dealRepository
        .updateDealStatus(params.updateDealStatusRequestModel);
  }
}

class UpdateDealStatusRequestParams extends Equatable {
  final UpdateDealStatusRequestModel updateDealStatusRequestModel;

  const UpdateDealStatusRequestParams(
      {required this.updateDealStatusRequestModel});

  @override
  List<Object> get props => [updateDealStatusRequestModel];
}
