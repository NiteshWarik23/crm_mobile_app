import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/lead_response.dart';
import 'package:crm_mobile_app/modules/crm/domain/usecase/lead_usecase.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/lead_bloc/lead_event.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/lead_bloc/lead_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}
class LeadBloc extends Bloc<LeadEvent, LeadState> {
  final LeadUsecase leadUsecase;

  LeadBloc(this.leadUsecase) : super(LeadState()) {
    on<FetchLeadsEvent>(fetchLeads,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final int limit = 10; // Number of items per request
  int limitStart = 0; // Initial offset
  bool hasReachedMax = false; // To track if we should stop fetching

  Future<void> fetchLeads(
      FetchLeadsEvent event, Emitter<LeadState> emit) async {
    // Prevent additional requests if all data is loaded
    if (state.hasReachedMax) return;

    try {
      // If first load, show loading state
      if (event.limitStart == 0) {
        emit(state.copyWith(status: LeadListStatus.initial));
      }

      final DataState<LeadResponse> leadResponse = await leadUsecase.call(
        LeadDataOffsetLimitRequestParams(
          offsetLimitRequestModel: OffsetLimitRequestModel(
            limitStart: event.limitStart,
            limit: event.limit,
          ),
        ),
      );

      if (leadResponse is DataSuccess) {
        final leadSuccessResponseData = leadResponse.data;
        if (leadSuccessResponseData is LeadsListSuccessResponseModel) {
          List<LeadData> newLeads = leadSuccessResponseData.data ?? [];
          // Stop pagination if no new data is returned
          bool reachedMax = newLeads.isEmpty;

          if (newLeads.isEmpty) {
            return emit(state.copyWith(hasReachedMax: true));
          }

          emit(state.copyWith(
            status: LeadListStatus.success,
            leadData: state.leadData + newLeads, // Append new posts
            hasReachedMax: reachedMax,
          ));

          limitStart += limit; // Increase offset for next fetch
        }else if (leadResponse is DataFailed){
          emit(state.copyWith(status: LeadListStatus.failure));
        }
      }
    } catch (e) {
      emit(state.copyWith(status: LeadListStatus.failure));
    }
  }
}
