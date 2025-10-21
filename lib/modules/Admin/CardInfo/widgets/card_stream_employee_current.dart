import 'package:supabase_flutter/supabase_flutter.dart';

Stream<int> currentMonthEmployeesStream() {
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final nextMonth = DateTime(now.year, now.month + 1, 1);

  return Supabase.instance.client
      .from('signupuser')
      .stream(primaryKey: ['id'])
      .map((data) {
    final filtered = data.where((e) {
      final createdAt = DateTime.tryParse(e['created_at'] ?? '');
      return createdAt != null &&
          createdAt.isAfter(startOfMonth.subtract(const Duration(seconds: 1))) &&
          createdAt.isBefore(nextMonth);
    }).toList();
    return filtered.length;
  });
}
