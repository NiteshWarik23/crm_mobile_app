import 'package:equatable/equatable.dart';

abstract class CreateDealTagState extends Equatable{
  @override
  List<Object> get props => [];
}

class CreateDealTagInitialState extends CreateDealTagState {}
class CreateDealTagLoadingState extends CreateDealTagState {}
class CreateDealTagSuccessState extends CreateDealTagState {}
class CreateDealTagFailureState extends CreateDealTagState {}