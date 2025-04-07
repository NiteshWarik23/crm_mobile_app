import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/convert_lead_to_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/delete_lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/update_lead_status_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/convert_lead_to_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/delete_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/lead_response.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/search_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/update_lead_status_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/convert_lead_to_deal_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/delete_lead_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/lead_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/search_lead_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/update_lead_status_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_event.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_state.dart';
import 'package:flutter/material.dart';
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

class LeadBloc extends Bloc<LeadEvent, LeadState> {
  final LeadUsecase leadUsecase;
  final ConvertLeadToDealUsecase convertLeadToDealUsecase;
  final UpdateLeadStatusUsecase updateLeadStatusUsecase;
  final SearchLeadUsecase searchLeadUsecase;
  final DeleteLeadUsecase deleteLeadUsecase;

  LeadBloc(
      this.leadUsecase,
      this.convertLeadToDealUsecase,
      this.updateLeadStatusUsecase,
      this.searchLeadUsecase,
      this.deleteLeadUsecase)
      : super(LeadState()) {
    on<FetchLeadsEvent>(
      fetchLeads,
      transformer: throttleDroppable(throttleDuration),
    );
    on<FilterLeadsEvent>(
      fetchFilteredLeads,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ClearLeadsEvent>(clearLeads);
    on<ConvertLeadToDealEvent>(convertLeadToDeal);
    on<UpdateLeadStatusEvent>(updateLeadStatus);
    on<SearchLeadEvent>(
      searchLeads,
      transformer: debounce(_duration),
    );
    on<DeleteLeadEvent>(deleteLead);
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
          //selectedFilter: event.filter,
        ));
      }
      print("Filter Selected ${event.filter.name}");

      final DataState<LeadResponse> leadResponse = await leadUsecase.call(
        LeadDataOffsetLimitRequestParams(
          offsetLimitRequestModel: OffsetLimitRequestModel(
            limitStart: event.limitStart,
            limit: event.limit,
          ),
          filterType: event.filter.name,
        ),
      );

      if (leadResponse is DataSuccess) {
        final leadSuccessResponseData = leadResponse.data;
        if (leadSuccessResponseData is LeadsListSuccessResponseModel) {
          List<LeadData> newLeads = leadSuccessResponseData.data ?? [];
          // Stop pagination if no new data is returned
          bool reachedMax = newLeads.isEmpty || newLeads.length < 10;
          print("Lead Count ${newLeads.length}");
          // if (newLeads.isEmpty) {
          //   return emit(state.copyWith(hasReachedMax: true));
          // }
          // Only set hasReachedMax to true if we're paginating and get an empty list
          if (event.limitStart != 0 && newLeads.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
            return;
          }
          print("Event Filter on success ${event.filter}");

          switch (event.filter) {
            case LeadFilter.all:
              emit(state.copyWith(
                status: LeadListStatus.success,
                leadData: event.limitStart == 0
                    ? newLeads
                    : // If refreshing, replace data
                    state.leadData + newLeads, // Append new posts
                hasReachedMax: reachedMax,
                selectedFilter: event.filter, // ✅ include this
              ));
              break;
            case LeadFilter.contacted:
              emit(state.copyWith(
                status: LeadListStatus.contectedFilter,
                leadData: event.limitStart == 0
                    ? newLeads
                    : // If refreshing, replace data
                    state.leadData + newLeads, // Append new posts
                hasReachedMax: reachedMax,
                selectedFilter: event.filter, // ✅ include this
              ));
              break;
            case LeadFilter.nurture:
              emit(state.copyWith(
                status: LeadListStatus.nutureFilter,
                leadData: event.limitStart == 0
                    ? newLeads
                    : // If refreshing, replace data
                    state.leadData + newLeads, // Append new posts
                hasReachedMax: reachedMax,
                selectedFilter: event.filter, // ✅ include this
              ));
              break;
            case LeadFilter.qualified:
              emit(state.copyWith(
                status: LeadListStatus.qualifiedFilter,
                leadData: event.limitStart == 0
                    ? newLeads
                    : // If refreshing, replace data
                    state.leadData + newLeads, // Append new posts
                hasReachedMax: reachedMax,
                selectedFilter: event.filter, // ✅ include this
              ));
              break;
            case LeadFilter.unqualified:
              emit(state.copyWith(
                status: LeadListStatus.unqualifiedFilter,
                leadData: event.limitStart == 0
                    ? newLeads
                    : // If refreshing, replace data
                    state.leadData + newLeads, // Append new posts
                hasReachedMax: reachedMax,
                selectedFilter: event.filter, // ✅ include this
              ));
              break;
            case LeadFilter.junk:
              emit(state.copyWith(
                status: LeadListStatus.junkFilter,
                leadData: event.limitStart == 0
                    ? newLeads
                    : // If refreshing, replace data
                    state.leadData + newLeads, // Append new posts
                hasReachedMax: reachedMax,
                selectedFilter: event.filter, // ✅ include this
              ));
              break;
          }
          // emit(state.copyWith(
          //   status: LeadListStatus.success,
          //   leadData: event.limitStart == 0
          //       ? newLeads
          //       : // If refreshing, replace data
          //       state.leadData + newLeads, // Append new posts
          //   hasReachedMax: reachedMax,
          //   selectedFilter: event.filter, // ✅ include this
          // ));

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

  Future<void> fetchFilteredLeads(
      FilterLeadsEvent event, Emitter<LeadState> emit) async {
    emit(state.copyWith(selectedFilter: event.filter, leadData: []));
    // limitStart = 0;
    add(ClearLeadsEvent());
    add(FetchLeadsEvent(limitStart: 0, limit: 10));
  }

  Future<void> convertLeadToDeal(
      ConvertLeadToDealEvent event, Emitter<LeadState> emit) async {
    emit(state.copyWith(
      convertToDealStatus: ConvertToDealStatus.convertToDealLoading,
    ));

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
        // List<LeadData> updatedLeads = state.leadData.map((lead) {
        //   if (lead.name == event.leadID) {
        //     // return lead.copyWith(status: "Converted to Deal"); // Update locally
        //     //return lead.status = "Converted to Deal";
        //   }
        //   return lead;
        // }).toList();

        // emit(state.copyWith(
        //   convertToDealStatus: ConvertToDealStatus.convertToDealSuccess,
        //   leadData: updatedLeads,
        // ));
        emit(state.copyWith(
          convertToDealStatus: ConvertToDealStatus.convertToDealSuccess,
        ));
      } else if (convertLeadToDealSuccessResponseData
          is ConvertLeadToDealErrorResponseModel) {
        emit(state.copyWith(
          convertToDealStatus: ConvertToDealStatus.convertToDealFailure,
        ));
      }
    } else if (convertLeadToDealResponse is DataFailed) {
      emit(state.copyWith(
        convertToDealStatus: ConvertToDealStatus.convertToDealFailure,
      ));
    }
  }

  Future<void> updateLeadStatus(
      UpdateLeadStatusEvent event, Emitter<LeadState> emit) async {
    emit(state.copyWith(
      updateLeadStatus: UpdateLeadStatus.updateLeadStatusLoading,
    ));
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
        emit(state.copyWith(
          updateLeadStatus: UpdateLeadStatus.updateLeadStatusSuccess,
        ));
        // if (updateLeadStatusSuccessResponseData.message?.status != null &&
        //     updateLeadStatusSuccessResponseData.message!.status ==
        //         event.status) {
        //   print(
        //       "Lead Updates Status${updateLeadStatusSuccessResponseData.message!.status}");
        //   emit(state.copyWith(
        //     updateLeadStatus: UpdateLeadStatus.updateLeadStatusSuccess,
        //   ));
        // }
      } else if (updateLeadStatusSuccessResponseData
          is UpdateLeadStatusErrorResponseModel) {
        emit(state.copyWith(
            updateLeadStatus: UpdateLeadStatus.updateLeadStatusFailure));
      }
    } else if (updateLeadStatusResponse is DataFailed) {
      emit(state.copyWith(
          updateLeadStatus: UpdateLeadStatus.updateLeadStatusFailure));
    }
  }

