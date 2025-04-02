import 'package:equatable/equatable.dart';

abstract class ConvertToDealEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class ConvertLeadToDealNewEvent extends ConvertToDealEvent {
  final String leadID;

  ConvertLeadToDealNewEvent({required this.leadID});

  @override
  List<Object> get props => [leadID];
}