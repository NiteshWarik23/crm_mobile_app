// Events
import 'package:equatable/equatable.dart';

abstract class BottomNavEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateIndex extends BottomNavEvent {
  final int index;
  UpdateIndex(this.index);

  @override
  List<Object> get props => [index];
}
