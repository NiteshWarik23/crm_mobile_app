import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
   @override
  List<Object> get props => [];
}

class LoginInitial extends LoginEvent {}

class LoginLoading extends LoginEvent {}

class OnLoginClickEvent extends LoginEvent {
  final String userEmailId;
  final String password;

  OnLoginClickEvent(this.userEmailId, this.password);

  @override
  List<Object> get props => [userEmailId, password];
}

class LoginSuccess extends LoginEvent {}

class LoginFailure extends LoginEvent {}

class LoginLogout extends LoginEvent {}

class LoginCheck extends LoginEvent {}

class LoginCheckSuccess extends LoginEvent {}

class LoginCheckFailure extends LoginEvent {}

class LoginCheckLoading extends LoginEvent {}

class LoginCheckLogout extends LoginEvent {}

class LoginCheckInitial extends LoginEvent {}

class LoginCheckUnknown extends LoginEvent {}

class LoginCheckDatabase extends LoginEvent {}
