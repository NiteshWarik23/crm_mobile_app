import 'package:flutter_bloc/flutter_bloc.dart';
import 'dropdown_event.dart';
import 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(const DropdownState()) {
    on<DropdownChanged>((event, emit) {
      emit(state.copyWith(selectedOption: event.selectedOption));
    });
  }
}
