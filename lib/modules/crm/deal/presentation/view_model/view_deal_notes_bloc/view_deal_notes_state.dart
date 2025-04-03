import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/get_deal_notes_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/get_notes_response_model.dart';
import 'package:equatable/equatable.dart';

enum GetDealNotesListStatus {
  getDealNotesListInitial,
  getDealNotesListLoading,
  getDealNotesListSuccess,
  getDealNotesListFailure
}

final class GetDealNotesState extends Equatable {
  final GetDealNotesListStatus getDealNotesListStatus;
  final List<DealNotesData> notesListData;
  final bool hasReachedMax;

  const GetDealNotesState({
    this.getDealNotesListStatus = GetDealNotesListStatus.getDealNotesListInitial,
    this.notesListData = const <DealNotesData>[],
    this.hasReachedMax = false,
  });

  GetDealNotesState copyWith({
    GetDealNotesListStatus? getDealNotesListStatus,
    List<DealNotesData>? notesListData,
    bool? hasReachedMax,
  }) {
    final newState = GetDealNotesState(
      getDealNotesListStatus: getDealNotesListStatus ?? this.getDealNotesListStatus,
      notesListData: notesListData ?? this.notesListData,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
    print("New State Emitted: $newState"); // Debug log
    return newState;
  }

  @override
  List<Object> get props => [getDealNotesListStatus, notesListData,hasReachedMax];
}
