import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/create_lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/create_tag_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/create_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/create_tag_response_model.dart';
import 'package:equatable/equatable.dart';

class CreateTagUsecase
    implements
        UsecaseWithParams<CreateTagResponseModel, CreateTagRequestParams> {
  final LeadRepository leadRepository;
  CreateTagUsecase(this.leadRepository);

  @override
  ResultFuture<CreateTagResponseModel> call(params) async {
    return await leadRepository.createLeadTag(params.createTagRequestModel);
  }
}

class CreateTagRequestParams extends Equatable {
  final CreateTagRequestModel createTagRequestModel;

  const CreateTagRequestParams({required this.createTagRequestModel});

  @override
  List<Object> get props => [createTagRequestModel];
}
