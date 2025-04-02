import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/create_note_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/create_note_response_model.dart';
import 'package:equatable/equatable.dart';

class CreateNoteUsecase
    implements
        UsecaseWithParams<CreateNoteResponseModel,
            CreateNoteRequestParams> {
  final LeadRepository leadRepository;
  CreateNoteUsecase(this.leadRepository);

  @override
  ResultFuture<CreateNoteResponseModel> call(params) async {
    return await leadRepository
        .createNote(params.createNoteRequestModel);
  }
}

class CreateNoteRequestParams extends Equatable {
  final CreateNoteRequestModel createNoteRequestModel;

  const CreateNoteRequestParams(
      {required this.createNoteRequestModel});

  @override
  List<Object> get props => [createNoteRequestModel];
}
