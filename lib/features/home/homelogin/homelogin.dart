import 'package:flutter/material.dart';

class HomeLogin extends StatelessWidget {
  const HomeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text("Eu sou a tela de Login do Aplicativo"),
          ),
        ),
      ),
    );
  }
}
