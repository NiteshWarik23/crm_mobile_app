import 'package:bloc/bloc.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/create_lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/create_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/domain/usecase/create_lead_usecase.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/create_lead_bloc/create_lead_event.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/create_lead_bloc/create_lead_state.dart';

class CreateLeadFormBloc
    extends Bloc<CreateLeadFormEvent, CreateLeadFormState> {
  final CreateLeadUsecase createLeadUsecase;
  CreateLeadFormBloc(this.createLeadUsecase) : super(CreateLeadFormUpdate()) {
    on<SubmitLeadForm>(_onSubmitLeadForm);
    on<UpdateFormField>(_onUpdateFormField);
  }

  String salutation = '';
  String firstname = '';
  String lastname = '';
  String email = '';
  String contact = '';
  String organization = '';
  String website = '';
  String date = '';

  void _onUpdateFormField(
      UpdateFormField event, Emitter<CreateLeadFormState> emit) {
    if (state is CreateLeadFormUpdate) {
      final currentState = state as CreateLeadFormUpdate;
      emit(currentState.copyWith(
        salutation: event.salutation,
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        contact: event.contact,
        organization: event.organization,
        website: event.website,
        date: event.date,
      ));
      salutation = event.salutation.toString();
      firstname = event.firstName.toString();
      lastname = event.lastName.toString();
      email = event.email.toString();
      contact = event.contact.toString();
      organization = event.organization.toString();
      website = event.website.toString();
      date = event.date.toString();
    }
  }

  void _onSubmitLeadForm(
      SubmitLeadForm event, Emitter<CreateLeadFormState> emit) async {
    emit(LeadFormSubmitting());

    final DataState<CreateLeadResponseModel> createLeadResponse =
        await createLeadUsecase.call(
      CreateLeadRequestParams(
        createLeadRequestModel: CreateLeadRequestModel(
          salutation: salutation,
          firstname: firstname,
          lastname: lastname,
          email: email,
          contact: contact,
          organization: organization,
          website: website,
          date: date,
        ),
      ),
    );

    if (createLeadResponse is DataSuccess) {
      final createLeadSuccessResponseData = createLeadResponse.data;
      if (createLeadSuccessResponseData is CreateLeadSuccessResponseModel) {
        emit(LeadFormSuccess('Lead Created Successfully'));
      } else if (createLeadSuccessResponseData
          is CreateLeadErrorResponseModel) {
        emit(LeadFormFailure(' Lead Creation Failed'));
      }
    } else if (createLeadResponse is DataFailed) {
      emit(LeadFormFailure(' Lead Creation Failed'));
    }
  }
}
