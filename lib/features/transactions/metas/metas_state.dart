import 'metas_model.dart';

abstract class MetaState {}

class MetasInitialState implements MetaState {}

class MetasSuccessState implements MetaState {
  final List<MetasModel> todoMetas;
  MetasSuccessState(this.todoMetas);
}

class MetasErrorState implements MetaState {}
