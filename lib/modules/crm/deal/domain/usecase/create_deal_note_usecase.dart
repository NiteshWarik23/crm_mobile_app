import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/repositories/deal_repository.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/create_deal_note_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/create_deal_note_response_model.dart';
import 'package:equatable/equatable.dart';

class CreateDealNoteUsecase
    implements
        UsecaseWithParams<CreateDealNoteResponseModel,
            CreateDealNoteRequestParams> {
  final DealRepository dealRepository;
  CreateDealNoteUsecase(this.dealRepository);

  @override
  ResultFuture<CreateDealNoteResponseModel> call(params) async {
    return await dealRepository
        .createDealNote(params.createDealNoteRequestModel);
  }
}

class CreateDealNoteRequestParams extends Equatable {
  final CreateDealNoteRequestModel createDealNoteRequestModel;

  const CreateDealNoteRequestParams(
      {required this.createDealNoteRequestModel});

  @override
  List<Object> get props => [createDealNoteRequestModel];
}
