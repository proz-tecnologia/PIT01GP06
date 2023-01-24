import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import '../../../shared/injection.dart';
import '../../../utils/currency_formatter.dart';
import '../../home/homelogin/homelogin_repository.dart';
import '../../home/homescreen/homescreen_controller.dart';
import 'metas_controller.dart';
import 'metas_repository.dart';

class MetasPageEdit extends StatefulWidget {
  final String? id;
  final String? objective;
  final double? value;
  final DateTime? date;
  final String? icon;
  final double? perfomance;

  const MetasPageEdit({
    Key? key,
    this.id,
    required this.objective,
    required this.value,
    required this.date,
    required this.icon,
    required this.perfomance,
  }) : super(key: key);

  @override
  State<MetasPageEdit> createState() => _MetasPageEditState();
}

class _MetasPageEditState extends State<MetasPageEdit> {
  var decimalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  final controller = MetaScreenController(
    getIt.get<HomeLoginRepository>(),
    FirebaseMetasRepository(FirebaseFirestore.instance, FirebaseAuth.instance),
  );

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _objectiveController = TextEditingController();
  final _valueController = MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
  final _perfomanceController = MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
  final TextEditingController _iconController = TextEditingController();
  late DateTime _dateGoal;

  // DateTime.parse(DateFormat("yyyy-MM-dd").format(datePreview));

  String? get id => widget.id;

  @override
  void initState() {
    super.initState();
    _objectiveController.text = widget.objective ?? '';
    _valueController.updateValue(widget.value ?? 0.0);
    _dateGoal = widget.date!;
    _iconController.text = widget.icon ?? '';
    _perfomanceController.updateValue(widget.perfomance ?? 0.0);
  }

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
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(('/screen'), (route) => false);
        return false;
      },
      child: Scaffold(
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
                          initialValue: widget.date.toString(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                          icon: const Icon(Icons.event),
                          dateLabelText: 'Data',
                          onChanged: (val) => setState(() {
                            var datePreview = DateTime.parse(val);
                            // ignore: unused_local_variable
                            _dateGoal = DateTime.parse(
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
                  child: ElevatedButton(
                      onPressed: () async {
                        var valueGols = _valueController.numberValue;
                        var valuePerfomance = _perfomanceController.numberValue;
                        await controller.updateMetas(
                          id!,
                          'meta',
                          _objectiveController.text,
                          valueGols,
                          _dateGoal,
                          _iconController.text,
                          valuePerfomance,
                        );
                        //Navigator.of(context).pushNamed('/screen');
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            ('/screen'), (route) => false);
                      },
                      child: const Text('Editar')),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
