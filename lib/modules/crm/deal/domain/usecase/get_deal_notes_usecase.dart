import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/repositories/deal_repository.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/get_deal_notes_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/get_deal_notes_response_model.dart';
import 'package:equatable/equatable.dart';

class GetDealNotesUsecase
    implements
        UsecaseWithParams<GetDealNotesResponseModel,
            GetDealNotesRequestParams> {
  final DealRepository dealRepository;
  GetDealNotesUsecase(this.dealRepository);

  @override
  ResultFuture<GetDealNotesResponseModel> call(params) async {
    return await dealRepository.getDealNotes(params.getDealNotesRequestModel,params.dealNotesoffsetLimitRequestModel
);
  }
}

class GetDealNotesRequestParams extends Equatable {
  final GetDealNotesRequestModel getDealNotesRequestModel;
  final OffsetLimitRequestModel dealNotesoffsetLimitRequestModel;

  const GetDealNotesRequestParams({required this.getDealNotesRequestModel,required this.dealNotesoffsetLimitRequestModel
});

  @override
  List<Object> get props => [getDealNotesRequestModel,dealNotesoffsetLimitRequestModel
];
}
