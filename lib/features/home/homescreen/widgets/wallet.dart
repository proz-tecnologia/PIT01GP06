import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/delete_button.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/editbutton.dart';

import '../../../transactions/transactions_repository.dart';
import '../homescreen_controller.dart';

class Wallet extends StatefulWidget {
  final String id;
  final String type;
  final String name;
  final String institution;
  final double balance;

  const Wallet(
    Key? key,
    this.id,
    this.type,
    this.name,
    this.institution,
    this.balance,
  ): super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final controller = BalanceController(TransactionsRepository());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.type,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(widget.institution,
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(Icons.savings),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'R\$ ${widget.balance.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DeleteButton(
                  onPressed: () {},
                ),
                EditButton(
                    title: 'Editar',
                    onPressed: () {
                      controller.getListWallet();
                    }),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
