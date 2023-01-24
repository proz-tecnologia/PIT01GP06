import '../../transactions/metas/metas_model.dart';

abstract class ScreenMetaState {}

class ScreenMetasInitialState implements ScreenMetaState {}

class ScreenMetasSuccessState implements ScreenMetaState {
  final List<MetasModel> todoMetas;
  ScreenMetasSuccessState(this.todoMetas);
}

class ScreenMetasErrorState implements ScreenMetaState {}
