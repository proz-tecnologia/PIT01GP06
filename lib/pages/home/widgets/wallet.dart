import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_final_flutter/pages/home/components/delete_button.dart';
import 'package:projeto_final_flutter/theme/global/colors.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20),
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
              children: const [
                DeleteButton(),
                Text('botão'),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
