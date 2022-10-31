import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/pages/home/components/animated_fab.dart';
import 'package:projeto_final_flutter/pages/home/components/bottonbar.dart';
import 'package:projeto_final_flutter/pages/home/components/card_monthlysummary.dart';
import 'package:projeto_final_flutter/pages/home/components/divider_widget.dart';
import 'package:projeto_final_flutter/pages/home/components/glassmorfism_card.dart';
import 'package:projeto_final_flutter/pages/home/components/metas_card.dart';
import 'package:projeto_final_flutter/pages/home/components/primary_button_widget.dart';
import 'package:projeto_final_flutter/pages/home/components/title_widget.dart';
import 'package:projeto_final_flutter/theme/global/colors.dart';

import 'components/action_button.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        title: const Text('AppName'),
      ),
      bottomNavigationBar: const BottomBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const GlassmorfismCard(),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: HomeTitle(
                    title: 'Setembro',
                    onBackButtonPressed: () {},
                    onForwardButtonPressed: () {}),
              ),
              const SizedBox(
                height: 24,
              ),
              const CardSummary(
                balance: '1.000,00',
                revenues: '4.000,99',
                expenses: '3.000,99',
              ),
              const SizedBox(
                height: 32,
              ),
              PrimaryButton(navigateTo: () {}, title: 'Detalhes dos gastos'),
              const SizedBox(
                height: 32,
              ),
              const CustomDivider(),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: HomeTitle(
                    title: 'Carteira',
                    onBackButtonPressed: () {},
                    onForwardButtonPressed: () {}),
              ),
              const SizedBox(
                height: 32,
              ),
              PrimaryButton(navigateTo: () {}, title: 'Adicionar carteira'),
              const SizedBox(
                height: 32,
              ),
              const CustomDivider(),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: HomeTitle(
                    title: 'Metas',
                    onBackButtonPressed: () {},
                    onForwardButtonPressed: () {}),
              ),
              const SizedBox(
                height: 32,
              ),
              const MetasCard(),
              const SizedBox(
                height: 32,
              ),
              PrimaryButton(navigateTo: () {}, title: 'Adicionar meta'),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
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
