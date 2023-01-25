import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/primary_button_widget.dart';
import 'package:projeto_final_flutter/features/wallets/bank_account/bank_account_model.dart';

import '../../../utils/currency_formatter.dart';
import 'bank_account_repository.dart';

class AddBankAccount extends StatefulWidget {
  const AddBankAccount({super.key});

  @override
  State<AddBankAccount> createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _instituicaoController = TextEditingController();
  String _tipoConta = 'Corrente';
  final _balanceController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');

  @override
  void dispose() {
    _nomeController.dispose();
    _instituicaoController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar nova conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Dê um nome à sua conta',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        hintText: 'Insira um nome para sua conta',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text('Nome da Instituição/Banco',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _instituicaoController,
                      decoration: InputDecoration(
                        hintText: 'Insira o nome da Instituição/banco',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text('Tipo da Conta',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    DropdownButtonFormField(
                      value: _tipoConta,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _tipoConta = value;
                          });
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'Corrente',
                          child: Text('Corrente'),
                        ),
                        DropdownMenuItem(
                          value: 'Poupança',
                          child: Text('Poupança'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text('Saldo Inicial',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _balanceController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyFormatter(),
                      ],
                      decoration: InputDecoration(
                        hintText: 'R\$ 00,00',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: PrimaryButton(
                          navigateTo: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              BankAccountModel account = BankAccountModel(
                                type: 'receita',
                                subtype: 'corrente',
                                typeconta: 'Conta',
                                nomeConta: _nomeController.text,
                                nomeInstituicao: _instituicaoController.text,
                                tipoConta: _tipoConta,
                                balance: _balanceController.numberValue,
                                dateReg: Timestamp.fromDate(DateTime.now()),
                              );
                              BankAccountRepository().addBankAccount(account);

                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  ('/screen'), (route) => false);
                            }
                          },
                          title: 'Adicionar Conta'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
