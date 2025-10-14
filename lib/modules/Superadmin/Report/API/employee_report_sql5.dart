import 'package:supabase_flutter/supabase_flutter.dart';

class EmployeeReportSQL5{

  final data = Supabase.instance.client ;

  Future<List<Map<String , dynamic>>> EmployeeOTSql ({
    required DateTime startDate,
    required DateTime endDate,
    required int page,
    required int pageSize,
    required int from,
    required int to,
}) async {
    final int currentPage = page < 1 ? 1 : page;
    final int from = (currentPage - 1) * pageSize;
    final int to = from + pageSize - 1;
    final answer = await data.from('ot_feature')
        .select(
        'staff_id,staff_name,start_date,time_start,end_date,end_time,reason,created_at')
        .order('created_at', ascending: true)
        .range(from, to);
    final GetallData = List<Map<String, dynamic>>.from(answer);
    return GetallData;

  }
}