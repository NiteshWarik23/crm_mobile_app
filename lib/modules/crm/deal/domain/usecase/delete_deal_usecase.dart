import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/repositories/deal_repository.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/delete_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/delete_deal_response_model.dart';
import 'package:equatable/equatable.dart';

class DeleteDealUsecase
    implements
        UsecaseWithParams<DeleteDealResponse,
            DeleteDealRequestParams> {
  final DealRepository dealRepository;
  DeleteDealUsecase(this.dealRepository);

  @override
  ResultFuture<DeleteDealResponse> call(params) async {
    return await dealRepository
        .deleteDeal(params.deleteDealRequestModel);
  }
}

class DeleteDealRequestParams extends Equatable {
  final DeleteDealRequestModel deleteDealRequestModel;

  const DeleteDealRequestParams(
      {required this.deleteDealRequestModel});

  @override
  List<Object> get props => [deleteDealRequestModel];
}
