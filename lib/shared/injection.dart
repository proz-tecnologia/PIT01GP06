import 'package:get_it/get_it.dart';
import '../features/home/homelogin/homelogin_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<HomeLoginRepository>(FirebaseRepository());
}
