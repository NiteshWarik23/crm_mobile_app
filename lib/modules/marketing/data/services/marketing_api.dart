import 'dart:convert';

import 'package:crm_mobile_app/config/dio_client/dio_client.dart';
import 'package:crm_mobile_app/core/error/dio_error.dart';
import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:crm_mobile_app/core/utils/apis.dart';
import 'package:crm_mobile_app/core/utils/secure_storage.dart';
import 'package:crm_mobile_app/modules/marketing/data/services/models/response/campaign_details_response_model.dart';
import 'package:crm_mobile_app/modules/marketing/data/services/models/response/get_campaigns_response_model.dart';
import 'package:dio/dio.dart';

abstract class MarketingApi {
  Future<GetCampaignsResponseModel> getCampaigns();
  Future<CampaignDetailsResponseModel> getCampaignDetails(String campaignId);
}

class MarketingApiImpl implements MarketingApi {
  final DioClient dioClient;

  MarketingApiImpl(this.dioClient);

  @override
  Future<GetCampaignsResponseModel> getCampaigns() async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);
    //print("Session ID Lead API  $sessionID");
    if (sessionID == null || sessionID.isEmpty) {
      //print("Server Expection thrown ");

      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse(ApiEndPoints.getCampaigns).replace(
        queryParameters: {
          "fields": jsonEncode([
            '*',
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
        //print("API Error ${response.data.toString()}");
        //TODO: To Add Error Response Model
        return GetCampaignsSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401 || response.statusCode == 500) {
        //print("API Error ${response.data.toString()}");
        final errorJson = response.data;
        return GetCampaignsErrorResponseModel.fromJson({
          "error_message": errorJson["error_message"] ?? "Something went wrong",
        });
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      //print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    } catch (e) {
      // Any unexpected error
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CampaignDetailsResponseModel> getCampaignDetails(
      String campaignId) async {
    String? sessionID = await SecureStorage.instance
        .readSecureData(SecureStorageKeys.sid_cookie);
    //print("Session ID Lead API  $sessionID");
    if (sessionID == null || sessionID.isEmpty) {
      //print("Server Expection thrown ");

      throw ServerException("Session ID is null or empty");
    }
    try {
      Uri uri = Uri.parse('${ApiEndPoints.getCampaigns}/$campaignId').replace(
        queryParameters: {
          "fields": jsonEncode([
            '*',
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
        //print("API Error ${response.data.toString()}");
        //TODO: To Add Error Response Model
        return CampaignDetailsSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401 || response.statusCode == 500) {
        //print("API Error ${response.data.toString()}");
        final errorJson = response.data;
        return CampaignsDetailsErrorResponseModel.fromJson({
          "error_message": errorJson["error_message"] ?? "Something went wrong",
        });
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      //print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    } catch (e) {
      // Any unexpected error
      throw ServerException(e.toString());
    }
  }
}
