import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/repositories/deal_repository.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/deal_response.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/lead_response.dart';
import 'package:equatable/equatable.dart';

class DealUsecase
    implements UsecaseWithParams<DealResponse, DealDataOffsetLimitRequestParams> {
  final DealRepository dealRepository;
  DealUsecase(this.dealRepository);

  @override
  ResultFuture<DealResponse> call(params) async {
    return await dealRepository.getDeals(params.offsetLimitRequestModel);
  }
}

class DealDataOffsetLimitRequestParams extends Equatable {
  final  OffsetLimitRequestModel offsetLimitRequestModel;

  const DealDataOffsetLimitRequestParams({required this.offsetLimitRequestModel});

  @override
  List<Object> get props => [offsetLimitRequestModel];
}
