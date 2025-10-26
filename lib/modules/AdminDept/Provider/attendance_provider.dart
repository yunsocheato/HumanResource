import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceProvider {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAttendancedata(
    int fingerprintID,
  ) async {
    try {
      final response = await _supabase
          .from('singupuser_fit_attendance')
          .select('check_type, timestamp, department, username, id')
          .eq('fingerprint_id', fingerprintID)
          .order('timestamp', ascending: false)
          .limit(5);

      if (response == null || (response is List && response.isEmpty)) {
        return [];
      }

      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error fetching attendance: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getAttendanceDatabydate(
    int fingerprintID,
    DateTime start,
    DateTime end,
  ) async {
    try {
      final startDateOnly = DateTime(start.year, start.month, start.day);
      final endDateInclusive = DateTime(end.year, end.month, end.day + 1);
      final response = await _supabase
          .from('singupuser_fit_attendance')
          .select('check_type, timestamp, department, username, id')
          .eq('fingerprint_id', fingerprintID)
          .gte('timestamp', startDateOnly.toIso8601String())
          .lt('timestamp', endDateInclusive.toIso8601String())
          .order('timestamp', ascending: true);

      if (response == null || (response is List && response.isEmpty)) {
        return [];
      }

      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error fetching attendance: $e');
      return [];
    }
  }
}
