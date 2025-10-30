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

  Future<List<AttendanceChartModel>> getAttendanceChartByDate({
    required String range,
  }) async {
    try {
      DateTime now = DateTime.now();
      DateTime startDate;

      switch (range) {
        case '1day':
          startDate = now.subtract(Duration(days: 1));
          break;
        case '3days':
          startDate = now.subtract(Duration(days: 3));
          break;
        case '1week':
          startDate = now.subtract(Duration(days: 7));
          break;
        case '2weeks':
          startDate = now.subtract(Duration(days: 14));
          break;
        case '1month':
          startDate = DateTime(now.year, now.month - 1, now.day);
          break;
        case '2months':
          startDate = DateTime(now.year, now.month - 2, now.day);
          break;
        case '3months':
          startDate = DateTime(now.year, now.month - 3, now.day);
          break;
        case '6months':
          startDate = DateTime(now.year, now.month - 6, now.day);
          break;
        case '1year':
          startDate = DateTime(now.year - 1, now.month, now.day);
          break;
        case '2years':
          startDate = DateTime(now.year - 2, now.month, now.day);
          break;
        default:
          startDate = now.subtract(Duration(days: 1));
      }

      final response = await _supabase
          .from('singupuser_fit_attendance')
          .select('check_type')
          .gte('timestamp', startDate.toIso8601String());
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
      return [];
    }
  }

  Future<List<AttendanceChartModel>> getAttendanceChartToday() async {
    try {
      final now = DateTime.now().toUtc();
      final startOfDay = DateTime.utc(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final response = await _supabase
          .from('singupuser_fit_attendance')
          .select('check_type, timestamp')
          .gte('timestamp', startOfDay.toIso8601String())
          .lt('timestamp', endOfDay.toIso8601String());

      final data = response as List;

      final Map<String, int> grouped = {};
      for (var row in data) {
        final type = (row['check_type'] ?? 'Unknown').toString();
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
