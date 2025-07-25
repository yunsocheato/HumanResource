import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'department_circledot.dart';

class Circulaindicator extends StatefulWidget {
  const Circulaindicator({super.key});

  @override
  State<Circulaindicator> createState() => _CirculaindicatorState();
}

class _CirculaindicatorState extends State<Circulaindicator> {
  final Map<String, double> dataMap = {
    "IT": 14,
    "HR": 2,
    "Finance": 1,
    "Admin": 5,
    "ATM": 24,
    "Stock": 2,
  };

  final List<Color> colorList = [
    Colors.blue,
    Colors.blueAccent,
    Colors.blue.shade900,
    Colors.yellow,
    Colors.orangeAccent,
    Colors.green,
  ];

  @override
  @override
  Widget build(BuildContext context) {
    double total = dataMap.values.reduce((a, b) => a + b);
    final screenwidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 350,
      width: screenwidth * 0.3,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
        child: Column(
          children: [
            // Header
            Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  colors: [Colors.pink.shade700, Colors.pink.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Department Records",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Chart & Legend
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PieChart(
                    dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 0,
                    chartRadius: 150,
                    colorList: colorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 30,
                    centerText: "${total.toInt()}",
                    legendOptions: LegendOptions(showLegends: false),
                    chartValuesOptions: ChartValuesOptions(showChartValues: false),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0, right: 22, left: 22),
                    child: Circledot(dataMap: dataMap),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
