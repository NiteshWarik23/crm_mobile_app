import 'package:crm_mobile_app/modules/marketing/data/services/models/response/get_campaigns_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class GetCampaignsState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCampaignsInitialState extends GetCampaignsState {}

class GetCampaignsLoadingstate extends GetCampaignsState {}

class GetCampaignsEmptyState extends GetCampaignsState {}

class GetCampaignsSuccessstate extends GetCampaignsState {
  final List<CampaignData> campaignDataList;
  GetCampaignsSuccessstate({required this.campaignDataList});

  @override
  List<Object> get props => [campaignDataList];
}

class GetCampaignsErrorState extends GetCampaignsState {
  final String errorMessage;
  GetCampaignsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}


