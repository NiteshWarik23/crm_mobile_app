import 'dart:convert';
import 'package:crm_mobile_app/config/dio_client/dio_client.dart';
import 'package:crm_mobile_app/core/error/dio_error.dart';
import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:crm_mobile_app/core/utils/apis.dart';
import 'package:crm_mobile_app/core/utils/secure_storage.dart';
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
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/search_lead_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class DealApi {
  Future<DealResponse> getDeals(
      OffsetLimitRequestModel offsetLimitRequestModel, String dealFilter);
  Future<UpdateDealStatusResponse> updateDealStatus(
      UpdateDealStatusRequestModel updateDealStatusRequestModel);
  Future<SearchDealResponse> searchDeal(String enteredSearchText);
  Future<DeleteDealResponse> deleteDeal(
      DeleteDealRequestModel deleteDealRequestModel);
  Future<CreateDealResponseModel> createDeal(
      CreateDealRequestModel createDealRequestModel);
  Future<CreateDealTagResponseModel> createDealTag(
      CreateDealTagRequestModel createDealTagRequestModel);
  Future<CreateDealNoteResponseModel> createDealNote(
      CreateDealNoteRequestModel createNoteRequestModel);
  Future<GetDealNotesResponseModel> getDealNotes(
      GetDealNotesRequestModel getDealNotesRequestModel,
      OffsetLimitRequestModel offsetLimitRequestModel);
}

class DealApiImpl implements DealApi {
  final DioClient dioClient;

  DealApiImpl(this.dioClient);

  @override
  Future<DealResponse> getDeals(OffsetLimitRequestModel offsetLimitRequestModel,
      String dealFilter) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      List<dynamic> filters = [];
      if (dealFilter != "all") {
        if (dealFilter == "demoMaking") {
          filters.add(["status", "like", "demo/Making"]);
        } else if (dealFilter == "proposalQuatation") {
          filters.add(["status", "like", "proposal/Quotation"]);
        } else if (dealFilter == "readyToClose") {
          filters.add(["status", "like", "ready to close"]);
        } else {
          filters.add(["status", "=", dealFilter]);
        }
      }

      Uri uri = Uri.parse(ApiEndPoints.deals).replace(
        queryParameters: {
          "fields": jsonEncode([
            'name',
            'owner',
            'creation',
            // 'facebook_campaign',
            // 'meta_platform',
            'first_name',
            'last_name',
            'email',
            'mobile_no',
            'status',
            'communication_status'
          ]),
          // Ensure fields are treated as strings
          "limit_start": offsetLimitRequestModel.limitStart.toString(),
          "limit": offsetLimitRequestModel.limit.toString(),
          "filters": jsonEncode(filters), // Pass filters dynamically
          "order_by": 'modified desc',
          // "filters": jsonEncode([
          //   ["converted", "like", "%0%"]
          // ])
        },
      );
      print("Encoded Filters: ${jsonEncode(filters)}");
      print("Final URL: $uri");
      var headers = {
        'Cookie': 'sid=$sessionID;'
        //daec58a24b6104dc7c54e39b1c3b1a8defff48801ea1fa56a1e05ad7;'
      };
      print("Url String $uri");
      final response = await dioClient.dio.getUri(
        uri,
        options: Options(headers: headers),
      );
      print("Response Code${response.statusCode}");
      if (response.statusCode == 200) {
        print("API Error ${response.data.toString()}");
        // Use compute() to parse JSON in a separate isolate
        //var result = await compute(parseLeadsList, response.data);
        //print(" Compute Result ${result}");
        //return result;
        return DealsListSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return DealsListErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return DealsListErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }

  // ✅ Function running in Isolate
  // LeadResponse parseLeadsList(dynamic responseBody) {
  //   return LeadsListSuccessResponseModel.fromJson(responseBody);
  // }

  @override
  Future<UpdateDealStatusResponse> updateDealStatus(
      UpdateDealStatusRequestModel updateDealStatusRequestModel) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse(ApiEndPoints.updateLeadStatus);
      var headers = {
        'Cookie': 'sid=$sessionID;'
        //daec58a24b6104dc7c54e39b1c3b1a8defff48801ea1fa56a1e05ad7;'
      };
      final response = await dioClient.dio.postUri(
        uri,
        data: updateDealStatusRequestModel.toJson(),
        options: Options(headers: headers),
      );
      print("Response Code--->${response.statusCode}");
      if (response.statusCode == 200) {
        print("API Error 1${response.data.toString()}");
        return UpdateDealStatusResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error 2 ${response.data.toString()}");
        return UpdateDealStatusErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error 3 ${response.data.toString()}");
        return UpdateDealStatusErrorResponseModel.fromJson(response.data);
      } else {
        print("object44");

        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code 2 !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }

  @override
  Future<SearchDealResponse> searchDeal(String enteredSearchText) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse(ApiEndPoints.leads).replace(
        queryParameters: {
          "filters": jsonEncode([
            ["name", "like", "%$enteredSearchText%"]
          ]),
          // Ensure fields are treated as strings
          "fields": jsonEncode([
            'name',
            'owner',
            'creation',
            'facebook_campaign',
            'meta_platform',
            'first_name',
            'last_name',
            'email',
            'mobile_no',
            'status',
            'communication_status'
          ]),
        },
      );
      var headers = {'Cookie': 'sid=$sessionID;'};
      print("Url String $uri");
      final response = await dioClient.dio.getUri(
        uri,
        options: Options(headers: headers),
      );
      print("Response Code${response.statusCode}");
      if (response.statusCode == 200) {
        print("API Error ${response.data.toString()}");
        // Use compute() to parse JSON in a separate isolate
        //return compute(parseLeads, response.data);
        return SearchDealSuccesssResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return SearchDealErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return SearchDealErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }

