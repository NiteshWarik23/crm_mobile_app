import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_state.dart';
import 'package:equatable/equatable.dart';

abstract class LeadEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchLeadsEvent extends LeadEvent {
  final int limitStart;
  final int limit;
  final LeadFilter filter;

  FetchLeadsEvent({required this.limitStart, required this.limit, this.filter = LeadFilter.all});

  @override
  List<Object> get props => [limitStart, limit,filter];
}

class FilterLeadsEvent extends LeadEvent {
  final LeadFilter filter;
  FilterLeadsEvent(this.filter);

  @override
  List<Object> get props => [filter];
}

class FABVisibilityEvent extends LeadEvent {
  final bool isVisible;

  FABVisibilityEvent({required this.isVisible});

  @override
  List<Object> get props => [isVisible];
}

class ClearLeadsEvent extends LeadEvent {}

class ConvertLeadToDealEvent extends LeadEvent {
  final String leadID;

  ConvertLeadToDealEvent({required this.leadID});

  @override
  List<Object> get props => [leadID];
}

class UpdateLeadStatusEvent extends LeadEvent {
  final String leadID;
  final String status;

  UpdateLeadStatusEvent({required this.leadID, required this.status});

  @override
  List<Object> get props => [leadID, status];
}

class SearchLeadEvent extends LeadEvent {
  final String searchText;
  final int limitStart;
  final int limit;

  SearchLeadEvent(
      {required this.searchText,
      required this.limit,
      required this.limitStart});

  @override
  List<Object> get props => [searchText, limit, limitStart];
}

class DeleteLeadEvent extends LeadEvent {
  final String leadID;

  DeleteLeadEvent({required this.leadID});

  @override
  List<Object> get props => [leadID];
}
