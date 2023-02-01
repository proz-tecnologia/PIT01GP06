import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/transactions/transactions_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<ChartSampleData> chartData = <ChartSampleData>[
  // ChartSampleData(1, 30),
  // ChartSampleData(3, 13),
  // ChartSampleData(5, 80),
  // ChartSampleData(7, 30),
  // ChartSampleData(9, 72)
];

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  final controller = TransactionsRepository();
  final Random random = Random();
  DateTime data = DateTime.now();

  @override
  void initState() {
    controller.getExpensesSnapshot(data.day, data.year);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16))),
          title: const Text('Monetiza Action'),
        ),
        body: Center(
          child: Container(
              child: SfCartesianChart(
            primaryXAxis: NumericAxis(),
            primaryYAxis: NumericAxis(),
            series: <ColumnSeries<ChartSampleData, num>>[
              ColumnSeries<ChartSampleData, num>(
                  dataSource: chartData,
                  xValueMapper: (ChartSampleData data, _) => data.x,
                  yValueMapper: (ChartSampleData data, _) => data.y,
                  dataLabelSettings: const DataLabelSettings(isVisible: true)),
            ],
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
            chartData = <ChartSampleData>[];
            chartData = _getChartData() as List<ChartSampleData>;
          }),
          child: const Icon(Icons.refresh, color: Colors.white),
        ));
  }

  /// Method to update the chart data.
   Future<List<ChartSampleData>>  _getChartData() async {
    var lists = await controller.getExpensesSnapshot(data.day, data.year);
    
    if (lists!.isNotEmpty){
      for (var list in lists) {
          chartData.add(ChartSampleData(list.x, list.y));
      }
      print("O valor de list é: $lists");
      //chartData.add(list);
      return chartData;
    } else{
      return [];
    }
  }
}

class ChartSampleData {
  final int x;
  final double y;
  ChartSampleData(this.x, this.y);
}