  // ✅ Function running in Isolate
  SearchLeadResponse parseLeads(dynamic responseBody) {
    return SearchLeadSuccesssResponseModel.fromJson(responseBody);
  }

  @override
  Future<DeleteDealResponse> deleteDeal(
      DeleteDealRequestModel deleteLeadRequestModel) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse(ApiEndPoints.deleteLead);
      var headers = {
        'Cookie': 'sid=$sessionID;'
        //daec58a24b6104dc7c54e39b1c3b1a8defff48801ea1fa56a1e05ad7;'
      };
      final response = await dioClient.dio.deleteUri(
        uri,
        data: deleteLeadRequestModel.toJson(),
        options: Options(headers: headers),
      );
      print("Response Code${response.statusCode}");
      if (response.statusCode == 200) {
        print("API Error ${response.data.toString()}");
        return DeleteDealSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return DeleteDealErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return DeleteDealErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }

  @override
  Future<CreateDealResponseModel> createDeal(
      CreateDealRequestModel createDealRequestModel) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse(ApiEndPoints.deals);
      var headers = {
        'Cookie': 'sid=$sessionID;'
        //daec58a24b6104dc7c54e39b1c3b1a8defff48801ea1fa56a1e05ad7;'
      };
      var formData = FormData.fromMap({
        //'salutation': createLeadRequestModel.salutation,
        'first_name': createDealRequestModel.firstname,
        'last_name': createDealRequestModel.lastname,
        'email': createDealRequestModel.email,
        'mobile_no': createDealRequestModel.contact,
        'organization': createDealRequestModel.organization,
        'website': createDealRequestModel.website,
        //'creation': date,
      });

      print("Form Data: ${formData.fields}");

      final response = await dioClient.dio.postUri(
        uri,
        data: formData, //createLeadRequestModel.toFormData(),
        options: Options(headers: headers),
      );
      print("Response Code${response.statusCode}");
      if (response.statusCode == 200) {
        print("API Error ${response.data.toString()}");
        return CreateDealSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return CreateDealErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return CreateDealErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }

  @override
  Future<CreateDealTagResponseModel> createDealTag(
      CreateDealTagRequestModel createDealTagRequestModel) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse(ApiEndPoints.createTag);
      var headers = {'Cookie': 'sid=$sessionID;'};
      var formData = FormData.fromMap({
        'tag': createDealTagRequestModel.tag,
        'dt': createDealTagRequestModel.dt,
        'dn': createDealTagRequestModel.dn,
      });

      print("Form Data: ${formData.fields}");

      final response = await dioClient.dio.postUri(
        uri,
        data: formData, //createLeadRequestModel.toFormData(),
        options: Options(headers: headers),
      );
      print("Response Code${response.statusCode}");
      if (response.statusCode == 200) {
        print("API Error ${response.data.toString()}");
        return CreateDealTagSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return CreateDealTagErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return CreateDealTagErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }

  @override
  Future<CreateDealNoteResponseModel> createDealNote(
      CreateDealNoteRequestModel createNoteRequestModel) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse(ApiEndPoints.createNote);
      var headers = {'Cookie': 'sid=$sessionID;'};
      final response = await dioClient.dio.postUri(
        uri,
        data: createNoteRequestModel.toJson(),
        options: Options(headers: headers),
      );
      print("Response Code--->${response.statusCode}");
      if (response.statusCode == 200) {
        print("API Error 1${response.data.toString()}");
        return CreateDealNoteSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        if (kDebugMode) {
          print("API Error 2 ${response.data.toString()}");
        }
        return CreateDealNoteErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error 3 ${response.data.toString()}");
        return CreateDealNoteErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code 2 !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }

  @override
  Future<GetDealNotesResponseModel> getDealNotes(
      GetDealNotesRequestModel getNotesRequestModel,
      OffsetLimitRequestModel offsetLimitRequestModel) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse(ApiEndPoints.getNotes).replace(
        queryParameters: {
          "fields": jsonEncode(['*']),
          "filters": jsonEncode([
            ["reference_doctype", "=", "CRM Deal"],
            [
              "reference_docname",
              "=",
              getNotesRequestModel.referenceDocname.toString()
            ]
          ]),
          "limit_start": offsetLimitRequestModel.limitStart.toString(),
          "limit": offsetLimitRequestModel.limit.toString(),
        },
      );
      var headers = {'Cookie': 'sid=$sessionID;'};
      print("Url String $uri");
      final response = await dioClient.dio.getUri(
        uri,
        options: Options(headers: headers),
      );
      print("Response Code${response.statusCode}");
      if (response.statusCode == 200) {
        print("API Error ${response.data.toString()}");
        // Use compute() to parse JSON in a separate isolate
        //var result = await compute(parseLeadsList, response.data);
        //print(" Compute Result ${result}");
        //return result;
        return GetDealNotesSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return GetDealNotesErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return GetDealNotesErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }
}
