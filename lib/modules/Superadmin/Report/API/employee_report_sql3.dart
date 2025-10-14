import 'package:supabase_flutter/supabase_flutter.dart';

class EmployeeReportSql3 {

  Future<List<Map<String, dynamic>>> employeeleavesummary({
    required int page ,
    required int pageSize,
    required int from,
    required int to,
    required DateTime endDate,
    required DateTime startDate,
  })
  async {
    final int currentPage = page < 1 ? 1 : page;
    final int from = (currentPage - 1) * pageSize;
    final int to = from + pageSize - 1;

    final response = await Supabase.instance.client
        .from('summaryinfo')
        .select('staff_id, name, department, position, request_type, leave_count')
        .order('staff_id', ascending: true)
        .range(from, to);
    final List<Map<String, dynamic>> allData = List<Map<String, dynamic>>.from(
        response);
    return allData;
  }

}