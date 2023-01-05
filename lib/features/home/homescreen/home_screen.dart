import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/animated_fab.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/bottonbar.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/card_monthlysummary.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/divider_widget.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/glassmorfism_card.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/metas_card.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/primary_button_widget.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/title_widget.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/wallet.dart';
import 'package:projeto_final_flutter/theme/global/colors.dart';
import 'widgets/action_button.dart';

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
        title: const Text('Monetiza Action'),
        leading: IconButton(
            icon: const Icon(Icons.logout_sharp),
            onPressed: () async => await FirebaseAuth.instance.signOut().then(
                (value) => Navigator.of(context)
                    .pushNamedAndRemoveUntil('/signup', (route) => false))),
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
              const Wallet(),
              const SizedBox(
                height: 32,
              ),
              PrimaryButton(
                title: 'Adicionar carteira',
                navigateTo: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return Wrap(
                          children: [
                            ListTile(
                              leading:
                                  const Icon(Icons.account_balance_rounded),
                              title: const Text('Conta'),
                              onTap: () => {
                                Navigator.of(context)
                                    .pushNamed('/addBankAccount')
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.credit_card),
                              title: const Text('Cartão'),
                              onTap: () =>
                                  {Navigator.of(context).pushNamed('/addCard')},
                            ),
                          ],
                        );
                      });
                },
              ),
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
              PrimaryButton(
                  navigateTo: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/metas', (route) => false);
                  },
                  title: 'Adicionar meta'),
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
            onPressed: () {
              Navigator.of(context).pushNamed('/addDespesa');
            },
            text: 'Despesas',
          ),
          ActionButton(
            icon: const Icon(
              Icons.trending_up,
              color: MyColor.lightThemeAccentColor,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/addReceita');
            },
            text: 'Receitas',
          ),
        ],
      ),
    ));
  }
}
