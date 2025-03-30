import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:crm_mobile_app/core/error/failure.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/core/utils/strings.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/data/services/lead_api.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/convert_lead_to_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/create_lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/create_tag_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/delete_lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/update_lead_status_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/convert_lead_to_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/create_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/create_tag_response_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/delete_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/lead_response.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/search_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/update_lead_status_response_model.dart';
import 'package:dio/dio.dart';

class LeadRepositoryImpl implements LeadRepository {
  final LeadApi leadApi;
  LeadRepositoryImpl(this.leadApi);

  @override
  ResultFuture<LeadResponse> getLeads(
      OffsetLimitRequestModel offsetLimitRequestModel) async {
    try {
      final leadResponse = await leadApi.getLeads(offsetLimitRequestModel);

      if (leadResponse is LeadsListSuccessResponseModel) {
        return DataSuccess(leadResponse);
      } else if (leadResponse is LeadsListErrorResponseModel) {
        return DataFailed(ServerFailure(
            //TODO TBD for what message to show
            //leadResponse.exc ??
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

  @override
  ResultFuture<ConvertLeadToDealResponse> convertLeadToDeal(
      ConvertLeadToDealRequestModel convertLeadToDealRequestModel) async {
    try {
      final convertLeadToDealResponse =
          await leadApi.convertLeadToDeal(convertLeadToDealRequestModel);

      if (convertLeadToDealResponse is ConvertLeadToDealResponseModel) {
        return DataSuccess(convertLeadToDealResponse);
      } else if (convertLeadToDealResponse
          is ConvertLeadToDealErrorResponseModel) {
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
        return DataFailed(ServerFailure(Strings.defaultErrMsg, 401));
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
  ResultFuture<SearchLeadResponse> searchLeads(String enteredSearchText) async {
    try {
      final leadResponse = await leadApi.searchLead(enteredSearchText);

      if (leadResponse is SearchLeadSuccesssResponseModel) {
        return DataSuccess(leadResponse);
      } else if (leadResponse is SearchLeadErrorResponseModel) {
        return DataFailed(ServerFailure(
            //TODO TBD for what message to show
            //leadResponse.exc ??
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


  
  @override
  ResultFuture<DeleteLeadResponse> deleteLead(
      DeleteLeadRequestModel deleteLeadRequestModel) async {
    try {
      final deleteLeadResponse =
          await leadApi.deleteLead(deleteLeadRequestModel);

      if (deleteLeadResponse is DeleteLeadSuccessResponseModel) {
        return DataSuccess(deleteLeadResponse);
      } else if (deleteLeadResponse
          is DeleteLeadErrorResponseModel) {
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

  
  @override
  ResultFuture<CreateLeadResponseModel> createLead(
      CreateLeadRequestModel createleadRequestModel) async {
    try {
      final createLeadResponse =
          await leadApi.createLead(createleadRequestModel);

      if (createLeadResponse is CreateLeadSuccessResponseModel) {
        return DataSuccess(createLeadResponse);
      } else if (createLeadResponse
          is CreateLeadErrorResponseModel) {
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


   @override
  ResultFuture<CreateTagResponseModel> createLeadTag(
      CreateTagRequestModel createTagRequestModel) async {
    try {
      final createTagResponse =
          await leadApi.createLeadTag(createTagRequestModel);

      if (createTagResponse is CreateTagSuccessResponseModel) {
        return DataSuccess(createTagResponse);
      } else if (createTagResponse is CreateTagErrorResponseModel) {
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

