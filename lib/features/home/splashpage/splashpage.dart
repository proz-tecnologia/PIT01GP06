//import 'package:first_app/shared/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/splashpage/splashcontroller.dart';
import 'package:projeto_final_flutter/shared/injection.dart';

import '../homelogin/homelogin_repository.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = SplashController(getIt.get<HomeLoginRepository>());
  @override
  void initState() {
    super.initState();
    controller.isAuthenticated();
    controller.notifier.addListener(() {
      if (controller.state == SplashState.authenticated) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/screen', (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
      }
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
