import 'package:equatable/equatable.dart';

abstract class CreateNoteState extends Equatable{
  @override
  List<Object> get props => [];
}

class CreateNoteInitialState extends CreateNoteState{}
class CreateNoteLoadingState extends CreateNoteState{}
class CreateNoteSuccessState extends CreateNoteState{}
class CreateNoteFailureState extends CreateNoteState{}