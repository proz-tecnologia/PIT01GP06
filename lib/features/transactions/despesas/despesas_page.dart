import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/primary_button_widget.dart';
import 'package:projeto_final_flutter/features/transactions/despesas/despesas_model.dart';
import 'package:projeto_final_flutter/features/transactions/despesas/despesas_repository.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:projeto_final_flutter/features/transactions/transactions_repository.dart';
import '../../../utils/currency_formatter.dart';
import 'despesas_controller.dart';
import 'package:intl/intl.dart';

class DespesasPage extends StatefulWidget {
  const DespesasPage({super.key});

  @override
  State<DespesasPage> createState() => _DespesasPageState();
}

class _DespesasPageState extends State<DespesasPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  String _categoria = '';
  int _indexSelecionado = 0;
  String _subcategoria = '';
  DespesasController despesasController = DespesasController();
  DespesasRepository despesasRepository = DespesasRepository();
  TransactionsRepository transactionsRepository = TransactionsRepository(); 
  String _contaVinculada = '';
  String _contaOuCartao = "Conta";
  String _dataDespesa = DateFormat("dd-MM-yyyy").format(DateTime.now());


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
        title: const Text('Adicionar despesa'),
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
                        'Descreva sua despesa (opcional)',
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
                      const Text('Valor da despesa',
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
                              _indexSelecionado = value;
                              _categoria = despesasController
                                  .listaCategorias[value]['categoria'];
                            });
                          }
                        },
                        items: despesasController.listaCategorias.map((item) {
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
                        'Subcategoria da despesa',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField<String>(
                          hint: const Text('Escolha a subcategoria'),
                          validator: (value) =>
                              value == null ? 'Campo obrigatório' : null,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _subcategoria = value;
                              });
                            }
                          },
                          items: despesasController
                              .getListaSubcategorias(_indexSelecionado)),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Vincular à conta/cartão:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListTile(
                                title: const Text('Conta'),
                                leading: Radio(
                                  value: 'Conta',
                                  groupValue: _contaOuCartao,
                                  onChanged: (value) {
                                    setState(() {
                                      _contaOuCartao = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ListTile(
                                title: const Text('Cartão'),
                                leading: Radio(
                                  value: 'Cartão',
                                  groupValue: _contaOuCartao,
                                  onChanged: (value) async {
                                    setState(() {
                                      _contaOuCartao = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: _contaOuCartao == 'Conta'
                              ? transactionsRepository.getBankAccountsSnapshot()
                              : transactionsRepository.getCardsSnapshot(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return _contaOuCartao == 'Conta'
                                  ? const Text("Nenhuma conta adicionada")
                                  : const Text('Nenhum cartão adicionado');
                            }
                            return DropdownButtonFormField(
                              validator: (value) =>
                                  value == null ? 'Campo obrigatório' : null,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _contaVinculada = value;
                                  });
                                }
                              },
                              items: snapshot.data!.docs.map((wallet) {
                                if (_contaOuCartao == 'Conta') {
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
                                } else {
                                  return DropdownMenuItem<String>(
                                    value: wallet
                                            .data()
                                            .toString()
                                            .contains('nomeCartao')
                                        ? wallet['nomeCartao']
                                        : '',
                                    child: wallet
                                            .data()
                                            .toString()
                                            .contains('nomeCartao')
                                        ? Text(wallet['nomeCartao'])
                                        : const Text(''),
                                  );
                                }
                              }).toList(),
                            );
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Escolha a data da despesa:',
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
                          _dataDespesa = DateFormat("dd-MM-yyyy").format(dateTimeData);
                        }),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: PrimaryButton(
                  title: ('Adicionar despesa'),
                  navigateTo: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      DespesasModel despesaModel = DespesasModel(
                        descricao: _descricaoController.text,
                        valor: _valorController.text,
                        categoria: _categoria,
                        subcategoria: _subcategoria,
                        data: _dataDespesa,
                        conta: _contaVinculada
                      );

                      despesasRepository.addDespesa(despesaModel);

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
