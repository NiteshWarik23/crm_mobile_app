import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/update_lead_status_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/update_lead_status_response_model.dart';
import 'package:equatable/equatable.dart';

class UpdateLeadStatusUsecase
    implements
        UsecaseWithParams<UpdateLeadStatusResponse,
            UpdateLeadStatusRequestParams> {
  final LeadRepository leadRepository;
  UpdateLeadStatusUsecase(this.leadRepository);

  @override
  ResultFuture<UpdateLeadStatusResponse> call(params) async {
    return await leadRepository
        .updateLeadStatus(params.updateLeadStatusRequestModel);
  }
}

class UpdateLeadStatusRequestParams extends Equatable {
  final UpdateLeadStatusRequestModel updateLeadStatusRequestModel;

  const UpdateLeadStatusRequestParams(
      {required this.updateLeadStatusRequestModel});

  @override
  List<Object> get props => [updateLeadStatusRequestModel];
}
