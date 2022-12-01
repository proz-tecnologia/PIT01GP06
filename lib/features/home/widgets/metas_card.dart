import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/widgets/delete_button.dart';
import 'package:projeto_final_flutter/features/home/widgets/editbutton.dart';

class MetasCard extends StatelessWidget {
  final VoidCallback deleteGoal;
  final VoidCallback editGoal;

  const MetasCard({Key? key, required this.deleteGoal, required this.editGoal}) : super(key: key);

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
                        children: const [
                          Text(
                            'Objetivo:',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Viagem Irlanda',
                            style: TextStyle(
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
                        children: const [
                          Text(
                            'Valor estimado:',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'R\$ 4.000,00',
                            style: TextStyle(
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
                        children: const [
                          Text(
                            'Valor guardado:',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'R\$ 2.000,00',
                            style: TextStyle(
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
                      children: const [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          child: LinearProgressIndicator(
                            minHeight: 22,
                            value: 0.5,
                            backgroundColor: Color(0xffFAEEE7),
                            color: Color(0xffF7B538),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('50% concluído')
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DeleteButton(
                        onPressed: () {},
                      ),
                      EditButton(
                        title: 'Editar',
                        onPressed: () {},
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
