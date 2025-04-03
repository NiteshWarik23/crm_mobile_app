import 'package:equatable/equatable.dart';

abstract class DealEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDealsEvent extends DealEvent {
  final int limitStart;
  final int limit;

  FetchDealsEvent({required this.limitStart, required this.limit});

  @override
  List<Object> get props => [limitStart, limit];
}

class FABVisibilityEvent extends DealEvent {
  final bool isVisible;

  FABVisibilityEvent({required this.isVisible});

  @override
  List<Object> get props => [isVisible];
}

class ClearDealsEvent extends DealEvent {}

class UpdateDealStatusEvent extends DealEvent {
  final String leadID;
  final String status;

  UpdateDealStatusEvent({required this.leadID, required this.status});

  @override
  List<Object> get props => [leadID, status];
}

class SearchDealEvent extends DealEvent {
  final String searchText;
  final int limitStart;
  final int limit;

  SearchDealEvent({required this.searchText,required this.limit,required this.limitStart});

  @override
  List<Object> get props => [searchText,limit,limitStart];
}

class DeleteDealEvent extends DealEvent {
  final String leadID;

  DeleteDealEvent({required this.leadID});

  @override
  List<Object> get props => [leadID];
}
