
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Image.asset('./assets/logo.png'),
              const SizedBox(height: 20,),
              const Text('Que bom te ver de novo!'),
              const SizedBox(height: 20,),
              Form(
                child: Text(''),
              )
            ],),
        ),
      ),
    );
  }
}