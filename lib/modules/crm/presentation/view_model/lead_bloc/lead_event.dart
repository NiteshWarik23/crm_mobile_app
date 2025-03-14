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
