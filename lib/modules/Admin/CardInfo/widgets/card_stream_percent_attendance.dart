import 'package:supabase_flutter/supabase_flutter.dart';

Stream<int> presentTodayStream() {
  return Supabase.instance.client
      .from('singupuser_fit_attendance')
      .stream(primaryKey: ['id'])
      .order('timestamp')
      .map(
        (rows) =>
            rows
                .where((row) {
                  final ts = DateTime.tryParse(row['timestamp']);
                  final today = DateTime.now();
                  final todayStart = DateTime(
                    today.year,
                    today.month,
                    today.day,
                  );
                  final todayEnd = todayStart.add(Duration(days: 1));
                  return ts != null &&
                      ts.isAfter(todayStart) &&
                      ts.isBefore(todayEnd);
                })
                .map((row) => row['user_id'])
                .toSet()
                .length,
      );
}
