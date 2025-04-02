import 'package:equatable/equatable.dart';

abstract class GetNotesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Fetch all notes
class FetchNotesEvent extends GetNotesEvent {
  final int limitStart;
  final int limit;
  final String leadIDValue;

  FetchNotesEvent({
    required this.limitStart,
    required this.limit,
    required this.leadIDValue,
  });

  @override
  List<Object> get props => [limitStart, limit];
}

// Update an existing note
// class UpdateNoteEvent extends GetNotesEvent {
//   final Note updatedNote;
//   UpdateNoteEvent(this.updatedNote);

//   @override
//   List<Object?> get props => [updatedNote];
// }

// Delete a note
class DeleteNoteEvent extends GetNotesEvent {
  final int noteId;
  DeleteNoteEvent(this.noteId);

  @override
  List<Object?> get props => [noteId];
}
