import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/pages/home/components/glassmorfism_card.dart';


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
        child: Column(
          children: [
            SizedBox(height: 10,),
            GlassmorfismCard(),
          ],
        ),
      ),
    ));
  }
}

