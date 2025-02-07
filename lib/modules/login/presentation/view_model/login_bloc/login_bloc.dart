import 'package:crm_mobile_app/core/utils/data_state.dart';
import 'package:crm_mobile_app/core/utils/strings.dart';
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
    on<LoginCheckEvent>(loginButtonStatus);
  }

  Future<void> onLoginClick(
      OnLoginClickEvent event, Emitter<LoginState> emit) async {
    if (event.userEmailId.isNotEmpty && event.password.isNotEmpty) {
      print("onLoginClick triggered"); // Debugging

      emit(LoginLoadingState());
      print("Emitting: LoginLoadingState");

      LoginDataRequestModel loginDataRequestModel =
          LoginDataRequestModel(usr: event.userEmailId, pwd: event.password);

      final DataState<LoginResponse> loginResponse = await loginUsecase.call(
          LoginDataRequestParams(loginDataRequestModel: loginDataRequestModel));

      if (loginResponse is DataSuccess) {
        final loginSuccessReponseData = loginResponse.data;
        if (loginSuccessReponseData is LoginSuccessResponseModel) {
          print("Success Response ${loginSuccessReponseData}");
          print("Success Response ${loginSuccessReponseData.message}");
          print("Success Response ${loginSuccessReponseData.homePage}");
          print("Success Response ${loginSuccessReponseData.fullName}");
          print("Emitting: LoginSuccessState");

          emit(LoginSuccessState(
              username: loginSuccessReponseData.fullName ?? ""));
        }
      } else if (loginResponse is DataFailed) {
        print("Error 1 $loginResponse");
        print("Error 2  ${loginResponse.error!.message}");
        print("object Error ${loginResponse.data}");
        final loginErrorReponseData = loginResponse.data;
        //if (loginErrorReponseData is LoginErrorResponseModel) {
        print("Error 3 $loginErrorReponseData");
        //print("Login Error Message ${loginErrorReponseData.message}");
        print("Emitting: LoginFailureState");
        emit(LoginFailureState(
            errorMessage:
                loginResponse.error!.message ?? Strings.defaultErrMsg));
        // }
      }
    }
  }

  Future<void> loginButtonStatus(
      LoginCheckEvent event, Emitter<LoginState> emit) async {
    if (event.userEnteredEmailId.isNotEmpty &&
        event.userEnteredPassword.isNotEmpty) {
      emit(LoginCheckStatusState(buttonStatus: true));
    } else {
      emit(LoginCheckStatusState(buttonStatus: false));
    }
  }
}
