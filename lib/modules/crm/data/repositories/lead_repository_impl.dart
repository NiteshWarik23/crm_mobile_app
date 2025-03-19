

import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:crm_mobile_app/core/error/failure.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/core/utils/strings.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/data/services/lead_api.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/convert_lead_to_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/update_lead_status_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/convert_lead_to_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/lead_response.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/update_lead_status_response_model.dart';
import 'package:dio/dio.dart';

class LeadRepositoryImpl implements LeadRepository{
  final LeadApi leadApi;
  LeadRepositoryImpl(this.leadApi);

  @override
  ResultFuture<LeadResponse> getLeads( OffsetLimitRequestModel offsetLimitRequestModel
      ) async {
    try {
      final leadResponse = await leadApi.getLeads(  offsetLimitRequestModel);

      if (leadResponse is LeadsListSuccessResponseModel) {
        return DataSuccess(leadResponse);
      } else if (leadResponse is LeadsListErrorResponseModel) {
        return DataFailed(ServerFailure(
            //TODO TBD for what message to show
            //leadResponse.exc ?? 
            Strings.defaultErrMsg, 401));
      } else {
        return DataFailed(UnknownFailure(Strings.defaultErrMsg, 0));
      }
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrMsg, e.statusCode!));
    } on DioException catch (e) {
      return DataFailed(UnknownFailure(e.toString(), 0));
    } catch (e) {
      return DataFailed(UnknownFailure(e.toString(), 0));
    }
  }

  @override
  ResultFuture<ConvertLeadToDealResponse> convertLeadToDeal(
      ConvertLeadToDealRequestModel convertLeadToDealRequestModel) async {
    try {
      final convertLeadToDealResponse = await leadApi.convertLeadToDeal(
          convertLeadToDealRequestModel);

      if (convertLeadToDealResponse is ConvertLeadToDealResponseModel) {
        return DataSuccess(convertLeadToDealResponse);
      } else if (convertLeadToDealResponse is ConvertLeadToDealErrorResponseModel) {
        return DataFailed(ServerFailure(
            //TODO TBD for what message to show
            //convertLeadToDealResponse.excType ?? 
            Strings.defaultErrMsg, 401));
      } else {
        return DataFailed(UnknownFailure(Strings.defaultErrMsg, 0));
      }
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrMsg, e.statusCode!));
    } on DioException catch (e) {
      return DataFailed(UnknownFailure(e.toString(), 0));
    } catch (e) {
      return DataFailed(UnknownFailure(e.toString(), 0));
    }
  }

  @override
  ResultFuture<UpdateLeadStatusResponse> updateLeadStatus(
      UpdateLeadStatusRequestModel updateLeadStatusRequestModel) async {
    try {
      final updateLeadStatusResponse =
          await leadApi.updateLeadStatus(updateLeadStatusRequestModel);

      if (updateLeadStatusResponse is UpdateLeadStatusResponseModel) {
        return DataSuccess(updateLeadStatusResponse);
      } else if (updateLeadStatusResponse
          is UpdateLeadStatusErrorResponseModel) {
        return DataFailed(ServerFailure(
            //TODO TBD for what message to show
            //convertLeadToDealResponse.excType ??
            Strings.defaultErrMsg,
            401));
      } else {
        return DataFailed(UnknownFailure(Strings.defaultErrMsg, 0));
      }
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrMsg, e.statusCode!));
    } on DioException catch (e) {
      return DataFailed(UnknownFailure(e.toString(), 0));
    } catch (e) {
      return DataFailed(UnknownFailure(e.toString(), 0));
    }
  }
}