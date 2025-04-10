import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/marketing/data/services/models/response/get_campaigns_response_model.dart';
import 'package:crm_mobile_app/modules/marketing/domain/usecase/get_campaigns_usecase.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view_model/get_campaigns_bloc/get_campaigns_event.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view_model/get_campaigns_bloc/get_campaigns_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCampaignsBloc extends Bloc<GetCampaignsEvent, GetCampaignsState> {
  final GetCampaignsUsecase getCampaignsUsecase;
  GetCampaignsBloc(this.getCampaignsUsecase)
      : super(GetCampaignsInitialState()) {
    on<OnClickOfGetCampaignsEvent>(_getCampaigns);
  }

  Future<void> _getCampaigns(
      OnClickOfGetCampaignsEvent event, Emitter<GetCampaignsState> emit) async {
    emit(GetCampaignsLoadingstate());
    final DataState<GetCampaignsResponseModel> getCampaignsResponse =
        await getCampaignsUsecase.call();

    if (getCampaignsResponse is DataSuccess) {
      final getCampaignsSuccessResponseData = getCampaignsResponse.data;
      if (getCampaignsSuccessResponseData is GetCampaignsSuccessResponseModel) {
        List<CampaignData> campaignDataList =
            getCampaignsSuccessResponseData.campaignData ?? [];

        if (campaignDataList.isEmpty) {
          emit(GetCampaignsEmptyState());
        } else {
          emit(
            GetCampaignsSuccessstate(
              campaignDataList: campaignDataList,
            ),
          );
        }
      }
    } else if (getCampaignsResponse is DataFailed) {
      emit(GetCampaignsErrorState(
          errorMessage: getCampaignsResponse.error?.message ?? "Something went wrong"));
    }
  }
}
