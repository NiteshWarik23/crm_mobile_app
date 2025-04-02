// import 'package:crm_mobile_app/core/usecase/usecase.dart';
// import 'package:crm_mobile_app/core/utils/type_def.dart';
// import 'package:crm_mobile_app/modules/crm/lead/data/repositories/lead_repository.dart';
// import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/get_notes_request_model.dart';
// import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/get_notes_response_model.dart';
// import 'package:equatable/equatable.dart';

// class GetNotesUsecase
//     implements
//         UsecaseWithParams<GetNotesResponseModel, GetNotesRequestParams> {
//   final LeadRepository leadRepository;
//   GetNotesUsecase(this.leadRepository);

//   @override
//   ResultFuture<GetNotesResponseModel> call(params) async {
//     return await leadRepository.getNotes(params.getNotesRequestModel);
//   }
// }

// class GetNotesRequestParams extends Equatable {
//   final GetNotesRequestModel getNotesRequestModel;

//   const GetNotesRequestParams(
//       {required this.getNotesRequestModel});

//   @override
//   List<Object> get props => [getNotesRequestModel];
// }
