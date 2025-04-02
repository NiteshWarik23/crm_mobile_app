import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/lead_response.dart';
import 'package:equatable/equatable.dart';

class LeadUsecase
    implements UsecaseWithParams<LeadResponse, LeadDataOffsetLimitRequestParams> {
  final LeadRepository leadRepository;
  LeadUsecase(this.leadRepository);

  @override
  ResultFuture<LeadResponse> call(params) async {
    return await leadRepository.getLeads(params.offsetLimitRequestModel);
  }
}

class LeadDataOffsetLimitRequestParams extends Equatable {
  final  OffsetLimitRequestModel offsetLimitRequestModel;

  const LeadDataOffsetLimitRequestParams({required this.offsetLimitRequestModel});

  @override
  List<Object> get props => [offsetLimitRequestModel];
}
