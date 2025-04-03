import 'package:equatable/equatable.dart';

abstract class GetDealNotesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Fetch all notes
class FetchDealNotesEvent extends GetDealNotesEvent {
  final int limitStart;
  final int limit;
  final String dealIDValue;

  FetchDealNotesEvent({
    required this.limitStart,
    required this.limit,
    required this.dealIDValue,
  });

  @override
  List<Object> get props => [limitStart, limit,dealIDValue];
}

// Update an existing note
// class UpdateNoteEvent extends GetNotesEvent {
//   final Note updatedNote;
//   UpdateNoteEvent(this.updatedNote);

//   @override
//   List<Object?> get props => [updatedNote];
// }

// Delete a note
class DeleteDealNoteEvent extends GetDealNotesEvent {
  final int noteId;
  DeleteDealNoteEvent(this.noteId);

  @override
  List<Object?> get props => [noteId];
}
