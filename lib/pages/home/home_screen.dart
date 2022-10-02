import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/pages/global/colors.dart';
import '../global/colors.dart';

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
