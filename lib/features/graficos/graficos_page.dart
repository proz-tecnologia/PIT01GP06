import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/graficos/graficos_controller.dart';
import 'package:projeto_final_flutter/features/home/homescreen/homescreen_controller.dart';
import 'package:projeto_final_flutter/features/home/homescreen/screenmetas_state.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/bottonbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/card_monthlysummary.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/title_widget.dart';
import 'package:projeto_final_flutter/features/transactions/transactions_repository.dart';
import 'package:projeto_final_flutter/shared/funcoes.dart';

class GraficosPage extends StatefulWidget {
  const GraficosPage({super.key});

  @override
  State<GraficosPage> createState() => _GraficosPageState();
}

class _GraficosPageState extends State<GraficosPage> {
  final controller = BalanceController(TransactionsRepository());
  GraficosController graficosController = GraficosController();
  int _touchedIndex = -1;
  int anoBalance = DateTime.now().year;
  int mesBalance = DateTime.now().month;
  int diaBalance = DateTime.now().day;
  double totalDespesas = 0.0;
  double totalReceitas = 0.0;
  double porcentagemDespesas = 50.0;
  double porcentagemReceitas = 50.0;
  // final ValueNotifier<ScreenBalanceState> screenBalanceState = ValueNotifier(ScreenBalanceInitialState());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.notifierBalance.addListener(() {});
      controller.getBalanceRevenues();
      controller.controllerData(0, diaBalance, mesBalance, anoBalance);
     });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomBar(index: 3),
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16))),
            title: const Text('Gráficos'),
            leading: IconButton(
                icon: const Icon(Icons.logout_sharp),
                onPressed: () async => await FirebaseAuth.instance
                    .signOut()
                    .then((value) => Navigator.of(context)
                        .pushNamedAndRemoveUntil('/signup', (route) => false))),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  child: ValueListenableBuilder(
                    valueListenable: controller.notifierBalance,
                    builder: (context, stateBalance, Widget? child) {
                      if (stateBalance is ScreenBalanceInitialState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (stateBalance is ScreenBalanceErrorState) {
                        return const Text('Não há dados a serem exibidos');
                      }
                      if (stateBalance is ScreenBalanceSuccessState) {
                        totalDespesas = double.parse(
                            (stateBalance.widgetBalance.despesas)
                                .toStringAsFixed(2));
                        totalReceitas = double.parse(
                            (stateBalance.widgetBalance.receitas)
                                .toStringAsFixed(2));
                        //print('stateBalance is ScreenBalanceSuccessState - stateBalance.widgetBalance: ${stateBalance.widgetBalance.despesas}');
                        //print('valor deve ser o msm de cima: $totalDespesas');

                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: HomeTitle(
                                  title: stateBalance.widgetBalance.monthname,
                                  onBackButtonPressed: () async {
                                      DateTime novaData = clickMesAnterior(
                                          anoBalance, mesBalance, diaBalance);
                                      
                                      setState(() {
                                        anoBalance = novaData.year;
                                        mesBalance = novaData.month;
                                        diaBalance = novaData.day;
                                        
                                      });
                                      await controller.controllerData(
                                        2,
                                        diaBalance,
                                        mesBalance,
                                        anoBalance,
                                      );
                                    
                                      totalDespesas = double.parse(
                                          (stateBalance.widgetBalance.despesas)
                                              .toStringAsFixed(2));

                                      totalReceitas = double.parse(
                                          (stateBalance.widgetBalance.receitas)
                                              .toStringAsFixed(2));
        
                                  },
                                  onForwardButtonPressed: () {
                                    setState(() {
                                      DateTime novaData = clickProximoMes(
                                          anoBalance, mesBalance, diaBalance);
                                      anoBalance = novaData.year;
                                      mesBalance = novaData.month;
                                      diaBalance = novaData.day;
                                      controller.controllerData(
                                        2,
                                        diaBalance,
                                        mesBalance,
                                        anoBalance,
                                      );
                                      totalDespesas = double.parse(
                                          (stateBalance.widgetBalance.despesas)
                                              .toStringAsFixed(2));
                                      totalReceitas = double.parse(
                                          (stateBalance.widgetBalance.receitas)
                                              .toStringAsFixed(2));
                                    });
                                  }),
                            ),
                            Center(
                              child: CardSummary(
                                UniqueKey(),
                                double.parse((stateBalance.widgetBalance.saldo)
                                    .toStringAsFixed(2)),
                                double.parse(
                                    (stateBalance.widgetBalance.receitas)
                                        .toStringAsFixed(2)),
                                double.parse(
                                    (stateBalance.widgetBalance.despesas)
                                        .toStringAsFixed(2)),
                              ),
                            ),
                totalDespesas != 0.0 || totalReceitas != 0.0
                    ? AspectRatio(
                        aspectRatio: 1.3,
                        child: Row(
                          children: [
                            Expanded(
                              child: AspectRatio(
                                  aspectRatio: 1,
                                  child: PieChart(
                                    PieChartData(
                                        pieTouchData: PieTouchData(
                                          touchCallback: (FlTouchEvent event,
                                              pieTouchResponse) {
                                            setState(() {
                                              if (!event
                                                      .isInterestedForInteractions ||
                                                  pieTouchResponse == null ||
                                                  pieTouchResponse
                                                          .touchedSection ==
                                                      null) {
                                                _touchedIndex = -1;
                                                return;
                                              }
                                              _touchedIndex = pieTouchResponse
                                                  .touchedSection!
                                                  .touchedSectionIndex;
                                            });
                                          },
                                        ),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 40,
                                        sections:
                                            graficosController.showingSections(
                                                _touchedIndex,
                                                double.parse((totalDespesas /
                                                        (totalDespesas +
                                                            totalReceitas) *
                                                        100)
                                                    .toStringAsFixed(2)),
                                                double.parse((totalReceitas /
                                                        (totalDespesas +
                                                            totalReceitas) *
                                                        100)
                                                    .toStringAsFixed(2)))),
                                  )),
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: Text('Nenhuma receita/despesa foi adicionada.')),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
