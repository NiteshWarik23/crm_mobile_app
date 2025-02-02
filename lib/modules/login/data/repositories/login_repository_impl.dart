import 'package:crm_mobile_app/core/error/exception.dart';
import 'package:crm_mobile_app/core/error/failure.dart';
import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/core/utils/strings.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/login/data/repositories/login_repository.dart';
import 'package:crm_mobile_app/modules/login/data/services/login_api.dart';
import 'package:crm_mobile_app/modules/login/data/services/models/request/login_request_model.dart';
import 'package:crm_mobile_app/modules/login/data/services/models/response/login_response.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginAPi loginAPi;

  LoginRepositoryImpl(this.loginAPi);

  @override
  ResultFuture<LoginResponse> login(
      LoginDataRequestModel loginDataRequestModel) async {
    try {
      final authLoginResponse = await loginAPi.login(loginDataRequestModel);
      
      if (authLoginResponse is LoginSuccessResponseModel) {
        return DataSuccess(authLoginResponse);
      } else if (authLoginResponse is LoginErrorResponseModel) {
        return DataFailed(ServerFailure(
            authLoginResponse.message ?? Strings.defaultErrMsg, 401));
      } else {
        return DataFailed(UnknownFailure(Strings.defaultErrMsg, 0));
      }
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(UnknownFailure(e.toString(), 0));
    }
  }
}
