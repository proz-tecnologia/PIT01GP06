import '../../../shared/classes.dart';

abstract class ScreenHomeState {}

class ScreenHomeInitialState implements ScreenHomeState {}

class ScreenHomeSuccessState implements ScreenHomeState {

}
class ScreenHomeErrorState implements ScreenHomeState {}

///////

abstract class ScreenGlobalState {}

class ScreenGlobalInitialState implements ScreenGlobalState {}

class ScreenGlobalSuccessState implements ScreenGlobalState {
  late final double sumBalance;
    ScreenGlobalSuccessState(this.sumBalance);
    
  
}
class ScreenGlobalErrorState implements ScreenGlobalState {}

/////
///
abstract class ScreenBalanceState {}

class ScreenBalanceInitialState implements ScreenBalanceState {}

class ScreenBalanceSuccessState implements ScreenBalanceState {
  late final BalanceUser widgetBalance;
  ScreenBalanceSuccessState(this.widgetBalance);
  
}
class ScreenBalanceErrorState implements ScreenBalanceState {}

