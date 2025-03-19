import 'package:equatable/equatable.dart';

abstract class DropdownEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DropdownChanged extends DropdownEvent {
  final String selectedOption;

  DropdownChanged(this.selectedOption);

  @override
  List<Object?> get props => [selectedOption];
}
