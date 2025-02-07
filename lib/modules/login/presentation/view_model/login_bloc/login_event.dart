// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginEvent {}

class LoginLoading extends LoginEvent {}

class OnLoginClickEvent extends LoginEvent {
  final String userEmailId;
  final String password;

  OnLoginClickEvent({required this.userEmailId, required this.password});

  @override
  List<Object> get props => [userEmailId, password];
}

class LoginSuccess extends LoginEvent {}

class LoginFailure extends LoginEvent {}

class LoginLogout extends LoginEvent {}

class LoginCheckEvent extends LoginEvent {
  final String userEnteredEmailId;
  final String userEnteredPassword;

  LoginCheckEvent(
      {required this.userEnteredEmailId, required this.userEnteredPassword});

  @override
  List<Object> get props => [userEnteredEmailId, userEnteredPassword];
}

class LoginCheckSuccess extends LoginEvent {}

class LoginCheckFailure extends LoginEvent {}

class LoginCheckLoading extends LoginEvent {}

class LoginCheckLogout extends LoginEvent {}

class LoginCheckInitial extends LoginEvent {}

class LoginCheckUnknown extends LoginEvent {}

class LoginCheckDatabase extends LoginEvent {}
