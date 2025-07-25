import 'package:supabase_flutter/supabase_flutter.dart';

Stream<int> lastMonthEmployeesStream() {
  final now = DateTime.now();
  final startOfThisMonth = DateTime(now.year, now.month, 1);
  final startOfLastMonth = DateTime(now.year, now.month - 1, 1);

  return Supabase.instance.client
      .from('signupuser')
      .stream(primaryKey: ['id'])
      .map((data) {
    final filtered = data.where((e) {
      final createdAt = DateTime.tryParse(e['created_at'] ?? '');
      return createdAt != null &&
          createdAt.isAfter(startOfLastMonth.subtract(const Duration(seconds: 1))) &&
          createdAt.isBefore(startOfThisMonth);
    }).toList();
    return filtered.length;
  });
}
