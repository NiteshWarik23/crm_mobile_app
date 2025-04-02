import 'package:equatable/equatable.dart';

class DropdownState extends Equatable {
  final String selectedOption;

  const DropdownState({this.selectedOption = ''});

  DropdownState copyWith({String? selectedOption}) {
    return DropdownState(
      selectedOption: selectedOption ?? this.selectedOption,
    );
  }

  @override
  List<Object?> get props => [selectedOption];
}
