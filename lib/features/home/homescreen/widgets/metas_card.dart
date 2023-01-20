import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/delete_button.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/editbutton.dart';
import 'package:projeto_final_flutter/features/transactions/metas/metas_controller.dart';
import '../../../../shared/injection.dart';
import '../../../transactions/metas/metas_state.dart';


class MetasCard extends StatefulWidget {
  final String? id;
  final String objective;
  final double value;
  final DateTime date;
  final String icon;
  final double perfomance;

  const MetasCard(
    Key? key,
    this.id,
    this.objective,
    this.value,
    this.date,
    this.icon,
    this.perfomance,
  ) : super(key: key);

  @override
  State<MetasCard> createState() => _MetasCardState();
}

class _MetasCardState extends State<MetasCard> {
  final controller = getIt.get<MetasController>();

  double get progress =>
      double.parse(((widget.perfomance / widget.value).toStringAsFixed(2)));

  String? get idRegistro => widget.id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.flight,
                        size: 32,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Objetivo:',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.objective,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.money,
                        size: 32,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Valor estimado:',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'R\$ ${widget.value.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.savings,
                        size: 32,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Valor guardado:',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'R\$ ${widget.perfomance.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          child: LinearProgressIndicator(
                            minHeight: 22,
                            value: progress,
                            backgroundColor: const Color(0xffFAEEE7),
                            color: const Color(0xffF7B538),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                            '${(progress * 100).toStringAsFixed(2)} % concluído')
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DeleteButton(
                        onPressed: () {
                          controller.deleteMeta(idRegistro!);
                        },
                      ),
                      EditButton(
                        title: 'Editar',
                        onPressed: () {
                          controller.getIdMetas(idRegistro!);
                          if (controller.state is MetasSuccessState) {
                            Navigator.of(context)
                              .pushNamed('/metaedit', arguments: {
                              'id': widget.id,
                              'objective': widget.objective,
                              'value': widget.value,
                              'date': widget.date,
                              'icon': widget.icon,
                              'perfomance': widget.perfomance,
                            });
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
