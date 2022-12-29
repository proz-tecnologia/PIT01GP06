import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_final_flutter/features/transactions/despesas/despesas_repository.dart';
import 'package:projeto_final_flutter/features/wallets/card/card_repository.dart';
import '../../../utils/currency_formatter.dart';
import '../../home/homescreen/widgets/primary_button_widget.dart';
import 'card_model.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  String _bandeiraCartao = '';
  String? _contaVinculada;
  final TextEditingController _limiteCartaoController = TextEditingController();
  DespesasRepository despesasRepository = DespesasRepository();

  @override
  void dispose() {
    _nomeController.dispose();
    _limiteCartaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar novo cartão'),
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
                      const Text('Dê um nome ao seu cartão',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _nomeController,
                        decoration: InputDecoration(
                          hintText: 'Insira um nome para seu cartão',
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
                      const Text('Bandeira do cartão',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField(
                        hint: const Text('Escolha a bandeira do cartão'),
                        validator: (value) => value == null ? 'Campo obrigatório' : null,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _bandeiraCartao = value;
                            });
                          }
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 'American Express',
                            child: Text('American Express'),
                          ),
                          DropdownMenuItem(
                            value: 'Elo',
                            child: Text('Elo'),
                          ),
                          DropdownMenuItem(
                            value: 'Hipercard',
                            child: Text('Hipercard'),
                          ),
                          DropdownMenuItem(
                            value: 'Mastercard',
                            child: Text('Mastercard'),
                          ),
                          DropdownMenuItem(
                            value: 'Visa',
                            child: Text('Visa'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('Limite do cartão',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _limiteCartaoController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
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
                      const Text('Conta vinculada',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 8,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: despesasRepository.getBankAccountsSnapshot(),
                        builder: (context, snapshot) {
                           if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Text('Nenhuma conta adicionada.') ;
                        }
                      return DropdownButtonFormField(
                        // value: _contaVinculada,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _contaVinculada = value;
                            });
                          }
                        },
                        items: 
                          snapshot.data!.docs.map((e){
                            return DropdownMenuItem<String>(
                              value: e.data().toString().contains('nomeConta') ? e['nomeConta'] : '',  
                              child: e.data().toString().contains('nomeConta') ? Text(e['nomeConta']): const Text(''),
                            );
                          }).toList()
 
                      );
                      }),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: PrimaryButton(
                            navigateTo: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                CardModel cardModel = CardModel(
                                  nomeCartao: _nomeController.text,
                                  bandeiraCartao: _bandeiraCartao,
                                  limiteCartao: _limiteCartaoController.text,
                                  contaDoCartao: _contaVinculada,
                                );

                                CardRepository().addCard(cardModel);

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    ('/screen'), (route) => false);
                              } 
                            },
                            title: 'Adicionar Conta'),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
