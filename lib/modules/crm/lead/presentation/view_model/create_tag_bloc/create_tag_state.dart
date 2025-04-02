import 'package:equatable/equatable.dart';

abstract class CreateTagState extends Equatable{
  @override
  List<Object> get props => [];
}

class CreateTagInitialState extends CreateTagState{}
class CreateTagLoadingState extends CreateTagState{}
class CreateTagSuccessState extends CreateTagState{}
class CreateTagFailureState extends CreateTagState{}