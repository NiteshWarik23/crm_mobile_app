import 'package:equatable/equatable.dart';

abstract class CreateDealNoteState extends Equatable{
  @override
  List<Object> get props => [];
}

class CreateDealNoteInitialState extends CreateDealNoteState {}
class CreateDealNoteLoadingState extends CreateDealNoteState {}
class CreateDealNoteSuccessState extends CreateDealNoteState {}
class CreateDealNoteFailureState extends CreateDealNoteState {}