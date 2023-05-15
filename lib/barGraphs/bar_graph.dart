import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartStoveApp/barGraphs/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List<double> weeklyConsumption;
  const MyBarGraph({super.key, required this.weeklyConsumption});

  @override
  Widget build(BuildContext context) {
    BarData data = BarData(
      sunAmount: weeklyConsumption[0],
      monAmount: weeklyConsumption[1],
      tueAmount: weeklyConsumption[2],
      wenAmount: weeklyConsumption[3],
      turAmount: weeklyConsumption[4],
      friAmount: weeklyConsumption[5],
      satAmount: weeklyConsumption[6],
    );
    data.initBarData();
    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTitels)),
        ),
        barGroups: data.barData
            .map((d) => BarChartGroupData(
                  x: d.x,
                  barRods: [
                    BarChartRodData(
                      toY: d.y,
                      width: 15,
                      borderRadius: BorderRadius.circular(5),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 100,
                        color: Colors.grey[200],
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}

Widget getBottomTitels(double value, TitleMeta meta) {
  final style = TextStyle(
    color: Colors.blue[400],
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text('S', style: style);
      break;
    case 1:
      text = Text('M', style: style);
      break;
    case 2:
      text = Text('T', style: style);
      break;
    case 3:
      text = Text('W', style: style);
      break;
    case 4:
      text = Text('T', style: style);
      break;
    case 5:
      text = Text('F', style: style);
      break;
    case 6:
      text = Text('S', style: style);
      break;
    default:
      text = Text(' ', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
