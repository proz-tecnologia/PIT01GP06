import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/homescreen/home_controller.dart';
import 'package:projeto_final_flutter/theme/global/colors.dart';

import 'homescreen/widgets/action_button.dart';
import 'homescreen/widgets/animated_fab.dart';
import 'homescreen/widgets/bottonbar.dart';
import 'homescreen/widgets/card_monthlysummary.dart';
import 'homescreen/widgets/divider_widget.dart';
import 'homescreen/widgets/glassmorfism_card.dart';
import 'homescreen/widgets/metas_card.dart';
import 'homescreen/widgets/primary_button_widget.dart';
import 'homescreen/widgets/title_widget.dart';
import 'homescreen/widgets/wallet.dart';

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
        title: const Text('Monetiza Action'),
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
              const Wallet(),
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
