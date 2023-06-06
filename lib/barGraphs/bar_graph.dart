import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartStoveApp/barGraphs/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List<double> weeklyConsumption;
  const MyBarGraph({super.key, required this.weeklyConsumption});

  @override
  Widget build(BuildContext context) {
    const Color firstColor = Color.fromARGB(255, 148, 179, 174);
    const Color secondColor = Color.fromARGB(255, 8, 67, 143);
    BarData data = BarData(
      janAmount: weeklyConsumption[0],
      febAmount: weeklyConsumption[1],
      marchAmount: weeklyConsumption[2],
      aprAmount: weeklyConsumption[3],
      mayAmount: weeklyConsumption[4],
      junAmount: weeklyConsumption[5],
      julAmount: weeklyConsumption[6],
      augAmount: weeklyConsumption[7],
      sepAmount: weeklyConsumption[8],
      octAmount: weeklyConsumption[9],
      novAmount: weeklyConsumption[10],
      decAmount: weeklyConsumption[11],
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
            sideTitles:
                SideTitles(showTitles: true, getTitlesWidget: getBottomTitels),
          ),
        ),
        barGroups: data.barData
            .map((d) => BarChartGroupData(
                  x: d.x,
                  groupVertically: false,
                  barsSpace: 60,
                  barRods: [
                    BarChartRodData(
                      toY: d.y,
                      width: 15,
                      borderRadius: BorderRadius.circular(5),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 100,
                        color: firstColor,
                      ),
                      color: secondColor,
                    ),
                  ],
                ))
            .toList(),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipPadding: const EdgeInsets.all(0),
            tooltipMargin: 0,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final tapStr = '${rod.toY.round()}%';
              return BarTooltipItem(
                  tapStr,
                  const TextStyle(
                    color: secondColor,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ));
            },
          ),
        ),
      ),
    );
  }
}

Widget getBottomTitels(double value, TitleMeta meta) {
  const Color secondColor = Color.fromARGB(255, 8, 67, 143);
  const style = TextStyle(
    color: secondColor,
    fontWeight: FontWeight.bold,
    fontSize: 8,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text('Jan', style: style);
      break;
    case 1:
      text = Text('Feb', style: style);
      break;
    case 2:
      text = Text('Mar', style: style);
      break;
    case 3:
      text = Text('Apr', style: style);
      break;
    case 4:
      text = Text('May', style: style);
      break;
    case 5:
      text = Text('June', style: style);
      break;
    case 6:
      text = Text('July', style: style);
      break;
    case 7:
      text = Text('Aug', style: style);
      break;
    case 8:
      text = Text('Sept', style: style);
      break;
    case 9:
      text = Text('Oct', style: style);
      break;
    case 10:
      text = Text('Nov', style: style);
      break;
    case 11:
      text = Text('Dec', style: style);
      break;
    default:
      text = Text(' ', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
