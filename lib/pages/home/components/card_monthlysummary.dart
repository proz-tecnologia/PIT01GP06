
import 'package:flutter/material.dart';

import '../../global/colors.dart';

class CardSummary extends StatelessWidget {
  final String balance;
  final String revenues;
  final String expenses;

  const CardSummary({
    Key? key, required this.balance, required this.revenues, required this.expenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return SizedBox(
    height: 135,
    width: MediaQuery.of(context).size.width - 40,
    child: Card(
      color: MyColor.dtBackgroundColor,
      child: Column(
        children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.green[500]),
                  Text("R\$ $balance", style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold, overflow: TextOverflow.fade)),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Icon(Icons.trending_up, color: Colors.green[500]),
                    ]
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Receitas", style: TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.bold)),
                      Text("R\$ $revenues",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.trending_down, color: Colors.red[500]),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Despesas", style: TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.bold)),
                      Text("R\$ $expenses",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade,
                        )),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
  }
}
