import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/get_deal_notes_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/get_deal_notes_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/get_deal_notes_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/view_deal_notes_bloc/view_deal_notes_event.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/view_deal_notes_bloc/view_deal_notes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class GetDealNotesBloc extends Bloc<GetDealNotesEvent, GetDealNotesState> {
  final GetDealNotesUsecase getDealNotesUsecase;
  GetDealNotesBloc(this.getDealNotesUsecase) : super(GetDealNotesState()) {
    on<FetchDealNotesEvent>(
      _fetchNotes,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final int limit = 10; // Number of items per request
  int limitStart = 0; // Initial offset
  bool hasReachedMax = false; // To track if we should stop fetching

  Future<void> _fetchNotes(
      FetchDealNotesEvent event, Emitter<GetDealNotesState> emit) async {
    // Prevent additional requests if all data is loaded
    if (state.hasReachedMax) return;

    try {
      // If first load, show loading state
      if (event.limitStart == 0) {
        emit(state.copyWith(
          getDealNotesListStatus:
              GetDealNotesListStatus.getDealNotesListInitial,
          notesListData: [], // Clear old leads when refreshing
          hasReachedMax: false, // Reset pagination
        ));
      }

      final DataState<GetDealNotesResponseModel> getDealNotesListResponse =
          await getDealNotesUsecase.call(
        GetDealNotesRequestParams(
          getDealNotesRequestModel:
              GetDealNotesRequestModel(referenceDocname: event.dealIDValue),
          dealNotesoffsetLimitRequestModel: OffsetLimitRequestModel(
            limitStart: event.limitStart,
            limit: event.limit,
          ),
        ),
      );

      if (getDealNotesListResponse is DataSuccess) {
        final getDealNotesSuccessResponseData = getDealNotesListResponse.data;
        if (getDealNotesSuccessResponseData
            is GetDealNotesSuccessResponseModel) {
          print("Deal Count1 ${getDealNotesSuccessResponseData.data!.length}");

          List<DealNotesData> newNotes =
              getDealNotesSuccessResponseData.data ?? [];
          // Stop pagination if no new data is returned
          bool reachedMax = newNotes.isEmpty || newNotes.length < 10;
          print("Deal Count2 ${newNotes.length}");
          // if (newLeads.isEmpty) {
          //   return emit(state.copyWith(hasReachedMax: true));
          // }
          // Only set hasReachedMax to true if we're paginating and get an empty list
          if (event.limitStart != 0 && newNotes.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
            return;
          }

          emit(state.copyWith(
            getDealNotesListStatus:
                GetDealNotesListStatus.getDealNotesListSuccess,
            notesListData: event.limitStart == 0
                ? newNotes
                : // If refreshing, replace data
                state.notesListData + newNotes, // Append new posts
            hasReachedMax: reachedMax,
          ));

          //limitStart += limit; // Increase offset for next fetch
          // Update pagination offset only if new data exists
          if (newNotes.isNotEmpty) {
            limitStart += limit;
          }
        } else if (getDealNotesListResponse is DataFailed) {
          emit(state.copyWith(
              getDealNotesListStatus:
                  GetDealNotesListStatus.getDealNotesListFailure));
        }
      }
    } catch (e) {
      emit(state.copyWith(
          getDealNotesListStatus:
              GetDealNotesListStatus.getDealNotesListFailure));
    }
  }
}
