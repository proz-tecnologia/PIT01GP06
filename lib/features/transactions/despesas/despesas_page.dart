import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_final_flutter/features/home/homescreen/widgets/primary_button_widget.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:projeto_final_flutter/features/transactions/despesas/despesas_controller.dart';
import 'package:projeto_final_flutter/features/transactions/despesas/despesas_model.dart';
import 'package:projeto_final_flutter/features/transactions/despesas/despesas_repository.dart';
import 'package:projeto_final_flutter/features/transactions/transactions_repository.dart';
import '../../../utils/currency_formatter.dart';
import 'package:intl/intl.dart';

class DespesasPage extends StatefulWidget {
  const DespesasPage({super.key});

  @override
  State<DespesasPage> createState() => _DespesasPageState();
}

class _DespesasPageState extends State<DespesasPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descricaoController = TextEditingController();
  final _valorController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');
  String _categoria = '';
  int _indexSelecionado = 0;
  String _subcategoria = 'Outros';
  DespesasController despesasController = DespesasController();
  DespesasRepository despesasRepository = DespesasRepository();
  TransactionsRepository transactionsRepository = TransactionsRepository();
  String? _selectedValue;
  String _contaOuCartao = "Conta";
  DateTime? _dataDespesa;
  late double totalBalance;
  late int dataevent;
  List<String>? bankAccounts;
  List<String>? cardAccounts;

  DateTime get dataDespesa =>
      _dataDespesa ??
      DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bankAccounts =
          await TransactionsRepository().getListBankAccountsSnapshot();
      cardAccounts = await TransactionsRepository().getListCardsSnapshot();
      if ((_contaOuCartao == 'Conta' && bankAccounts != null) ||
          (_contaOuCartao == 'Cartão' && cardAccounts != null)) {
        _contaOuCartao == 'Conta'
            ? _selectedValue = bankAccounts![0]
            : _selectedValue = cardAccounts![0];
      }
      setState(() {});
    });
  }


  @override
  void dispose() {
    _descricaoController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed('/screen');
        return false;
      },
      child: Scaffold(
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
                  _categoria == 'Cartão Crédito' ? 
                      cardAccounts!=null ? 
                      DropdownButtonFormField(
                              validator: (value) => value == null ? 'Campo obrigatório' : null,
                              hint: const Text('Escolha o cartão'),
                              items: cardAccounts!.map((e){
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(e)
                                        );
                                }).toList(),
                              onChanged: (String? value) {
                                  setState(() {
                                    _subcategoria = value!;
                                  });
                              
                              },
                            ) : const Text('Nenhum cartão adicionado') :
                        DropdownButtonFormField<String>(
                            hint: const Text('Escolha a subcategoria'),
                          value: _subcategoria,
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
                                      if(bankAccounts != null){
                                        _selectedValue = bankAccounts![0]; 
                                      } else{
                                        _selectedValue = null;
                                      }
                                        _contaOuCartao = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                             _categoria != 'Cartão Crédito' ? Expanded(
                              child: ListTile(
                                title: const Text('Cartão'),
                                leading: Radio(
                                  value: 'Cartão',
                                  groupValue: _contaOuCartao,
                                  onChanged: (value) async {
                                    setState(() {
                                      if(cardAccounts != null){
                                        _selectedValue = cardAccounts![0];
                                      } else {
                                        _selectedValue = null;
                                      }
                                      _contaOuCartao = value!;
                                    });
                                  },
                                ),
                              ),
                            ) : const Text(''),
                          ],
                        ),
                      ),
                      (_contaOuCartao == 'Conta' && bankAccounts != null) || (_contaOuCartao == 'Cartão' && cardAccounts != null) ? 
                      DropdownButtonFormField(
                              value: _contaOuCartao == 'Conta' ? bankAccounts![0] : cardAccounts![0],
                              validator: (value) => value == null ? 'Campo obrigatório' : null,
                              items: (_contaOuCartao == 'Conta') ? 
                                bankAccounts!.map((e){
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(e)
                                  );
                                }).toList()
                                  :  cardAccounts!.map((e){
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(e)
                                        );
                                }).toList(),
                              onChanged: (String? value) {
                                  setState(() {
                                    _selectedValue = value;
                                  });
                              
                              },
                            ) : const Text('Adicione alguma carteira à sua conta.'),
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
                        onChanged: (val) => setState(
                          () {
                            var dateTimeData = DateTime.parse(val);
                            _dataDespesa = DateTime.parse(
                                DateFormat("yyyy-MM-dd").format(dateTimeData));
                          },
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: PrimaryButton(
                  title: ('Adicionar despesa'),
                  navigateTo: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      if(_selectedValue != null){
                          var result = await despesasRepository.getDespesaCategoria(_categoria);
                          if (result.isEmpty) {
                            totalBalance = 0.0;
                          } else {
                            totalBalance = result[0].balance;
                          }                  
              
                                  

                          dataevent = DateTime.now().millisecondsSinceEpoch;

                          DespesasModel despesaModel = DespesasModel(
                              type: 'despesa',
                              descricao: _descricaoController.text,
                              valor: _valorController.numberValue,
                              balance: _valorController.numberValue + totalBalance,
                              categoria: _categoria,
                              subcategoria: _subcategoria,
                              timeReg: dataevent,
                              data: dataDespesa,
                              day: dataDespesa.day,
                              month:dataDespesa.month,
                              year:dataDespesa.year,
                              typeconta: _contaOuCartao,
                              conta: _selectedValue!);

                          despesasRepository.addDespesa(despesaModel);
                        
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              ('/screen'), (route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Adicione alguma conta para ser vinculada.')));
                        }

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
    ));
  }
}

