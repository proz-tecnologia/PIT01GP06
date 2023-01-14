import 'package:get_it/get_it.dart';
import '../features/home/homelogin/homelogin_repository.dart';
import '../features/home/homescreen/homescreen_controller.dart';
import '../features/transactions/metas/metas_controller.dart';
import '../features/transactions/metas/metas_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<HomeLoginRepository>(FirebaseRepository());
  getIt.registerLazySingleton<MetasController>(
      () => MetasController(FirebaseRepository(), FirebaseMetasRepository()));
  getIt.registerLazySingleton<MetaScreenController>(() =>
      MetaScreenController(FirebaseRepository(), FirebaseMetasRepository()));
}
