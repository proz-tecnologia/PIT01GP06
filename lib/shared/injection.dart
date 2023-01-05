import 'package:get_it/get_it.dart';
import 'package:projeto_final_flutter/features/home/homesignup/signup_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<SignupRepository>(HomeSignupRepository());
}
