import 'package:equatable/equatable.dart';

abstract class CreateDealNoteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitCreatedDealNoteEvent extends CreateDealNoteEvent {
  final String title;
  final String content;
  final String dealId;

  SubmitCreatedDealNoteEvent({required this.title, required this.content,required this.dealId});

  @override
  List<Object> get props => [title, content,dealId];
}
