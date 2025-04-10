import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:crm_mobile_app/core/error/failure.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/core/utils/strings.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/login/data/repositories/login_repository.dart';
import 'package:crm_mobile_app/modules/login/data/services/login_api.dart';
import 'package:crm_mobile_app/modules/login/data/services/models/request/login_request_model.dart';
import 'package:crm_mobile_app/modules/login/data/services/models/response/login_response.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginAPi loginAPi;

  LoginRepositoryImpl(this.loginAPi);

  @override
  ResultFuture<LoginResponse> login(
      LoginDataRequestModel loginDataRequestModel) async {
    try {
      // Fluttertoast.showToast(msg: "Login Response Error 1");
      //       Fluttertoast.showToast(
      //     msg: "Login Response Error ${loginDataRequestModel.usr.toString()} ${loginDataRequestModel.pwd.toString()}");

      final authLoginResponse = await loginAPi.login(loginDataRequestModel);
      // Fluttertoast.showToast(
      //     msg: "Login Response Error ${authLoginResponse.toString()}");

      if (authLoginResponse is LoginSuccessResponseModel) {
        return DataSuccess(authLoginResponse);
      } else if (authLoginResponse is LoginErrorResponseModel) {
        // Fluttertoast.showToast(
        //     msg: "Reponse Repo Error ${authLoginResponse.message.toString()}");

        return DataFailed(ServerFailure(
            authLoginResponse.message ?? Strings.defaultErrMsg, 401));
      } else {
        // Fluttertoast.showToast(
        //     msg: "Unknown 1 API Error ${Strings.defaultErrMsg}");

        return DataFailed(UnknownFailure(Strings.defaultErrMsg, 0));
      }
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrMsg, e.statusCode!));
    } on DioException catch (e) {
      // Fluttertoast.showToast(
      //     msg: "Unknown 2 API Error ${Strings.defaultErrMsg}");

      return DataFailed(UnknownFailure(e.toString(), 0));
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Unknown 3 API Error ${e.toString()}");

      return DataFailed(UnknownFailure(e.toString(), 0));
    }
  }
}
