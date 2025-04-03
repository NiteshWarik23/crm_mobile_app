import 'package:bloc/bloc.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/create_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/create_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/create_deal_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/create_deal_bloc/create_deal_event.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/create_deal_bloc/create_deal_state.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/create_lead_response_model.dart';

class CreateDealFormBloc
    extends Bloc<CreateDealFormEvent, CreateDealFormUpdate> {
  final CreateDealUsecase createDealUsecase;
  CreateDealFormBloc(this.createDealUsecase) : super(CreateDealFormUpdate()) {
    on<SubmitDealForm>(_onSubmitLeadForm);
    on<UpdateDealFormField>(_onUpdateFormField);
  }

  void _onUpdateFormField(
      UpdateDealFormField event, Emitter<CreateDealFormUpdate> emit) {
    emit(state.copyWith(
      salutation: event.salutation ?? state.salutation,
      firstName: event.firstName ?? state.firstName,
      lastName: event.lastName ?? state.lastName,
      email: event.email ?? state.email,
      contact: event.contact ?? state.contact,
      organization: event.organization ?? state.organization,
      website: event.website ?? state.website,
      date: event.date ?? state.date,
    ));
  }

  void _onSubmitLeadForm(
      SubmitDealForm event, Emitter<CreateDealFormUpdate> emit) async {
    emit(state.copyWith(createDealStatus: CreateDealStatus.createDealLoading));
    final DataState<CreateDealResponseModel> createDealResponse =
        await createDealUsecase.call(
      CreateDealRequestParams(
        createDealRequestModel: CreateDealRequestModel(
          salutation: state.salutation,
          firstname: state.firstName,
          lastname: state.lastName,
          email: state.email,
          contact: state.contact,
          organization: state.organization,
          website: state.website,
        ),
      ),
    );

    if (createDealResponse is DataSuccess) {
      final createDealSuccessResponseData = createDealResponse.data;
      if (createDealSuccessResponseData is CreateDealSuccessResponseModel) {
        emit(state.copyWith(
            createDealStatus: CreateDealStatus.createDealSuccess));
        //emit(LeadFormSuccess('Lead Created Successfully'));
      } else if (createDealSuccessResponseData
          is CreateLeadErrorResponseModel) {
        emit(state.copyWith(
            createDealStatus: CreateDealStatus.createDealFailure));

        // emit(LeadFormFailure(' Lead Creation Failed'));
      }
    } else if (createDealResponse is DataFailed) {
      emit(
          state.copyWith(createDealStatus: CreateDealStatus.createDealFailure));

      //emit(LeadFormFailure(' Lead Creation Failed'));
    }
  }
}
