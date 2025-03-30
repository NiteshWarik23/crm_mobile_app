import 'package:equatable/equatable.dart';

abstract class LeadEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchLeadsEvent extends LeadEvent {
  final int limitStart;
  final int limit;

  FetchLeadsEvent({required this.limitStart, required this.limit});

  @override
  List<Object> get props => [limitStart, limit];
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

  SearchLeadEvent({required this.searchText,required this.limit,required this.limitStart});

  @override
  List<Object> get props => [searchText,limit,limitStart];
}

class DeleteLeadEvent extends LeadEvent {
  final String leadID;

  DeleteLeadEvent({required this.leadID});

  @override
  List<Object> get props => [leadID];
}
