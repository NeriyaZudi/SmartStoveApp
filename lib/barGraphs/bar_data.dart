import 'package:smartStoveApp/barGraphs/individual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wenAmount;
  final double turAmount;
  final double friAmount;
  final double satAmount;

  BarData(
      {required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wenAmount,
      required this.turAmount,
      required this.friAmount,
      required this.satAmount});

  List<IndividualBar> barData = [];

  void initBarData() {
    barData = [
      IndividualBar(x: 0, y: sunAmount),
      IndividualBar(x: 1, y: monAmount),
      IndividualBar(x: 2, y: tueAmount),
      IndividualBar(x: 3, y: wenAmount),
      IndividualBar(x: 4, y: turAmount),
      IndividualBar(x: 5, y: friAmount),
      IndividualBar(x: 6, y: satAmount),
    ];
  }
}
