import 'package:supabase_flutter/supabase_flutter.dart';

class EmployeeReportSQL4 {
  final data = Supabase.instance.client;

  Future<List<Map <String, dynamic>>> employeeabsent({
    required int page,
    required int pageSize,
    required int from,
    required int to,
    required DateTime endDate,
    required DateTime startDate,
  }) async {
    final int currentPage = page < 1 ? 1 : page;
    final int from = (currentPage - 1) * pageSize;
    final int to = from + pageSize - 1;
    final response = await data
        .from('employee_absent')
        .select(
        'staff_id,staff_name, position, department,absent_date, reason, created_at')
        .order('absent_date', ascending: true).range(from, to)
        .range(from, to);
    final List<Map<String, dynamic>> allData = List<Map<String, dynamic>>.from(response);
    return allData;
  }
}