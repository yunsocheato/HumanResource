import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../LeaveRequest/API/leave_stream_rpc_sql.dart';
import '../models/dashboard_get_mutiple2_data_model.dart';

Future<List<MutipleModel2>> fetchEmployeeScanRecords() async {
  final today = DateTime.now();

  try {
    final response = await supabase
        .from('singupuser_fit_attendance')
        .select()
        .order('timestamp', ascending: false);

    final rows = response as List<dynamic>;

    return rows
        .where((row) {
          final ts = DateTime.tryParse(row['timestamp'] ?? '');
          return ts != null &&
              ts.year == today.year &&
              ts.month == today.month &&
              ts.day == today.day;
        })
        .map((row) {
          final bucket = dotenv.env['SUPABASE_BUCKET1']!;
          final photoUrl =
              (row['photo_url'] != null && row['photo_url'] != '')
                  ? supabase.storage.from(bucket).getPublicUrl(row['photo_url'])
                  : '_';

          return MutipleModel2(
            title: 'Scan Record',
            photo: photoUrl,
            description:
                '${row['username'] ?? ''}\ncheck in at ${row['timestamp'] ?? ''}',
            icon: Icons.group_add,
            color1: Colors.deepPurple,
            color2: Colors.deepPurpleAccent,
            iconBgColor: Colors.grey,
          );
        })
        .toList();
  } catch (e) {
    print("Fetch scan records error: $e");
    return [];
  }
}

// Future<List<MutipleModel2>> fetchCombined2() async {
//   try {
//     final results = await Future.wait([
//       fetchEmployeeScanRecords()
//     ]);
//     return [...results[0],];
//   } catch (e) {
//     print("Fetch combined1 error: $e");
//     return [];
//   }
// }
