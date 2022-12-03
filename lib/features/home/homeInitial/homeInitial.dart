import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/theme/global/colors.dart';

class HomeInitial extends StatelessWidget {
  const HomeInitial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff3E5E27),
                Color(0xff7F9474),
                Color(0xffC1CBC2),
                Color(0xffE5E9EC),
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset('assets/images/logo.png', width: 400, height: 300),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.darkThemeAccentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ('login'));
                  },
                  child: const Text(
                    'ENTRAR',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.lightThemeBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ('sigup'));
                  },
                  child: const Text(
                    'CRIAR CONTA',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColor.darkThemeAccentColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
