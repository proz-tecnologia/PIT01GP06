import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficosController{

  List<PieChartSectionData> showingSections(int touchedIndex, double porcentagemDespesas, double porcentagemReceitas) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: porcentagemDespesas,
            title: 'Despesa: $porcentagemDespesas%',
            radius: radius,
            titlePositionPercentageOffset: 1.0,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color.fromARGB(255, 35, 209, 125),
            value: porcentagemReceitas,
            title: 'Receita: $porcentagemReceitas%',
            radius: radius,
            titlePositionPercentageOffset: 1.00,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}