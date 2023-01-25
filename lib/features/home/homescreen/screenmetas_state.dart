abstract class ScreenHomeState {}

class ScreenHomeInitialState implements ScreenHomeState {}

class ScreenHomeSuccessState implements ScreenHomeState {
  late final double sumBalance;
  ScreenHomeSuccessState(this.sumBalance);

}

class ScreenHomeErrorState implements ScreenHomeState {}
