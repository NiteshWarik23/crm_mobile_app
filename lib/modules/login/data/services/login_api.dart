import 'package:crm_mobile_app/config/dio_client/dio_client.dart';
import 'package:crm_mobile_app/core/error/dio_error.dart';
import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:crm_mobile_app/core/utils/apis.dart';
import 'package:crm_mobile_app/modules/login/data/services/models/request/login_request_model.dart';
import 'package:crm_mobile_app/modules/login/data/services/models/response/login_response.dart';
import 'package:dio/dio.dart';

abstract class LoginAPi {
  Future<LoginResponse> login(LoginDataRequestModel loginDataRequestModel);
}

class LoginAPiImpl implements LoginAPi {
  final DioClient dioClient;

  LoginAPiImpl(this.dioClient);

  @override
  Future<LoginResponse> login(
      LoginDataRequestModel loginDataRequestModel) async {
    try {
      final response = await dioClient.dio.post(
        ApiEndPoints.login,
        queryParameters: loginDataRequestModel.toJson(),
      );
      print("Response Code${response.statusCode}");
      if (response.statusCode == 200) {
        return LoginSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return LoginErrorResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      print("Response Code !${e.response!.statusCode}");
      throw handleDioClientError(e);
    }
  }
}
