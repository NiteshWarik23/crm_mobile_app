import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/deal_bloc/deal_state.dart';
import 'package:equatable/equatable.dart';

abstract class DealEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDealsEvent extends DealEvent {
  final int limitStart;
  final int limit;
  final DealFilter dealFilter;

  FetchDealsEvent(
      {required this.limitStart,
      required this.limit,
      this.dealFilter = DealFilter.all});

  @override
  List<Object> get props => [limitStart, limit,dealFilter];
}

class FilterDealsEvent extends DealEvent {
  final DealFilter filter;
  FilterDealsEvent(this.filter);

  @override
  List<Object> get props => [filter];
}

class FABVisibilityEvent extends DealEvent {
  final bool isVisible;

  FABVisibilityEvent({required this.isVisible});

  @override
  List<Object> get props => [isVisible];
}

class ClearDealsEvent extends DealEvent {}

class UpdateDealStatusEvent extends DealEvent {
  final String dealID;
  final String status;

  UpdateDealStatusEvent({required this.dealID, required this.status});

  @override
  List<Object> get props => [dealID, status];
}

class SearchDealEvent extends DealEvent {
  final String searchText;
  final int limitStart;
  final int limit;

  SearchDealEvent(
      {required this.searchText,
      required this.limit,
      required this.limitStart});

  @override
  List<Object> get props => [searchText, limit, limitStart];
}

class DeleteDealEvent extends DealEvent {
  final String dealID;

  DeleteDealEvent({required this.dealID});

  @override
  List<Object> get props => [dealID];
}
