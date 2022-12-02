import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/home_controller.dart';
import 'package:projeto_final_flutter/features/home/widgets/animated_fab.dart';
import 'package:projeto_final_flutter/features/home/widgets/bottonbar.dart';
import 'package:projeto_final_flutter/features/home/widgets/card_monthlysummary.dart';
import 'package:projeto_final_flutter/features/home/widgets/divider_widget.dart';
import 'package:projeto_final_flutter/features/home/widgets/glassmorfism_card.dart';
import 'package:projeto_final_flutter/features/home/widgets/metas_card.dart';
import 'package:projeto_final_flutter/features/home/widgets/primary_button_widget.dart';
import 'package:projeto_final_flutter/features/home/widgets/title_widget.dart';
import 'package:projeto_final_flutter/features/home/widgets/wallet.dart';
import 'package:projeto_final_flutter/theme/global/colors.dart';

import 'widgets/action_button.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = HomeController();
  late var actualMonth = controller.getCurrentMonth();

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
                    title: actualMonth,
                    onBackButtonPressed: (){
                      setState(() {
                        actualMonth = controller.getPreviousMonth();
                      });
                    },
                    onForwardButtonPressed: (){
                      setState(() {
                        actualMonth = controller.getNextMonth();
                      });
                    }
                    ),
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
                    onBackButtonPressed: () => controller.showPreviousWallet(),
                    onForwardButtonPressed: () => controller.showNextWallet()),
              ),
              const SizedBox(
                height: 32,
              ),
              Wallet(
                deleteWallet: () => controller.deleteWallet(),
                editWallet: () => controller.editWallet(),
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
                    onBackButtonPressed: () => controller.showPreviousGoal(),
                    onForwardButtonPressed: () => controller.showNextGoal()),
              ),
              const SizedBox(
                height: 32,
              ),
              MetasCard(
                deleteGoal: () => controller.deleteGoal(),
                editGoal: () => controller.editGoal(),
              ),
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
            onPressed: () => controller.addExpense(),
            text: 'Despesas',
          ),
          ActionButton(
            icon: const Icon(
              Icons.trending_up,
              color: MyColor.lightThemeAccentColor,
            ),
            onPressed: () => controller.addRevenue(),
            text: 'Receitas',
          ),
        ],
      ),
    ));
  }
}
