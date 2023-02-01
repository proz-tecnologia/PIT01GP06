import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/transactions/transactions_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<ChartSampleData> chartData = <ChartSampleData>[];

class ChartSampleData {
  final int x;
  final double y;
  ChartSampleData(this.x, this.y);
}

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key, required this.title}) : super(key: key);
  
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  final controller = TransactionsRepository();
  final Random random = Random();
  DateTime data = DateTime.now();
  // ignore: unused_field
  Future<List<ChartSampleData>>? _chartData;

  @override
  void initState() {
    super.initState();
    setState(() {
      _chartData = _getChartData();
    });
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh, color: Colors.white),
        onPressed: () {
          setState(
            () {              
            },
          );
        },
      ),
    );
  }
  
  Future<List<ChartSampleData>> _getChartData() async {
    await Future.delayed(const Duration(seconds: 1));
    var lists = await controller.getExpensesSnapshot(data.day, data.year);

    if (lists!.isNotEmpty) {
      for (var list in lists) {
        chartData.add(ChartSampleData(list.x, list.y));
      }
      return chartData;
    } else {
      return [];
    }
  }
}
