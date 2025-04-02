import 'package:equatable/equatable.dart';

abstract class CreateNoteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitCreatedNoteEvent extends CreateNoteEvent {
  final String title;
  final String content;
  final String leadId;

  SubmitCreatedNoteEvent({required this.title, required this.content,required this.leadId});

  @override
  List<Object> get props => [title, content,leadId];
}
