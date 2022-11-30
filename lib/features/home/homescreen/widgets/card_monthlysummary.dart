import 'package:flutter/material.dart';

class CardSummary extends StatelessWidget {
  final String balance;
  final String revenues;
  final String expenses;

  const CardSummary({
    Key? key,
    required this.balance,
    required this.revenues,
    required this.expenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.green[500]),
            Text("R\$ $balance",
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.fade)),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(Icons.trending_up, color: Colors.green[500]),
            ]),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Receitas",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                const SizedBox(
                  height: 8,
                ),
                Text("R\$ $revenues",
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade)),
              ],
            ),
            const SizedBox(
              width: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.trending_down, color: Colors.red[500]),
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Despesas",
                    style: TextStyle(
                        fontSize: 16,
                        // color: Colors.white70,
                        fontWeight: FontWeight.w400)),
                const SizedBox(
                  height: 8,
                ),
                Text("R\$ $expenses",
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
      ],
    );
  }
}
