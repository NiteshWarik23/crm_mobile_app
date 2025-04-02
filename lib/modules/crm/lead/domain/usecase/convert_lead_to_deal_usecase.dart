import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/convert_lead_to_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/convert_lead_to_deal_response_model.dart';
import 'package:equatable/equatable.dart';

class ConvertLeadToDealUsecase
    implements
        UsecaseWithParams<ConvertLeadToDealResponse, ConvertLeadToDealRequestParams> {
  final LeadRepository leadRepository;
  ConvertLeadToDealUsecase(this.leadRepository);

  @override
  ResultFuture<ConvertLeadToDealResponse> call(params) async {
    return await leadRepository.convertLeadToDeal(params.convertLeadToDealRequestModel);
  }
}

class ConvertLeadToDealRequestParams extends Equatable {
  final ConvertLeadToDealRequestModel convertLeadToDealRequestModel;

  const ConvertLeadToDealRequestParams(
      {required this.convertLeadToDealRequestModel});

  @override
  List<Object> get props => [convertLeadToDealRequestModel];
}
