import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/convert_lead_to_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/update_lead_status_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/convert_lead_to_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/lead_response.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/update_lead_status_response_model.dart';
import 'package:crm_mobile_app/modules/crm/domain/usecase/convert_lead_to_deal_usecase.dart';
import 'package:crm_mobile_app/modules/crm/domain/usecase/lead_usecase.dart';
import 'package:crm_mobile_app/modules/crm/domain/usecase/update_lead_status_usecase.dart';
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
  final ConvertLeadToDealUsecase convertLeadToDealUsecase;
  final UpdateLeadStatusUsecase updateLeadStatusUsecase;

  LeadBloc(
    this.leadUsecase,
    this.convertLeadToDealUsecase,
    this.updateLeadStatusUsecase,
  ) : super(LeadState()) {
    on<FetchLeadsEvent>(
      fetchLeads,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ClearLeadsEvent>(clearLeads);
    on<ConvertLeadToDealEvent>(convertLeadToDeal);
    on<UpdateLeadStatusEvent>(updateLeadStatus);
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
        emit(state.copyWith(
          status: LeadListStatus.initial,
          leadData: [], // Clear old leads when refreshing
          hasReachedMax: false, // Reset pagination
        ));
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

          // if (newLeads.isEmpty) {
          //   return emit(state.copyWith(hasReachedMax: true));
          // }
          // Only set hasReachedMax to true if we're paginating and get an empty list
          if (event.limitStart != 0 && newLeads.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
            return;
          }

          emit(state.copyWith(
            status: LeadListStatus.success,
            leadData: event.limitStart == 0
                ? newLeads
                : // If refreshing, replace data
                state.leadData + newLeads, // Append new posts
            hasReachedMax: reachedMax,
          ));

          //limitStart += limit; // Increase offset for next fetch
          // Update pagination offset only if new data exists
          if (newLeads.isNotEmpty) {
            limitStart += limit;
          }
        } else if (leadResponse is DataFailed) {
          emit(state.copyWith(status: LeadListStatus.failure));
        }
      }
    } catch (e) {
      emit(state.copyWith(status: LeadListStatus.failure));
    }
  }

  Future<void> clearLeads(
      ClearLeadsEvent event, Emitter<LeadState> emit) async {
    limitStart = 0; // Reset pagination
    hasReachedMax = false;
    emit(LeadState(status: LeadListStatus.initial, leadData: []));
  }

  Future<void> convertLeadToDeal(
      ConvertLeadToDealEvent event, Emitter<LeadState> emit) async {
    final DataState<ConvertLeadToDealResponse> convertLeadToDealResponse =
        await convertLeadToDealUsecase.call(
      ConvertLeadToDealRequestParams(
        convertLeadToDealRequestModel: ConvertLeadToDealRequestModel(
          lead: event.leadID,
        ),
      ),
    );

    if (convertLeadToDealResponse is DataSuccess) {
      final convertLeadToDealSuccessResponseData =
          convertLeadToDealResponse.data;
      if (convertLeadToDealSuccessResponseData
          is ConvertLeadToDealResponseModel) {
        emit(state.copyWith(
          status: LeadListStatus.success,
        ));
      } else if (convertLeadToDealSuccessResponseData
          is ConvertLeadToDealErrorResponseModel) {
        emit(state.copyWith(status: LeadListStatus.failure));
      }
    } else if (convertLeadToDealResponse is DataFailed) {
      emit(state.copyWith(status: LeadListStatus.failure));
    }
  }

  Future<void> updateLeadStatus(
      UpdateLeadStatusEvent event, Emitter<LeadState> emit) async {
    final DataState<UpdateLeadStatusResponse> updateLeadStatusResponse =
        await updateLeadStatusUsecase.call(
      UpdateLeadStatusRequestParams(
        updateLeadStatusRequestModel: UpdateLeadStatusRequestModel(
          doctype: "CRM Lead",
          name: event.leadID,
          fieldname: "status",
          value: event.status,
        ),
      ),
    );

    if (updateLeadStatusResponse is DataSuccess) {
      final updateLeadStatusSuccessResponseData = updateLeadStatusResponse.data;

      if (updateLeadStatusSuccessResponseData
          is UpdateLeadStatusResponseModel) {
              print(
            "Lead Updates Status${updateLeadStatusSuccessResponseData.message!.status}");
        if (updateLeadStatusSuccessResponseData.message?.status != null &&
            updateLeadStatusSuccessResponseData.message!.status ==
                event.status) {
          print(
              "Lead Updates Status${updateLeadStatusSuccessResponseData.message!.status}");
          emit(state.copyWith(
            status: LeadListStatus.updateLeadStatusSuccess,
          ));
        } else {
          emit(state.copyWith(status: LeadListStatus.updateLeadStatusFailure));
        }
      } else if (updateLeadStatusSuccessResponseData
          is UpdateLeadStatusErrorResponseModel) {
        emit(state.copyWith(status: LeadListStatus.updateLeadStatusFailure));
      }
    } else if (updateLeadStatusResponse is DataFailed) {
      emit(state.copyWith(status: LeadListStatus.updateLeadStatusFailure));
    }
  }
}
