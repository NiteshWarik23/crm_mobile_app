
import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/create_lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/create_lead_response_model.dart';
import 'package:equatable/equatable.dart';

class CreateLeadUsecase
    implements
        UsecaseWithParams<CreateLeadResponseModel,
            CreateLeadRequestParams> {
  final LeadRepository leadRepository;
  CreateLeadUsecase(this.leadRepository);

  @override
  ResultFuture<CreateLeadResponseModel> call(params) async {
    return await leadRepository.createLead(params.createLeadRequestModel);
  }
}

class CreateLeadRequestParams extends Equatable {
  final CreateLeadRequestModel createLeadRequestModel;

  const CreateLeadRequestParams(
      {required this.createLeadRequestModel});

  @override
  List<Object> get props => [createLeadRequestModel];
}
