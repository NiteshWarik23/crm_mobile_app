import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/convert_lead_to_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/convert_lead_to_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/domain/usecase/convert_lead_to_deal_usecase.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/convert_to_deal_bloc/convert_to_deal_event.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/convert_to_deal_bloc/convert_to_deal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertLeadToDealBloc
    extends Bloc<ConvertToDealEvent, ConvertToDealState> {
  final ConvertLeadToDealUsecase convertLeadToDealUsecase;

  ConvertLeadToDealBloc(
    this.convertLeadToDealUsecase,
  ) : super(ConvertToDealInitialState()) {
    on<ConvertLeadToDealNewEvent>(convertLeadToDeal);
  }

  Future<void> convertLeadToDeal(
      ConvertLeadToDealNewEvent event, Emitter<ConvertToDealState> emit) async {
    emit(ConvertToDealLoadingState());
    print("Loading 1");

    final DataState<ConvertLeadToDealResponse> convertLeadToDealResponse =
        await convertLeadToDealUsecase.call(
      ConvertLeadToDealRequestParams(
        convertLeadToDealRequestModel: ConvertLeadToDealRequestModel(
          lead: event.leadID,
        ),
      ),
    );

    if (convertLeadToDealResponse is DataSuccess) {
      final convertLeadToDealSuccessResponseData =
          convertLeadToDealResponse.data;
      if (convertLeadToDealSuccessResponseData
          is ConvertLeadToDealResponseModel) {
       

        emit(ConvertToDealStateSuccessState());
         print("Success 1 --->");
      } else if (convertLeadToDealSuccessResponseData
          is ConvertLeadToDealErrorResponseModel) {
        print("Failure 1");

        emit(ConvertToDealFailureState());
      }
    } else if (convertLeadToDealResponse is DataFailed) {
      print("Failure 2");

      emit(ConvertToDealFailureState());
    }
  }
}
