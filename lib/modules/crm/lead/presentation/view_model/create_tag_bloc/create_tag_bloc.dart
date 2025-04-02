import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/create_tag_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/create_tag_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/create_tag_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_tag_bloc/create_tag_event.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_tag_bloc/create_tag_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTagBloc extends Bloc<CreateTagEvent, CreateTagState> {
  final CreateTagUsecase createTagUsecase;
  CreateTagBloc(this.createTagUsecase) : super(CreateTagInitialState()) {
    on<SaveOneCreatedOrSelectedTagsEvent>(_onSaveOfCreatedOrSelectedTag);
  }

  Future<void> _onSaveOfCreatedOrSelectedTag(
      SaveOneCreatedOrSelectedTagsEvent event,
      Emitter<CreateTagState> emit) async {
    emit(CreateTagLoadingState());
    final DataState<CreateTagResponseModel> createTagResponse =
        await createTagUsecase.call(
      CreateTagRequestParams(
        createTagRequestModel: CreateTagRequestModel(
          tag: event.createdOrSelectedTags,
          dt: "CRM Lead",
          dn: event.leadIdValue,
        ),
      ),
    );

    if (createTagResponse is DataSuccess) {
      final createTagSuccessResponseData = createTagResponse.data;
      if (createTagSuccessResponseData is CreateTagSuccessResponseModel) {
        emit(CreateTagSuccessState());
      } else if (createTagSuccessResponseData is CreateTagErrorResponseModel) {
        emit(CreateTagFailureState());
      }
    } else if (createTagResponse is DataFailed) {
      emit(CreateTagFailureState());
    }
  }
}
