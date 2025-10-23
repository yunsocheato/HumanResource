import 'package:supabase_flutter/supabase_flutter.dart';

import '../Model/attendance_chart_model.dart';

class AttendanceChartProvider {
  final _supabase = Supabase.instance.client;

  Future<List<AttendanceChartModel>> getAttendanceDataChart() async {
    try {
      final response = await _supabase
          .from('singupuser_fit_attendance')
          .select('check_type');

      final data = response as List;

      final Map<String, int> grouped = {};
      for (var row in data) {
        final type = row['check_type'] ?? 'Unknown';
        grouped[type] = (grouped[type] ?? 0) + 1;
      }

      return grouped.entries
          .map((e) => AttendanceChartModel(category: e.key, count: e.value))
          .toList();
    } catch (e) {
      print('Error fetching chart data: $e');
      return [];
    }
  }
}
