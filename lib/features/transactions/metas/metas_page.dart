import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:projeto_final_flutter/features/transactions/metas/metas_controller.dart';
import '../../../shared/injection.dart';
import '../../../utils/currency_formatter.dart';
import '../../home/homelogin/homelogin_repository.dart';
import '../../home/homescreen/widgets/primary_button_widget.dart';
import 'metas_repository.dart';

class MetasPage extends StatefulWidget {
  const MetasPage({super.key});

  @override
  State<MetasPage> createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  final controller = MetasController(
    getIt.get<HomeLoginRepository>(),
    FirebaseMetasRepository(FirebaseFirestore.instance, FirebaseAuth.instance),
  );
  var decimalController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _objectiveController = TextEditingController();
  final _valueController = MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
  final _perfomanceController = MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
  final TextEditingController _iconController = TextEditingController();

  get dataPrevista => _dateGoal;

  final DateTime _dateGoal =
      DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()));

  @override
  void dispose() {
    _objectiveController.dispose();
    _valueController.dispose();
    _perfomanceController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Meta'),
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
                        'Descreva sua meta (opcional)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _objectiveController,
                        decoration: InputDecoration(
                          hintText: 'Objetivo de sua meta',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('Valor estimado',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _valueController,
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
                        'Qual o tipo do investimento:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _perfomanceController,
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
                        'Escolha a data para alcançar a meta:',
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
                          var datePreview = DateTime.parse(val);
                          // ignore: unused_local_variable
                          DateTime dateGoal = DateTime.parse(
                              DateFormat("yyyy-MM-dd").format(datePreview));
                        }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Icone',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _iconController,
                        decoration: InputDecoration(
                          hintText: 'Icone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: PrimaryButton(
                    title: ('Adicionar meta'),
                    navigateTo: () {
                      var valueGols = _valueController.numberValue;
                      var valuePerfomance = _perfomanceController.numberValue;
                      controller.addMetas(
                        '',
                        'meta',
                        _objectiveController.text,
                        valueGols,
                        valuePerfomance,
                        dataPrevista,
                        _iconController.text,
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          ('/screen'), (route) => false);
                    }),
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
