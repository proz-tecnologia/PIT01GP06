import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/homescreen/graficos_controller.dart';
import 'package:projeto_final_flutter/features/home/homescreen/homescreen_controller.dart';
import 'package:projeto_final_flutter/features/home/homescreen/screenmetas_state.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/animated_fab.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/bottonbar.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/card_monthlysummary.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/divider_widget.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/glassmorfism_card.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/metas_card.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/primary_button_widget.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/title_widget.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/wallet.dart';
import 'package:projeto_final_flutter/shared/injection.dart';
import 'package:projeto_final_flutter/theme/global/colors.dart';
import '../../../shared/funcoes.dart';
import '../../transactions/metas/metas_controller.dart';
import '../../transactions/transactions_repository.dart';
import 'widgets/action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = BalanceController(TransactionsRepository());
  final _metaSavings = getIt.get<MetasController>();

  final controllerScreenMetas = getIt.get<MetaScreenController>();
  final ScrollController _scrollControllerWallet = ScrollController();
  final ScrollController _scrollControllerMetas = ScrollController();

  int anoBalance = DateTime.now().year;
  int mesBalance = DateTime.now().month;
  int diaBalance = DateTime.now().day;
  GraficosController graficosController = GraficosController();
  int _touchedIndex = -1;
  double totalDespesas = 0.0;
  double totalReceitas = 0.0;
  double porcentagemDespesas = 50.0;
  double porcentagemReceitas = 50.0;
  double? savingValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.getBalanceRevenues();
      controllerScreenMetas.getMetas();
      controller.controllerData(0, diaBalance, mesBalance, anoBalance);
      controller.getListWallet();
      savingValue = await _metaSavings.getBalanceSavings();
    });
  }

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
      bottomNavigationBar: BottomBar(index: 0),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              SizedBox(
                  child: ValueListenableBuilder(
                valueListenable: controller.notifierRevenues,
                builder: (context, stateRevenues, _) {
                  if (stateRevenues is ScreenGlobalInitialState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (stateRevenues is ScreenGlobalErrorState) {
                    return const Text('Não há dados a serem exibidos');
                  }
                  if (stateRevenues is ScreenGlobalSuccessState) {
                    return Center(
                      child: GlassmorfismCard(
                        balanceRevenues: double.parse(
                            (stateRevenues.sumBalance).toStringAsFixed(2)),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )),
              const SizedBox(
                height: 20,
              ),
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

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: HomeTitle(
                                title: stateBalance.widgetBalance.monthname,
                                onBackButtonPressed: () {
                                  DateTime novaData = clickMesAnterior(
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
                                },
                                onForwardButtonPressed: () {
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
                                }),
                          ),
                          Center(
                            child: CardSummary(
                              UniqueKey(),
                              double.parse((stateBalance.widgetBalance.saldo)
                                  .toStringAsFixed(2)),
                              double.parse((stateBalance.widgetBalance.receitas)
                                  .toStringAsFixed(2)),
                              double.parse((stateBalance.widgetBalance.despesas)
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
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text('Nenhuma receita/despesa foi adicionada.'),
                        )),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
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
                child: ValueListenableBuilder(
                  valueListenable: controller.notifierWallet,
                  builder: (context, stateWallet, Widget? child) {
                    if (stateWallet is ScreenWalletInitialState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (stateWallet is ScreenWalletErrorState) {
                      return const Text('Não há dados a serem exibidos');
                    }
                    if (stateWallet is ScreenWalletSuccessState) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 30.0,
                            child: HomeTitle(
                                title: 'Carteira',
                                onBackButtonPressed: () {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    if (_scrollControllerMetas.hasClients) {
                                      _scrollControllerMetas.animateTo(
                                          _scrollControllerMetas
                                              .position.minScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.fastOutSlowIn);
                                    }
                                  });
                                },
                                onForwardButtonPressed: () {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    if (_scrollControllerMetas.hasClients) {
                                      _scrollControllerMetas.animateTo(
                                          _scrollControllerMetas
                                              .position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.fastOutSlowIn);
                                    }
                                  });
                                }),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          stateWallet.listCarteira.isNotEmpty ? 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 240.0,
                                  width: 160,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(12.0),
                                    controller: _scrollControllerMetas,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: stateWallet.listCarteira.length,
                                    itemBuilder: (context, index) {
                                      final todo =
                                          stateWallet.listCarteira[index];
                                      return SizedBox(
                                        width: 350.0,
                                        child: Wallet(
                                            UniqueKey(),
                                            todo.id,
                                            todo.type,
                                            todo.name,
                                            todo.institution,
                                            todo.balance),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ) : const Text('Sua carteira está vazia.'),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ), //////
              ),
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
                    onBackButtonPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_scrollControllerWallet.hasClients) {
                          _scrollControllerWallet.animateTo(
                              _scrollControllerWallet.position.minScrollExtent,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        }
                      });
                    },
                    onForwardButtonPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_scrollControllerWallet.hasClients) {
                          _scrollControllerWallet.animateTo(
                              _scrollControllerWallet.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        }
                      });
                    }),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ValueListenableBuilder(
                  valueListenable: controllerScreenMetas.notifier,
                  builder: (context, state, _) {
                    if (state is ScreenMetaInitialState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ScreenMetaErrorState) {
                      return const Text('Não há dados a serem exibidos');
                    }
                    if (state is ScreenMetaSuccessState) {
                      return Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 460.0,
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  controller: _scrollControllerWallet,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.todoMetas.length,
                                  itemBuilder: (context, index) {
                                    final todo = state.todoMetas[index];
                                    return SizedBox(
                                      width: 350.0,
                                      child: MetasCard(
                                          UniqueKey(),
                                          todo.id,
                                          todo.objective,
                                          todo.value,
                                          todo.date,
                                          savingValue ?? 0.0),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              PrimaryButton(
                  navigateTo: () {
                    Navigator.of(context).pushNamed('/metas');
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
              //Navigator.pushNamed(context, '/addDespesa').then((_) => setState((){}));
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
              Navigator.pushNamed(context, '/addReceita')
                  .then((_) => setState(() {}));
            },
            text: 'Receitas',
          ),
        ],
      ),
    ));
  }
}