//TODO: Change the ssearchstatus while emitting
  Future<void> searchLeads(
      SearchLeadEvent event, Emitter<LeadState> emit) async {
    emit(state.copyWith(
      searchLeadStatus: SearchLeadStatus.searchLeadInitial,
      searchLeadData: [], // Clear old leads when refreshing
      hasReachedMax: false, // Reset pagination
      isUserSearching: true,
    ));
    try {
      final DataState<SearchLeadResponse> leadResponse =
          await searchLeadUsecase.call(
        SearchLeadDataRequestParams(
          offsetLimitRequestModel: OffsetLimitRequestModel(
            limitStart: event.limitStart,
            limit: event.limit,
          ),
          enteredSearchText: event.searchText,
        ),
      );

      if (leadResponse is DataSuccess) {
        final leadSuccessResponseData = leadResponse.data;
        if (leadSuccessResponseData is SearchLeadSuccesssResponseModel) {
          List<SearchLeadData> newLeads = leadSuccessResponseData.data ?? [];
          // Stop pagination if no new data is returned
          bool reachedMax = newLeads.isEmpty || newLeads.length < 10;

          // Only set hasReachedMax to true if we're paginating and get an empty list
          if (event.searchText.isNotEmpty && newLeads.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
            return;
          }

          emit(state.copyWith(
            searchLeadStatus: SearchLeadStatus.searchLeadSuccess,
            searchLeadData: event.limitStart == 0
                ? newLeads
                : state.searchLeadData + newLeads,
            hasReachedMax: reachedMax,
          ));

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

  Future<void> deleteLead(
      DeleteLeadEvent event, Emitter<LeadState> emit) async {
    emit(state.copyWith(
      deleteLeadStatus: DeleteLeadStatus.deleteLeadLoading,
    ));

    final DataState<DeleteLeadResponse> deleteLeadResponse =
        await deleteLeadUsecase.call(
      DeleteLeadRequestParams(
          deleteLeadRequestModel: DeleteLeadRequestModel(
              items: "[\"${event.leadID}\"]", doctype: "CRM Lead")),
    );

    if (deleteLeadResponse is DataSuccess) {
      final deleteLeadSuccessResponseData = deleteLeadResponse.data;
      if (deleteLeadSuccessResponseData is DeleteLeadSuccessResponseModel) {
        emit(state.copyWith(
          deleteLeadStatus: DeleteLeadStatus.deleteLeadSuccess,
        ));
      } else if (deleteLeadSuccessResponseData
          is DeleteLeadErrorResponseModel) {
        emit(state.copyWith(
          deleteLeadStatus: DeleteLeadStatus.deleteLeadFailure,
        ));
      }
    } else if (deleteLeadResponse is DataFailed) {
      emit(state.copyWith(
        deleteLeadStatus: DeleteLeadStatus.deleteLeadFailure,
      ));
    }
  }
}
