import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/lead_response.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/search_lead_response_model.dart';
import 'package:equatable/equatable.dart';

enum LeadListStatus {
  initial,
  success,
  failure,
  // convertToDealSuccess,
  // convertToDealFailure,
  // updateLeadStatusSuccess,
  // updateLeadStatusFailure
}

enum DeleteLeadStatus {
  deleteLeadInitial,
  deleteLeadLoading,
  deleteLeadSuccess,
  deleteLeadFailure
}

enum SearchLeadStatus {
  searchLeadInitial,
  searchLeadLoading,
  searchLeadSuccess,
  searchLeadFailure
}

enum ConvertToDealStatus {
  convertToDealInitial,
  convertToDealLoading,
  convertToDealSuccess,
  convertToDealFailure
}

enum UpdateLeadStatus {
  updateLeadStatusInitial,
  updateLeadStatusLoading,
  updateLeadStatusSuccess,
  updateLeadStatusFailure
}

final class LeadState extends Equatable {
  final LeadListStatus status;
  final ConvertToDealStatus convertToDealStatus;
  final UpdateLeadStatus updateLeadStatus;
  final SearchLeadStatus searchLeadStatus;
  final DeleteLeadStatus deleteLeadStatus;
  final List<LeadData> leadData;
  final List<SearchLeadData> searchLeadData;
  final bool hasReachedMax;
  final bool isUserSearching;

  const LeadState({
    this.status = LeadListStatus.initial,
    this.convertToDealStatus = ConvertToDealStatus.convertToDealInitial,
    this.updateLeadStatus = UpdateLeadStatus.updateLeadStatusInitial,
    this.searchLeadStatus = SearchLeadStatus.searchLeadInitial,
    this.deleteLeadStatus = DeleteLeadStatus.deleteLeadInitial,
    this.leadData = const <LeadData>[],
    this.searchLeadData = const <SearchLeadData>[],
    this.hasReachedMax = false,
    this.isUserSearching = false,
  });

  LeadState copyWith({
    LeadListStatus? status,
    ConvertToDealStatus? convertToDealStatus,
    UpdateLeadStatus? updateLeadStatus,
    SearchLeadStatus? searchLeadStatus,
    DeleteLeadStatus? deleteLeadStatus,
    List<LeadData>? leadData,
    List<SearchLeadData>? searchLeadData,
    bool? hasReachedMax,
    bool? isUserSearching,
  }) {
    final newState = LeadState(
      status: status ?? this.status,
      convertToDealStatus: convertToDealStatus ?? this.convertToDealStatus,
      updateLeadStatus: updateLeadStatus ?? this.updateLeadStatus,
      searchLeadStatus: searchLeadStatus ?? this.searchLeadStatus,
      deleteLeadStatus: deleteLeadStatus ?? this.deleteLeadStatus,
      leadData: leadData ?? this.leadData,
      searchLeadData: searchLeadData ?? this.searchLeadData,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isUserSearching: isUserSearching ?? this.isUserSearching,
    );
    print("New State Emitted: $newState"); // Debug log

    return newState;
  }

  @override
  String toString() {
    return '''PostState { status: $status,convertToDealStatus: $convertToDealStatus,updateLeadStatus: $updateLeadStatus,searchLeadStatus: $searchLeadStatus,deleteLeadStatus: $deleteLeadStatus,  hasReachedMax: $hasReachedMax,isUserSearching: $isUserSearching, posts: ${leadData.length}, searchLeadData: ${searchLeadData.length} }''';
  }

  @override
  List<Object> get props => [
        status,
        convertToDealStatus,
        updateLeadStatus,
        searchLeadStatus,
        deleteLeadStatus,
        leadData,
        searchLeadData,
        hasReachedMax,
        isUserSearching,
      ];
}
