import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/get_notes_response_model.dart';
import 'package:equatable/equatable.dart';

enum GetNotesListStatus {
  getNotesListInitial,
  getNotesListLoading,
  getNotesListSuccess,
  getNotesListFailure
}

final class GetNotesState extends Equatable {
  final GetNotesListStatus getNotesListStatus;
  final List<NotesListData> notesListData;
  final bool hasReachedMax;

  const GetNotesState({
    this.getNotesListStatus = GetNotesListStatus.getNotesListInitial,
    this.notesListData = const <NotesListData>[],
    this.hasReachedMax = false,
  });

  GetNotesState copyWith({
    GetNotesListStatus? getNotesListStatus,
    List<NotesListData>? notesListData,
    bool? hasReachedMax,
  }) {
    final newState = GetNotesState(
      getNotesListStatus: getNotesListStatus ?? this.getNotesListStatus,
      notesListData: notesListData ?? this.notesListData,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
    print("New State Emitted: $newState"); // Debug log
    return newState;
  }

  @override
  List<Object> get props => [getNotesListStatus, notesListData,hasReachedMax];
}
