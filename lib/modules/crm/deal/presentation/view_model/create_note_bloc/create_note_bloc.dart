import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/create_note_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/create_note_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/create_note_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_note_bloc/create_note_event.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_note_bloc/create_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNoteBloc extends Bloc<CreateNoteEvent, CreateNoteState> {
  final CreateNoteUsecase createNoteUsecase;
  CreateNoteBloc(this.createNoteUsecase) : super(CreateNoteInitialState()) {
    on<SubmitCreatedNoteEvent>(_onSubmitOfCreateNote);
  }

  Future<void> _onSubmitOfCreateNote(SubmitCreatedNoteEvent event, Emitter<CreateNoteState> emit) async{
    emit(CreateNoteLoadingState());
    final DataState<CreateNoteResponseModel> createNoteResponse =
        await createNoteUsecase.call(
      CreateNoteRequestParams(
        createNoteRequestModel: CreateNoteRequestModel(
        doc: Doc(
          doctype: "FCRM Note",
          title: event.title,
          content: "<p>${event.content}</p>",
          referenceDoctype: "CRM Lead",
          referenceDocname: event.leadId,
     
        )
        ),
      ),
    );

    if (createNoteResponse is DataSuccess) {
      final createNoteSuccessResponseData = createNoteResponse.data;
      if (createNoteSuccessResponseData is CreateNoteSuccessResponseModel) {
        emit(CreateNoteSuccessState());
      } else if (createNoteSuccessResponseData is CreateNoteErrorResponseModel) {
        emit(CreateNoteFailureState());
      }
    } else if (createNoteResponse is DataFailed) {
      emit(CreateNoteFailureState());
    }
  }
}
