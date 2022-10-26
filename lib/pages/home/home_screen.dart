import 'package:flutter/material.dart';
<<<<<<< HEAD
=======

>>>>>>> origin/bottonbar

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('AppName'), 
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(),
      ),
    ));
  }
}
