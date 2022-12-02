//import 'package:first_app/shared/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/splashpage/splash_states.dart';
import 'package:projeto_final_flutter/features/home/splashpage/splashcontroller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController controller = SplashController();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      controller.isAuthenticated().then((value) {
        if (value is SplashStateAuthenticated) {
          Navigator.of(context).pushReplacementNamed('HomeScreen');
        }
      });
      Navigator.of(context).pushReplacementNamed('login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 200, height: 200),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'O controle de suas finanças em sua mão.',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.apply(fontSizeFactor: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
