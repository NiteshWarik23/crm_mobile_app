import 'dart:convert';

import 'package:crm_mobile_app/config/dio_client/dio_client.dart';
import 'package:crm_mobile_app/core/error/dio_error.dart';
import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:crm_mobile_app/core/utils/apis.dart';
import 'package:crm_mobile_app/core/utils/secure_storage.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/convert_lead_to_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/create_lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/create_note_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/create_tag_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/delete_lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/get_notes_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/request/update_lead_status_request_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/convert_lead_to_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/create_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/create_note_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/create_tag_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/delete_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/get_notes_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/lead_response.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/search_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/update_lead_status_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class LeadApi {
  Future<LeadResponse> getLeads(
      OffsetLimitRequestModel offsetLimitRequestModel);
  Future<ConvertLeadToDealResponse> convertLeadToDeal(
      ConvertLeadToDealRequestModel convertLeadToDealRequestModel);
  Future<UpdateLeadStatusResponse> updateLeadStatus(
      UpdateLeadStatusRequestModel updateLeadStatusRequestModel);
  Future<SearchLeadResponse> searchLead(String enteredSearchText);
  Future<DeleteLeadResponse> deleteLead(
      DeleteLeadRequestModel deleteLeadRequestModel);
  Future<CreateLeadResponseModel> createLead(
      CreateLeadRequestModel createLeadRequestModel);
   Future<CreateTagResponseModel> createLeadTag(
      CreateTagRequestModel createTagRequestModel);
    Future<CreateNoteResponseModel> createNote(
      CreateNoteRequestModel createNoteRequestModel);
    Future<GetNotesResponseModel> getNotes(
      GetNotesRequestModel getNotesRequestModel,
      OffsetLimitRequestModel offsetLimitRequestModel);
}

class LeadApiImpl implements LeadApi {
  final DioClient dioClient;

  LeadApiImpl(this.dioClient);

  @override
  Future<LeadResponse> getLeads(
      OffsetLimitRequestModel offsetLimitRequestModel) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      // LeadsQueryParamsRequestModel leadsQueryParamsRequestModel =
      //     LeadsQueryParamsRequestModel(fields: [
      //   "name",
      //   "owner",
      //   "creation",
      //   "facebook_campaign",
      //   "meta_platform",
      //   "first_name",
      //   "last_name",
      //   "email",
      //   "mobile_no",
      //   "status",
      //   "communication_status"
      // ]);
      // //Using ... merges both maps into a single map
      // Map<String, dynamic> queryParams = {
      //   //...leadsQueryParamsRequestModel.toJson(),
      //   "fields": [
      //     "name",
      //     "owner",
      //     "creation",
      //     "facebook_campaign",
      //     "meta_platform",
      //     "first_name",
      //     "last_name",
      //     "email",
      //     "mobile_no",
      //     'status',
      //     'communication_status'
      //   ],
      //   "limit_start": offsetLimitRequestModel.limitStart,
      //   "limit": offsetLimitRequestModel.limit,
      //   //...offsetLimitRequestModel.toJson(),
      // };

      Uri uri = Uri.parse(ApiEndPoints.leads).replace(
        queryParameters: {
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
          // Ensure fields are treated as strings
          "limit_start": offsetLimitRequestModel.limitStart.toString(),
          "limit": offsetLimitRequestModel.limit.toString(),
          "order_by": 'modified desc',
          "filters": jsonEncode([
            ["converted", "like", "%0%"]
          ])
        },
      );
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
        return LeadsListSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return LeadsListErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return LeadsListErrorResponseModel.fromJson(response.data);
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
  Future<ConvertLeadToDealResponse> convertLeadToDeal(
      ConvertLeadToDealRequestModel convertLeadToDealRequestModel) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse(ApiEndPoints.convertLeadToDeal);
      var headers = {
        'Cookie': 'sid=$sessionID;'
        //daec58a24b6104dc7c54e39b1c3b1a8defff48801ea1fa56a1e05ad7;'
      };
      final response = await dioClient.dio.postUri(
        uri,
        data: convertLeadToDealRequestModel.toJson(),
        options: Options(headers: headers),
      );
      print("Response Code${response.statusCode}");
      if (response.statusCode == 200) {
        print("API Error ${response.data.toString()}");
        return ConvertLeadToDealResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return ConvertLeadToDealErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return ConvertLeadToDealErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }

