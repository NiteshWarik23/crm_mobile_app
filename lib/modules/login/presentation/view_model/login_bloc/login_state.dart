import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String username;

  LoginSuccessState({required this.username});

  @override
  List<Object> get props => [username];
}

class LoginFailureState extends LoginState {
  final String errorMessage;

  LoginFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class LoginLogoutState extends LoginState {}

class LoginCheckStatusState extends LoginState {
  final bool buttonStatus;

  LoginCheckStatusState({required this.buttonStatus});

  @override
  List<Object> get props => [buttonStatus];
}

class LoginCheckSuccess extends LoginState {}

class LoginCheckFailure extends LoginState {}

class LoginCheckLoading extends LoginState {}

class LoginCheckLogout extends LoginState {}

class LoginCheckInitial extends LoginState {}

class LoginCheckUnknown extends LoginState {}

class LoginCheckDatabase extends LoginState {}
