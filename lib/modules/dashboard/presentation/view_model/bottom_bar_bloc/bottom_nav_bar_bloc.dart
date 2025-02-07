// Bloc
import 'package:crm_mobile_app/modules/dashboard/presentation/view_model/bottom_bar_bloc/bottom_nav_bar_event.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view_model/bottom_bar_bloc/bottom_nav_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavInitial(0)) {
    on<UpdateIndex>(mapEventToState);
  }

  void mapEventToState(BottomNavEvent event, Emitter<BottomNavState> emit) {
    if (event is UpdateIndex) {
      emit(BottomNavUpdatedState(event.index));
    }
  }
}