  @override
  Future<UpdateLeadStatusResponse> updateLeadStatus(
      UpdateLeadStatusRequestModel updateLeadStatusRequestModel) async {
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
        data: updateLeadStatusRequestModel.toJson(),
        options: Options(headers: headers),
      );
      print("Response Code--->${response.statusCode}");
      if (response.statusCode == 200) {
        print("API Error 1${response.data.toString()}");
        return UpdateLeadStatusResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error 2 ${response.data.toString()}");
        return UpdateLeadStatusErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error 3 ${response.data.toString()}");
        return UpdateLeadStatusErrorResponseModel.fromJson(response.data);
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
  Future<SearchLeadResponse> searchLead(String enteredSearchText) async {
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
        return SearchLeadSuccesssResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return SearchLeadErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return SearchLeadErrorResponseModel.fromJson(response.data);
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
  Future<DeleteLeadResponse> deleteLead(
      DeleteLeadRequestModel deleteLeadRequestModel) async {
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
        return DeleteLeadSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return DeleteLeadErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return DeleteLeadErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }

  @override
  Future<CreateLeadResponseModel> createLead(
      CreateLeadRequestModel createLeadRequestModel) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse(ApiEndPoints.leads);
      var headers = {
        'Cookie': 'sid=$sessionID;'
        //daec58a24b6104dc7c54e39b1c3b1a8defff48801ea1fa56a1e05ad7;'
      };
      var formData = FormData.fromMap({
        //'salutation': createLeadRequestModel.salutation,
        'first_name': createLeadRequestModel.firstname,
        'last_name': createLeadRequestModel.lastname,
        'email': createLeadRequestModel.email,
        'mobile_no': createLeadRequestModel.contact,
        'organization': createLeadRequestModel.organization,
        'website': createLeadRequestModel.website,
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
        return CreateLeadSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return CreateLeadErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return CreateLeadErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }


  
  @override
  Future<CreateTagResponseModel> createLeadTag(
      CreateTagRequestModel createTagRequestModel) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse(ApiEndPoints.createTag);
      var headers = {
        'Cookie': 'sid=$sessionID;'
      };
      var formData = FormData.fromMap({
        'tag': createTagRequestModel.tag,
        'dt': createTagRequestModel.dt,
        'dn': createTagRequestModel.dn,
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
        return CreateTagSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return CreateTagErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return CreateTagErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }


  @override
  Future<CreateNoteResponseModel> createNote(
      CreateNoteRequestModel createNoteRequestModel) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse(ApiEndPoints.createNote);
      var headers = {
        'Cookie': 'sid=$sessionID;'
        //daec58a24b6104dc7c54e39b1c3b1a8defff48801ea1fa56a1e05ad7;'
      };
      final response = await dioClient.dio.postUri(
        uri,
        data: createNoteRequestModel.toJson(),
        options: Options(headers: headers),
      );
      print("Response Code--->${response.statusCode}");
      if (response.statusCode == 200) {
        print("API Error 1${response.data.toString()}");
        return CreateNoteSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error 2 ${response.data.toString()}");
        return CreateNoteErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error 3 ${response.data.toString()}");
        return CreateNoteErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code 2 !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }

  @override
  Future<GetNotesResponseModel> getNotes(
      GetNotesRequestModel getNotesRequestModel,
      OffsetLimitRequestModel offsetLimitRequestModel) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);

    if (sessionID == null || sessionID.isEmpty) {
      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse(ApiEndPoints.getNotes).replace(
        queryParameters: {
          "fields": jsonEncode([
           '*'
          ]),
          "filters": jsonEncode([
            ["reference_doctype", "=", "CRM Lead"],
            ["reference_docname", "=", getNotesRequestModel.referenceDocname.toString()]
          ]),
           "limit_start": offsetLimitRequestModel.limitStart.toString(),
          "limit": offsetLimitRequestModel.limit.toString(),
        },
      );
      var headers = {
        'Cookie': 'sid=$sessionID;'
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
        return GetNotesSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return GetNotesErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return GetNotesErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }

}
