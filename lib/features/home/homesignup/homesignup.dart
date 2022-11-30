import 'package:flutter/material.dart';

class HomeSignup extends StatelessWidget {
  const HomeSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text("Eu sou a tela SIGNUP do Aplicativo"),
          ),
        ),
      ),
    );
  }
}
