import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/get_notes_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/get_notes_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/get_notes_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/view_notes_bloc/view_notes_event.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/view_notes_bloc/view_notes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class GetNotesBloc extends Bloc<GetNotesEvent, GetNotesState> {
  final GetNotesUsecase getNotesUsecase;
  GetNotesBloc(this.getNotesUsecase) : super(GetNotesState()) {
    on<FetchNotesEvent>(
      _fetchNotes,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final int limit = 10; // Number of items per request
  int limitStart = 0; // Initial offset
  bool hasReachedMax = false; // To track if we should stop fetching

  Future<void> _fetchNotes(
      FetchNotesEvent event, Emitter<GetNotesState> emit) async {
    // Prevent additional requests if all data is loaded
    if (state.hasReachedMax) return;

    try {
      // If first load, show loading state
      if (event.limitStart == 0) {
        emit(state.copyWith(
          getNotesListStatus: GetNotesListStatus.getNotesListInitial,
          notesListData: [], // Clear old leads when refreshing
          hasReachedMax: false, // Reset pagination
        ));
      }

      final DataState<GetNotesResponseModel> getNotesListResponse =
          await getNotesUsecase.call(
        GetNotesRequestParams(
          getNotesRequestModel: GetNotesRequestModel(
            referenceDocname: event.leadIDValue
          ),
          notesoffsetLimitRequestModel: OffsetLimitRequestModel(
            limitStart: event.limitStart,
            limit: event.limit,
          ),
        ),
      );

      if (getNotesListResponse is DataSuccess) {
        final getNotesSuccessResponseData = getNotesListResponse.data;
        if (getNotesSuccessResponseData is GetNotesSuccessResponseModel) {
          List<NotesListData> newNotes = getNotesSuccessResponseData.data ?? [];
          // Stop pagination if no new data is returned
          bool reachedMax = newNotes.isEmpty || newNotes.length < 10;
          //print("Lead Count ${newLeads.length}");
          // if (newLeads.isEmpty) {
          //   return emit(state.copyWith(hasReachedMax: true));
          // }
          // Only set hasReachedMax to true if we're paginating and get an empty list
          if (event.limitStart != 0 && newNotes.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
            return;
          }

          emit(state.copyWith(
            getNotesListStatus: GetNotesListStatus.getNotesListSuccess,
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
        } else if (getNotesListResponse is DataFailed) {
          emit(state.copyWith(getNotesListStatus: GetNotesListStatus.getNotesListFailure));
        }
      }
    } catch (e) {
      emit(state.copyWith(
          getNotesListStatus: GetNotesListStatus.getNotesListFailure));
    }
  }
}
