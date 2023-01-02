import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/primary_button_widget.dart';
import 'package:projeto_final_flutter/features/transactions/receitas/receitas_model.dart';
import 'package:projeto_final_flutter/features/transactions/receitas/receitas_repository.dart';

import '../../../utils/currency_formatter.dart';
import '../transactions_repository.dart';
import 'receitas_controller.dart';

class ReceitasPage extends StatefulWidget {
  const ReceitasPage({super.key});

  @override
  State<ReceitasPage> createState() => _ReceitasPageState();
}

class _ReceitasPageState extends State<ReceitasPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  String _categoria = '';
  final ReceitasController _receitasController = ReceitasController();
  final ReceitasRepository _receitasRepository = ReceitasRepository();
  String _contaVinculada = '';
  String _dataReceita = DateFormat("dd-MM-yyyy").format(DateTime.now());
  TransactionsRepository transactionsRepository = TransactionsRepository();
  
  @override
  void dispose() {
    _descricaoController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar receita'),
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
                    const Text(
                      'Descreva sua receita (opcional)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                     const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _descricaoController,
                        decoration: InputDecoration(
                          hintText: 'Insira uma descrição',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                       const SizedBox(
                        height: 30,
                      ),
                      const Text('Valor da receita',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _valorController,
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
                       const Text(
                        'Categoria da despesa',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField(
                        hint: const Text('Escolha a categoria'),
                        validator: (value) =>
                            value == null ? 'Campo obrigatório' : null,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _categoria = _receitasController
                                  .listaCategorias[value]['categoria'];
                            });
                          }
                        },
                        items: _receitasController.listaCategorias.map((item) {
                          return DropdownMenuItem(
                            value: item['id'] as int,
                            child: Text(item['categoria'].toString()),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Vincular à conta:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: transactionsRepository.getBankAccountsSnapshot(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return const Text("Nenhuma conta adicionada");
                            }
                            return DropdownButtonFormField(
                              validator: (value) => value == null ? 'Campo obrigatório' : null,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _contaVinculada = value;
                                  });
                                }
                              },
                              items: snapshot.data!.docs.map((wallet) {
                                  return DropdownMenuItem<String>(
                                    value: wallet
                                            .data()
                                            .toString()
                                            .contains('nomeConta')
                                        ? wallet['nomeConta']
                                        : '',
                                    child: wallet
                                            .data()
                                            .toString()
                                            .contains('nomeConta')
                                        ? Text(wallet['nomeConta'])
                                        : const Text(''),
                                  );
                                }
                              ).toList(),
                            );
                          }),
                           const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Escolha a data da receita:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                        const SizedBox(
                        height: 8,
                      ),
                       DateTimePicker(
                        locale: const Locale('pt', 'BR'),
                        type: DateTimePickerType.date,
                        dateMask: 'dd/MM/yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                        icon: const Icon(Icons.event),
                        dateLabelText: 'Data',
                        onChanged: (val) => setState(() {
                          var dateTimeData = DateTime.parse(val);
                          _dataReceita = DateFormat("dd-MM-yyyy").format(dateTimeData);
                        }),
                      ),
                  ],
                ),
              ),
               const SizedBox(
                height: 30,
              ),
              Center(
                child: PrimaryButton(
                  title: ('Adicionar receita'),
                  navigateTo: (){
                    if (_formKey.currentState?.validate() ?? false) {
                      ReceitasModel receitaModel = ReceitasModel(
                        descricao: _descricaoController.text,
                        valor: _valorController.text,
                        categoria: _categoria,
                        data: _dataReceita,
                        conta: _contaVinculada
                      );

                      _receitasRepository.addReceita(receitaModel);

                       Navigator.of(context).pushNamedAndRemoveUntil(
                          ('/screen'), (route) => false);
                    }
                  },
                ),
              ),
               const SizedBox(
                height: 10,
              ),
            ],
          ),
         ),
        ),
    );
  }
}
