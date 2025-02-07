// States
abstract class BottomNavState {}

class BottomNavInitial extends BottomNavState {
  final int index;
  BottomNavInitial(this.index);
}

class BottomNavUpdatedState extends BottomNavState {
  final int index;
  BottomNavUpdatedState(this.index);
}
