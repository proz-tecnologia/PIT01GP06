import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/widgets/delete_button.dart';
import 'package:projeto_final_flutter/features/home/widgets/editbutton.dart';

class Wallet extends StatefulWidget {
  final VoidCallback deleteWallet;
  final VoidCallback editWallet;

  const Wallet({super.key, required this.deleteWallet, required this.editWallet});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
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
            const Text('Kaio Nubank',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Crédito',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text('Nubank',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                Icon(Icons.savings),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'R\$ 4.000,99',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                EditButton(title: 'Editar', onPressed: () {}),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
