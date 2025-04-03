import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/create_deal_note_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/create_deal_note_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/create_deal_note_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/create_deal_note_bloc/create_deal_note_event.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/create_deal_note_bloc/create_deal_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateDealNoteBloc extends Bloc<CreateDealNoteEvent, CreateDealNoteState> {
  final CreateDealNoteUsecase createDealNoteUsecase;
  CreateDealNoteBloc(this.createDealNoteUsecase) : super(CreateDealNoteInitialState()) {
    on<SubmitCreatedDealNoteEvent>(_onSubmitOfCreateDealNote);
  }

  Future<void> _onSubmitOfCreateDealNote(SubmitCreatedDealNoteEvent event, Emitter<CreateDealNoteState> emit) async{
    emit(CreateDealNoteLoadingState());
    final DataState<CreateDealNoteResponseModel> createDealNoteResponse =
        await createDealNoteUsecase.call(
      CreateDealNoteRequestParams(
        createDealNoteRequestModel: CreateDealNoteRequestModel(
        doc: DealDoc(
          doctype: "FCRM Note",
          title: event.title,
          content: "<p>${event.content}</p>",
          referenceDoctype: "CRM Deal",
          referenceDocname: event.dealId,
     
        )
        ),
      ),
    );

    if (createDealNoteResponse is DataSuccess) {
      final createDealNoteSuccessResponseData = createDealNoteResponse.data;
      if (createDealNoteSuccessResponseData is CreateDealNoteSuccessResponseModel) {
        emit(CreateDealNoteSuccessState());
      } else if (createDealNoteSuccessResponseData is CreateDealNoteErrorResponseModel) {
        emit(CreateDealNoteFailureState());
      }
    } else if (createDealNoteResponse is DataFailed) {
      emit(CreateDealNoteFailureState());
    }
  }
}
