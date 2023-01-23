import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../features/home/homelogin/homelogin_repository.dart';
import '../features/home/homescreen/homescreen_controller.dart';
import '../features/transactions/metas/metas_controller.dart';
import '../features/transactions/metas/metas_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<HomeLoginRepository>(FirebaseRepository(FirebaseAuth.instance));
  getIt.registerLazySingleton<MetasController>(
      () => MetasController(FirebaseRepository(FirebaseAuth.instance), FirebaseMetasRepository(FirebaseFirestore.instance, FirebaseAuth.instance)));
  getIt.registerLazySingleton<MetaScreenController>(() =>
      MetaScreenController(FirebaseRepository(FirebaseAuth.instance), FirebaseMetasRepository(FirebaseFirestore.instance, FirebaseAuth.instance)));
}
