import 'package:crm_mobile_app/core/usecase/usecase.dart';
import 'package:crm_mobile_app/core/utils/type_def.dart';
import 'package:crm_mobile_app/modules/login/data/repositories/login_repository.dart';
import 'package:crm_mobile_app/modules/login/data/services/models/request/login_request_model.dart';
import 'package:crm_mobile_app/modules/login/data/services/models/response/login_response.dart';
import 'package:equatable/equatable.dart';

class LoginUsecase
    implements
        UsecaseWithParams<LoginResponse, LoginDataRequestParams> {
  final LoginRepository loginRepository;
  LoginUsecase(this.loginRepository);

  @override
  ResultFuture<LoginResponse> call(params) async {
    return await loginRepository
        .login(params.loginDataRequestModel);
  }
}

class LoginDataRequestParams extends Equatable {
  final LoginDataRequestModel loginDataRequestModel;

  const LoginDataRequestParams({required this.loginDataRequestModel});

  @override
  List<Object> get props => [loginDataRequestModel];
}
