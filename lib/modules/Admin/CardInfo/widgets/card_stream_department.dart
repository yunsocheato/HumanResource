import 'package:supabase_flutter/supabase_flutter.dart';

Stream<Map<String, dynamic>> streamDepartmentSummary() {
  return Supabase.instance.client
      .from('signupuser')
      .stream(primaryKey: ['user_id'])
      .map((rows) {
        final Map<String, int> counts = {};

        for (final row in rows) {
          final dept = (row['department'] as String?)?.trim();
          final department = (dept == null || dept.isEmpty) ? 'Unknown' : dept;
          counts[department] = (counts[department] ?? 0) + 1;
        }

        if (counts.isEmpty) {
          return {'totalDepartments': 0, 'largestDepartment': 'No data'};
        }

        final totalDepartments = counts.keys.length;
        final largest = counts.entries.reduce(
          (a, b) => a.value > b.value ? a : b,
        );

        return {
          'totalDepartments': totalDepartments,
          'largestDepartment': largest.key,
        };
      })
      .asBroadcastStream();
}
