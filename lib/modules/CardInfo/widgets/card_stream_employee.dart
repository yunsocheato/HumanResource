import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'card_stream_employee_current.dart';
import 'card_stream_employee_last.dart';
import '../API/card_stream_total_employee_sql.dart';


Stream<Map<String, dynamic>> employeeStatsStream() {
  return Rx.combineLatest3(
    totalEmployeesStream(),
    currentMonthEmployeesStream(),
    lastMonthEmployeesStream(),
        (int total, int current, int last) {
      final growth = last == 0 ? 100.0 : ((current - last) / last) * 100;
      final isIncrease = growth >= 0;
      final arrow = isIncrease ? Icons.arrow_upward : Icons.arrow_downward;
      final growthText =
          '${isIncrease ? '↑' : '↓'} ${growth.abs().toStringAsFixed(1)}% vs Last Month';

      return {
        'total': total,
        'growth': growthText,
        'icon': arrow,
        'iconColor': isIncrease ? Colors.green : Colors.red,
      };
    },
  ).asBroadcastStream();
}
