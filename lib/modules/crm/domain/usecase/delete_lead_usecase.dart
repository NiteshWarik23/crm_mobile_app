import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/delete_lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/delete_lead_response_model.dart';
import 'package:equatable/equatable.dart';

class DeleteLeadUsecase
    implements
        UsecaseWithParams<DeleteLeadResponse,
            DeleteLeadRequestParams> {
  final LeadRepository leadRepository;
  DeleteLeadUsecase(this.leadRepository);

  @override
  ResultFuture<DeleteLeadResponse> call(params) async {
    return await leadRepository
        .deleteLead(params.deleteLeadRequestModel);
  }
}

class DeleteLeadRequestParams extends Equatable {
  final DeleteLeadRequestModel deleteLeadRequestModel;

  const DeleteLeadRequestParams(
      {required this.deleteLeadRequestModel});

  @override
  List<Object> get props => [deleteLeadRequestModel];
}
