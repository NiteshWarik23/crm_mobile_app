import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/deal_response.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/search_deal_response_model.dart';
import 'package:equatable/equatable.dart';

enum DealListStatus {
  initial,
  success,
  failure,
}

enum DeleteDealStatus {
  deleteDealInitial,
  deleteDealLoading,
  deleteDealSuccess,
  deleteDealFailure
}

enum SearchDealStatus {
  searchDealInitial,
  searchDealLoading,
  searchDealSuccess,
  searchDealFailure
}


enum UpdateDealStatus {
  updateDealStatusInitial,
  updateDealStatusLoading,
  updateDealStatusSuccess,
  updateDealStatusFailure
}

final class DealState extends Equatable {
  final DealListStatus status;
  final UpdateDealStatus updateDealStatus;
  final SearchDealStatus searchDealStatus;
  final DeleteDealStatus deleteDealStatus;
  final List<DealData> dealData;
  final List<SearchDealData> searchDealData;
  final bool hasReachedMax;
  final bool isUserSearching;

  const DealState({
    this.status = DealListStatus.initial,
    this.updateDealStatus = UpdateDealStatus.updateDealStatusInitial,
    this.searchDealStatus = SearchDealStatus.searchDealInitial,
    this.deleteDealStatus = DeleteDealStatus.deleteDealInitial,
    this.dealData = const <DealData>[],
    this.searchDealData = const <SearchDealData>[],
    this.hasReachedMax = false,
    this.isUserSearching = false,
  });

  DealState copyWith({
    DealListStatus? status,
    UpdateDealStatus? updateDealStatus,
    SearchDealStatus? searchDealStatus,
    DeleteDealStatus? deleteDealStatus,
    List<DealData>? dealData,
    List<SearchDealData>? searchDealData,
    bool? hasReachedMax,
    bool? isUserSearching,
  }) {
    final newState = DealState(
      status: status ?? this.status,
      updateDealStatus: updateDealStatus ?? this.updateDealStatus,
      searchDealStatus: searchDealStatus ?? this.searchDealStatus,
      deleteDealStatus: deleteDealStatus ?? this.deleteDealStatus,
      dealData: dealData ?? this.dealData,
      searchDealData: searchDealData ?? this.searchDealData,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isUserSearching: isUserSearching ?? this.isUserSearching,
    );
    print("New State Emitted: $newState"); // Debug log

    return newState;
  }


  @override
  List<Object> get props => [
        status,
        updateDealStatus,
        searchDealStatus,
        deleteDealStatus,
        dealData,
        searchDealData,
        hasReachedMax,
        isUserSearching,
      ];
}
