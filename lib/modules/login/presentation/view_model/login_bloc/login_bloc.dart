import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/modules/login/data/services/models/request/login_request_model.dart';
import 'package:crm_mobile_app/modules/login/data/services/models/response/login_response.dart';
import 'package:crm_mobile_app/modules/login/domain/usecase/login_usecase.dart';
import 'package:crm_mobile_app/modules/login/presentation/view_model/login_bloc/login_event.dart';
import 'package:crm_mobile_app/modules/login/presentation/view_model/login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  LoginBloc(this.loginUsecase) : super(LoginInitialState()) {
    on<OnLoginClickEvent>(onLoginClick);
  }

  Future<void> onLoginClick(
      OnLoginClickEvent event, Emitter<LoginState> emit) async {
    if (event.userEmailId.isNotEmpty && event.password.isNotEmpty) {
      emit(LoginLoadingState());
      LoginDataRequestModel loginDataRequestModel = LoginDataRequestModel(usr: event.userEmailId, pwd: event.password);
      final DataState<LoginResponse> loginResponse = await loginUsecase.call(LoginDataRequestParams(loginDataRequestModel: loginDataRequestModel));

      if(loginResponse is DataSuccess){}
    }
  }
  
}
