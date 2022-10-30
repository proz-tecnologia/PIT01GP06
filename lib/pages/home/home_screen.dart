import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/pages/home/components/animated_fab.dart';
import 'package:projeto_final_flutter/pages/home/components/glassmorfism_card.dart';
import 'package:projeto_final_flutter/theme/global/colors.dart';

import 'components/action_button.dart';

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
          children: const [
            SizedBox(
              height: 10,
            ),
            GlassmorfismCard(),
          ],
        ),
      ),
      floatingActionButton: AnimatedFab(
        distance: 80,
        children: [
          ActionButton(
            icon: const Icon(Icons.trending_down, color: MyColor.red),
            onPressed: () {},
            text: 'Despesas',
          ),
          ActionButton(
            icon: const Icon(
              Icons.trending_up,
              color: MyColor.ltAccentColor,
            ),
            onPressed: () {},
            text: 'Receitas',
          ),
        ],
      ),
    ));
  }
}
