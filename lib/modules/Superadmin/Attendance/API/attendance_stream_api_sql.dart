import 'dart:async';

import '../../Dashboard/API/dashboard_stream_data_mutiple1_sql.dart';

Future<List<Map<String, dynamic>>> getAttendanceData({
  required int page,
  required int limit,
  required int offset,
}) async {
  final start = page * limit;
  final end = start + limit - 1;

  final response = await supabase
      .from('attendance')
      .select()
      .range(start, end)
      .order('timestamp', ascending: false);

  return List<Map<String, dynamic>>.from(response);
}
