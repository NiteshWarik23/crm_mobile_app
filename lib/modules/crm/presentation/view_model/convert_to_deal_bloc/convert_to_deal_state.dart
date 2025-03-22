import 'package:equatable/equatable.dart';

abstract class ConvertToDealState extends Equatable {
  @override
  List<Object> get props => [];
}

class ConvertToDealInitialState extends ConvertToDealState {}

class ConvertToDealLoadingState extends ConvertToDealState {}

class ConvertToDealStateSuccessState extends ConvertToDealState {}

class ConvertToDealFailureState extends ConvertToDealState {}
