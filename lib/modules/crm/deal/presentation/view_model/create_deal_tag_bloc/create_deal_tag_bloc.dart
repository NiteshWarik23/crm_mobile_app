import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/create_deal_tag_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/create_deal_tag_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/create_deal_tag_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/create_deal_tag_bloc/create_deal_tag_event.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/create_deal_tag_bloc/create_deal_tag_state.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/create_tag_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/create_tag_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/create_tag_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_tag_bloc/create_tag_event.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_tag_bloc/create_tag_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateDealTagBloc extends Bloc<CreateDealTagEvent, CreateDealTagState> {
  final CreateDealTagUsecase createDealTagUsecase;
  CreateDealTagBloc(this.createDealTagUsecase) : super(CreateDealTagInitialState()) {
    on<SaveOneCreatedOrSelectedDealTagsEvent>(_onSaveOfCreatedOrSelectedDealTag);
  }

  Future<void> _onSaveOfCreatedOrSelectedDealTag(
      SaveOneCreatedOrSelectedDealTagsEvent event,
      Emitter<CreateDealTagState> emit) async {
    emit(CreateDealTagLoadingState());
    final DataState<CreateDealTagResponseModel> createDealTagResponse =
        await createDealTagUsecase.call(
      CreateDealTagRequestParams(
        createDealTagRequestModel: CreateDealTagRequestModel(
          tag: event.createdOrSelectedDealTags,
          dt: "CRM Deal",
          dn: event.dealIdValue,
        ),
      ),
    );

    if (createDealTagResponse is DataSuccess) {
      final createDealTagSuccessResponseData = createDealTagResponse.data;
      if (createDealTagSuccessResponseData is CreateDealTagSuccessResponseModel) {
        emit(CreateDealTagSuccessState());
      } else if (createDealTagSuccessResponseData is CreateDealTagErrorResponseModel) {
        emit(CreateDealTagFailureState());
      }
    } else if (createDealTagResponse is DataFailed) {
      emit(CreateDealTagFailureState());
    }
  }
}
