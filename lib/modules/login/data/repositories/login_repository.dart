import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/login/data/services/models/request/login_request_model.dart';
import 'package:crm_mobile_app/modules/login/data/services/models/response/login_response.dart';

abstract class LoginRepository {
  ResultFuture<LoginResponse> login(LoginDataRequestModel loginDataRequestModel);
}