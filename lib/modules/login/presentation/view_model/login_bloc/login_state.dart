abstract class LoginState {}

class LoginInitialState extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {}
class LoginFailureState extends LoginState {}
class LoginLogoutState extends LoginState {}
class LoginCheck extends LoginState {}
class LoginCheckSuccess extends LoginState {}
class LoginCheckFailure extends LoginState {}
class LoginCheckLoading extends LoginState {}
class LoginCheckLogout extends LoginState {}
class LoginCheckInitial extends LoginState {}
class LoginCheckUnknown extends LoginState {}
class LoginCheckDatabase extends LoginState {}
