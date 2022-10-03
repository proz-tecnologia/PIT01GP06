import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('AppName'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(),
      ),
    ));
  }
}
