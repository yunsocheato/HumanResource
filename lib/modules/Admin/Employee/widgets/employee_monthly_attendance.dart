import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart
import 'dart:math'; // For random data generation (optional demo)

class MonthlyAttandance extends StatefulWidget {
  const MonthlyAttandance({super.key});

  @override
  State<MonthlyAttandance> createState() => _MonthlyAttandanceState();
}

class _MonthlyAttandanceState extends State<MonthlyAttandance> {
  int _selectedIndex = 0; // For BottomNavigationBar

  List<double> _monthlyData = [
    0.3,
    0.5,
    0.8,
    0.6,
    0.9,
    0.4,
    0.7,
    0.2,
    0.1,
    0.4,
    0.5,
    0.7,
  ];
  final List<String> _months = [
    "Jan",
    "Feb",
    "Mar",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  String selectedValue = 'This Month';
  final Gradient _barGradient = const LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF93C5FD)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Optional: Method to randomize data to showcase animation
  void _randomizeChartData() {
    final random = Random();
    setState(() {
      _monthlyData = List.generate(
        12,
        (_) => (random.nextInt(8) + 2) / 10.0,
      ); // Generates values between 0.2 and 0.9
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildText(context);
  }

  Widget _buildText(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 400,
      width: screenwidth * 1.0,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    colors: [Colors.green.shade700, Colors.green.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Monthly Attendance",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedValue,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        items:
                            ['This Month', 'Last Month', 'Last 3 Months']
                                .map(
                                  (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ),
                                )
                                .toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedValue = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(height: 300, child: _buildBarChart()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    double maxYValue = _monthlyData.reduce(max);
    if (maxYValue < 1.0) {
      maxYValue = 1.0;
    } else {
      maxYValue = (maxYValue * 1.2).ceilToDouble();
    }

    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: BarChart(
        BarChartData(
          maxY: maxYValue,
          alignment: BarChartAlignment.spaceEvenly,
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: maxYValue / 12,
                getTitlesWidget: (value, meta) {
                  if (value == 0 || value == meta.max) return Container();
                  return Text(
                    value.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Color(0xff7589a2),
                      fontSize: 5,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (double value, TitleMeta meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < _months.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        _months[index],
                        style: const TextStyle(
                          color: Color(0xff7589a2),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return const FlLine(color: Color(0xffe7e8ec), strokeWidth: 1);
            },
          ),
          barGroups: List.generate(_monthlyData.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: _monthlyData[index] * maxYValue,
                  gradient: _barGradient,
                  width: 20,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
              ],
            );
          }),
        ),
        swapAnimationDuration: const Duration(milliseconds: 750),
        swapAnimationCurve: Curves.easeInOutQuint,
      ),
    );
  }
}
