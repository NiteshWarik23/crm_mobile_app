import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/get_notes_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/get_notes_response_model.dart';
import 'package:equatable/equatable.dart';

class GetNotesUsecase
    implements UsecaseWithParams<GetNotesResponseModel, GetNotesRequestParams> {
  final LeadRepository leadRepository;
  GetNotesUsecase(this.leadRepository);

  @override
  ResultFuture<GetNotesResponseModel> call(params) async {
    return await leadRepository.getNotes(params.getNotesRequestModel,params.notesoffsetLimitRequestModel);
  }
}

class GetNotesRequestParams extends Equatable {
  final GetNotesRequestModel getNotesRequestModel;
  final OffsetLimitRequestModel notesoffsetLimitRequestModel;

  const GetNotesRequestParams({
    required this.getNotesRequestModel,
    required this.notesoffsetLimitRequestModel,
  });

  @override
  List<Object> get props => [getNotesRequestModel, notesoffsetLimitRequestModel];
}
