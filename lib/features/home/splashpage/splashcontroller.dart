import 'package:projeto_final_flutter/features/home/splashpage/splash_states.dart';
import 'package:projeto_final_flutter/shared/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController {
  Future<SplashState> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final isAuthenticated =
        prefs.getBool(SharedPreferencesKeys.userLogged) ?? false;

    if (isAuthenticated) {
      return SplashStateAuthenticated();
    } else {
      return SplashUnauthenticated();
    }
  }
}
