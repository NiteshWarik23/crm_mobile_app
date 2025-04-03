import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:crm_mobile_app/core/error/failure.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/core/utils/strings.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/repositories/deal_repository.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/deal_api.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/create_deal_note_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/create_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/create_deal_tag_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/delete_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/get_deal_notes_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/request/update_deal_status_request_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/create_deal_note_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/create_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/create_deal_tag_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/deal_response.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/delete_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/get_deal_notes_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/search_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/models/response/update_deal_status_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/lead_response.dart';
import 'package:dio/dio.dart';

class DealRepositoryImpl implements DealRepository {
  final DealApi dealApi;
  DealRepositoryImpl(this.dealApi);

  @override
  ResultFuture<DealResponse> getDeals(
      OffsetLimitRequestModel offsetLimitRequestModel) async {
    try {
      final dealResponse = await dealApi.getDeals(offsetLimitRequestModel);

      if (dealResponse is DealsListSuccessResponseModel) {
        return DataSuccess(dealResponse);
      } else if (dealResponse is DealsListErrorResponseModel) {
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
  ResultFuture<UpdateDealStatusResponse> updateDealStatus(
      UpdateDealStatusRequestModel updateDealStatusRequestModel) async {
    try {
      final updateDealStatusResponse =
          await dealApi.updateDealStatus(updateDealStatusRequestModel);
      if (updateDealStatusResponse is UpdateDealStatusResponseModel) {
        return DataSuccess(updateDealStatusResponse);
      } else if (updateDealStatusResponse
          is UpdateDealStatusErrorResponseModel) {
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
  ResultFuture<SearchDealResponse> searchDeals(String enteredSearchText) async {
    try {
      final dealResponse = await dealApi.searchDeal(enteredSearchText);

      if (dealResponse is SearchDealSuccesssResponseModel) {
        return DataSuccess(dealResponse);
      } else if (dealResponse is SearchDealErrorResponseModel) {
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
  ResultFuture<DeleteDealResponse> deleteDeal(
      DeleteDealRequestModel deleteDealRequestModel) async {
    try {
      final deleteDealResponse =
          await dealApi.deleteDeal(deleteDealRequestModel);

      if (deleteDealResponse is DeleteDealSuccessResponseModel) {
        return DataSuccess(deleteDealResponse);
      } else if (deleteDealResponse
          is DeleteDealErrorResponseModel) {
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
  ResultFuture<CreateDealResponseModel> createDeal(
      CreateDealRequestModel createDealRequestModel) async {
    try {
      final createDealResponse =
          await dealApi.createDeal(createDealRequestModel);

      if (createDealResponse is CreateDealSuccessResponseModel) {
        return DataSuccess(createDealResponse);
      } else if (createDealResponse
          is CreateDealErrorResponseModel) {
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
  ResultFuture<CreateDealTagResponseModel> createDealTag(
      CreateDealTagRequestModel createDealTagRequestModel) async {
    try {
      final createDealTagResponse =
          await dealApi.createDealTag(createDealTagRequestModel);

      if (createDealTagResponse is CreateDealTagSuccessResponseModel) {
        return DataSuccess(createDealTagResponse);
      } else if (createDealTagResponse is CreateDealTagErrorResponseModel) {
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
  ResultFuture<CreateDealNoteResponseModel> createDealNote(
      CreateDealNoteRequestModel createDealNoteRequestModel) async {
    try {
      final createDealNoteRespone =
          await dealApi.createDealNote(createDealNoteRequestModel);
      if (createDealNoteRespone is CreateDealNoteSuccessResponseModel) {
        return DataSuccess(createDealNoteRespone);
      } else if (createDealNoteRespone
          is CreateDealNoteErrorResponseModel) {
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
  ResultFuture<GetDealNotesResponseModel> getDealNotes(
      GetDealNotesRequestModel getDealNotesRequestModel,
      OffsetLimitRequestModel offsetLimitRequestModel) async {
    try {
      final getDealNotesResponse = await dealApi.getDealNotes(getDealNotesRequestModel, offsetLimitRequestModel);

      if (getDealNotesResponse is GetDealNotesSuccessResponseModel) {
        return DataSuccess(getDealNotesResponse);
      } else if (getDealNotesResponse is GetDealNotesErrorResponseModel) {
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
}

