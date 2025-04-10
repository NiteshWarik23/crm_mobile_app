import 'package:equatable/equatable.dart';

abstract class GetCampaignsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnClickOfGetCampaignsEvent extends GetCampaignsEvent {}
