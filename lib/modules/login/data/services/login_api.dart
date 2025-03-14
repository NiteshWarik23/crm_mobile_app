import 'package:crm_mobile_app/config/dio_client/dio_client.dart';
import 'package:crm_mobile_app/core/error/dio_error.dart';
import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:crm_mobile_app/core/utils/apis.dart';
import 'package:crm_mobile_app/core/utils/secure_storage.dart';
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
        //String? cookies = response.headers['set-cookie']?.first;

        //To Fetch Session Id and store it in Secure Storage.
        //*********************Start*******************/
        // To store set-cookie.
        List<String>? cookies = response.headers['set-cookie'];
        // To find sid cookie from the list of cokies and store it in a variable
        String? sidCookie = cookies?.firstWhere(
          (cookie) => cookie.startsWith('sid='),
          orElse: () => '',
        );
        print("Sid $sidCookie");
        // To check the stored sid value is not null and not empty and store it in Secure Storage
        if (sidCookie != null && sidCookie.isNotEmpty) {
          String sessionId = sidCookie.split('sid=')[1].split(';')[0];

          await SecureStorage.instance
              .writeSecureData(SecureStorageKeys.sid_cookie, sessionId);
        }
        //*************************End*******************/

        return LoginSuccessResponseModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("API Error ${response.data.toString()}");
        return LoginErrorResponseModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
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
