import 'dart:convert';

import 'package:crm_mobile_app/config/dio_client/dio_client.dart';
import 'package:crm_mobile_app/core/error/dio_error.dart';
import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:crm_mobile_app/core/utils/apis.dart';
import 'package:crm_mobile_app/core/utils/secure_storage.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/convert_lead_to_deal_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/lead_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/request/update_lead_status_request_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/convert_lead_to_deal_response_model.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/lead_response.dart';
import 'package:crm_mobile_app/modules/crm/data/services/models/response/update_lead_status_response_model.dart';
import 'package:dio/dio.dart';

abstract class LeadApi {
  Future<LeadResponse> getLeads(
      OffsetLimitRequestModel offsetLimitRequestModel);
  Future<ConvertLeadToDealResponse> convertLeadToDeal(
      ConvertLeadToDealRequestModel convertLeadToDealRequestModel);
  Future<UpdateLeadStatusResponse> updateLeadStatus(
      UpdateLeadStatusRequestModel updateLeadStatusRequestModel);
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
          // "order_by": 'modified desc',
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

  Future<UpdateLeadStatusResponse> updateLeadStatus(UpdateLeadStatusRequestModel updateLeadStatusRequestModel) async{
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
      print("Response Code${response.statusCode}");
      if (response.statusCode == 200) {
        print("API Error ${response.data.toString()}");
        return UpdateLeadStatusResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return UpdateLeadStatusErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        print("API Error ${response.data.toString()}");
        return UpdateLeadStatusErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }
}
