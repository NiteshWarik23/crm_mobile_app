import 'package:bloc/bloc.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/create_lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/create_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/create_lead_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_lead_bloc/create_lead_event.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_lead_bloc/create_lead_state.dart';

class CreateLeadFormBloc
    extends Bloc<CreateLeadFormEvent, CreateLeadFormUpdate> {
  final CreateLeadUsecase createLeadUsecase;
  CreateLeadFormBloc(this.createLeadUsecase) : super(CreateLeadFormUpdate()) {
    on<SubmitLeadForm>(_onSubmitLeadForm);
    on<UpdateFormField>(_onUpdateFormField);
  }

  void _onUpdateFormField(
      UpdateFormField event, Emitter<CreateLeadFormUpdate> emit) {
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
      SubmitLeadForm event, Emitter<CreateLeadFormUpdate> emit) async {
    emit(state.copyWith(createLeadStatus: CreateLeadStatus.createLeadLoading));
    final DataState<CreateLeadResponseModel> createLeadResponse =
        await createLeadUsecase.call(
      CreateLeadRequestParams(
        createLeadRequestModel: CreateLeadRequestModel(
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

    if (createLeadResponse is DataSuccess) {
      final createLeadSuccessResponseData = createLeadResponse.data;
      if (createLeadSuccessResponseData is CreateLeadSuccessResponseModel) {
        emit(state.copyWith(
            createLeadStatus: CreateLeadStatus.createLeadSuccess));
        //emit(LeadFormSuccess('Lead Created Successfully'));
      } else if (createLeadSuccessResponseData
          is CreateLeadErrorResponseModel) {
        emit(state.copyWith(
            createLeadStatus: CreateLeadStatus.createLeadFailure));

        // emit(LeadFormFailure(' Lead Creation Failed'));
      }
    } else if (createLeadResponse is DataFailed) {
      emit(
          state.copyWith(createLeadStatus: CreateLeadStatus.createLeadFailure));

      //emit(LeadFormFailure(' Lead Creation Failed'));
    }
  }
}
