import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/delete_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/update_deal_status_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/deal_response.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/delete_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/search_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/update_deal_status_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/deal_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/delete_deal_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/search_deal_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/update_deal_status_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/deal_bloc/deal_event.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/deal_bloc/deal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class DealBloc extends Bloc<DealEvent, DealState> {
  final DealUsecase dealUsecase;
  final UpdateDealStatusUsecase updateDealStatusUsecase;
  final SearchDealUsecase searchDealUsecase;
  final DeleteDealUsecase deleteDealUsecase;

  DealBloc(
      this.dealUsecase,
      this.updateDealStatusUsecase,
      this.searchDealUsecase,
      this.deleteDealUsecase)
      : super(DealState()) {
    on<FetchDealsEvent>(
      fetchDeals,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ClearDealsEvent>(clearDeals);
    on<UpdateDealStatusEvent>(updateDealStatus);
    on<SearchDealEvent>(
      searchDeals,
      transformer: debounce(_duration),
    );
    on<DeleteDealEvent>(deleteDeal);
  }

  final int limit = 10; // Number of items per request
  int limitStart = 0; // Initial offset
  bool hasReachedMax = false; // To track if we should stop fetching

  Future<void> fetchDeals(
      FetchDealsEvent event, Emitter<DealState> emit) async {
    // Prevent additional requests if all data is loaded
    if (state.hasReachedMax) return;

    try {
      // If first load, show loading state
      if (event.limitStart == 0) {
        emit(state.copyWith(
          status: DealListStatus.initial,
          dealData: [], // Clear old leads when refreshing
          hasReachedMax: false, // Reset pagination
        ));
      }

      final DataState<DealResponse> dealResponse = await dealUsecase.call(
        DealDataOffsetLimitRequestParams(
          offsetLimitRequestModel: OffsetLimitRequestModel(
            limitStart: event.limitStart,
            limit: event.limit,
          ),
        ),
      );

      if (dealResponse is DataSuccess) {
        final dealSuccessResponseData = dealResponse.data;
        if (dealSuccessResponseData is DealsListSuccessResponseModel) {
          List<DealData> newDeals = dealSuccessResponseData.data ?? [];
          // Stop pagination if no new data is returned
          bool reachedMax = newDeals.isEmpty || newDeals.length < 10;
          print("Lead Count ${newDeals.length}");
          // if (newLeads.isEmpty) {
          //   return emit(state.copyWith(hasReachedMax: true));
          // }
          // Only set hasReachedMax to true if we're paginating and get an empty list
          if (event.limitStart != 0 && newDeals.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
            return;
          }

          emit(state.copyWith(
            status: DealListStatus.success,
            dealData: event.limitStart == 0
                ? newDeals
                : // If refreshing, replace data
                state.dealData + newDeals, // Append new posts
            hasReachedMax: reachedMax,
          ));

          //limitStart += limit; // Increase offset for next fetch
          // Update pagination offset only if new data exists
          if (newDeals.isNotEmpty) {
            limitStart += limit;
          }
        } else if (dealResponse is DataFailed) {
          emit(state.copyWith(status: DealListStatus.failure));
        }
      }
    } catch (e) {
      emit(state.copyWith(status: DealListStatus.failure));
    }
  }

  Future<void> clearDeals(
      ClearDealsEvent event, Emitter<DealState> emit) async {
    limitStart = 0; // Reset pagination
    hasReachedMax = false;
    emit(DealState(status: DealListStatus.initial, dealData: []));
  }

  Future<void> updateDealStatus(
      UpdateDealStatusEvent event, Emitter<DealState> emit) async {
    emit(state.copyWith(
      updateDealStatus: UpdateDealStatus.updateDealStatusLoading,
    ));
    final DataState<UpdateDealStatusResponse> updateDealStatusResponse =
        await updateDealStatusUsecase.call(
      UpdateDealStatusRequestParams(
        updateDealStatusRequestModel: UpdateDealStatusRequestModel(
          doctype: "CRM Deal",
          name: event.dealID,
          fieldname: "status",
          value: event.status,
        ),
      ),
    );

    if (updateDealStatusResponse is DataSuccess) {
      final updateDealStatusSuccessResponseData = updateDealStatusResponse.data;

      if (updateDealStatusSuccessResponseData
          is UpdateDealStatusResponseModel) {
        emit(state.copyWith(
          updateDealStatus: UpdateDealStatus.updateDealStatusSuccess,
        ));
      } else if (updateDealStatusSuccessResponseData
          is UpdateDealStatusErrorResponseModel) {
        emit(state.copyWith(
            updateDealStatus: UpdateDealStatus.updateDealStatusFailure));
      }
    } else if (updateDealStatusResponse is DataFailed) {
      emit(state.copyWith(
          updateDealStatus: UpdateDealStatus.updateDealStatusFailure));
    }
  }

//TODO: Change the ssearchstatus while emitting
  Future<void> searchDeals(
      SearchDealEvent event, Emitter<DealState> emit) async {
    emit(state.copyWith(
      searchDealStatus: SearchDealStatus.searchDealInitial,
      searchDealData: [], // Clear old leads when refreshing
      hasReachedMax: false, // Reset pagination
      isUserSearching: true,
    ));
    try {
      final DataState<SearchDealResponse> searchDealResponse =
          await searchDealUsecase.call(
              // LeadDataOffsetLimitRequestParams(
              //   offsetLimitRequestModel: OffsetLimitRequestModel(
              //     limitStart: 0,
              //     limit: limit,
              //   ),
              //   searchText: event.searchText,
              // ),
              SearchDealDataRequestParams(enteredSearchText: event.searchText));

      if (searchDealResponse is DataSuccess) {
        final dealSuccessResponseData = searchDealResponse.data;
        if (dealSuccessResponseData is SearchDealSuccesssResponseModel) {
          List<SearchDealData> newLeads = dealSuccessResponseData.data ?? [];
          // Stop pagination if no new data is returned
          bool reachedMax = newLeads.isEmpty;

          // Only set hasReachedMax to true if we're paginating and get an empty list
          if (event.searchText.isNotEmpty && newLeads.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
            return;
          }

          emit(state.copyWith(
            searchDealStatus: SearchDealStatus.searchDealSuccess,
            searchDealData: newLeads,
            hasReachedMax: reachedMax,
          ));

          // Update pagination offset only if new data exists
          if (newLeads.isNotEmpty) {
            limitStart += limit;
          }
        } else if (searchDealResponse is DataFailed) {
          emit(state.copyWith(status: DealListStatus.failure));
        }
      }
    } catch (e) {
      emit(state.copyWith(status: DealListStatus.failure));
    }
  }

  Future<void> deleteDeal(
      DeleteDealEvent event, Emitter<DealState> emit) async {
    emit(state.copyWith(
      deleteDealStatus: DeleteDealStatus.deleteDealLoading,
    ));

    final DataState<DeleteDealResponse> deleteDealResponse =
        await deleteDealUsecase.call(
      DeleteDealRequestParams(
          deleteDealRequestModel: DeleteDealRequestModel(
              items: "[\"${event.dealID}\"]", doctype: "CRM Deal")),
    );

    if (deleteDealResponse is DataSuccess) {
      final deleteLeadSuccessResponseData = deleteDealResponse.data;
      if (deleteLeadSuccessResponseData is DeleteDealSuccessResponseModel) {
        emit(state.copyWith(
          deleteDealStatus: DeleteDealStatus.deleteDealSuccess,
        ));
      } else if (deleteLeadSuccessResponseData
          is DeleteDealErrorResponseModel) {
        emit(state.copyWith(
          deleteDealStatus: DeleteDealStatus.deleteDealFailure,
        ));
      }
    } else if (deleteDealResponse is DataFailed) {
      emit(state.copyWith(
        deleteDealStatus: DeleteDealStatus.deleteDealFailure,
      ));
    }
  }
}
