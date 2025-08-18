import 'package:supabase_flutter/supabase_flutter.dart';
import '../Model/employee_checkin_model.dart';
class empoloyeecheckINSQL {
final _client = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> employeecheckin({
    required int page,
    required int pageSize,
  }) async {
    final start = (page - 1) * pageSize;
    final end = start + pageSize - 1;

    final response = await Supabase.instance.client
        .from('singupuser_fit_attendance')
        .select()
        .eq('check_type', 'Check-in')
        .order('timestamp', ascending: true)
        .range(start, end);
    return List<Map<String, dynamic>>.from(response);
  }
Future<List<Map<String, dynamic>>> employeeReportCheckin() async {
  const int pageSize = 800;
  int from = 0;
  bool hasMore = true;
  List<Map<String, dynamic>> allData = [];

  while (hasMore) {
    final to = from + pageSize - 1;

    final response = await _client
        .from('singupuser_fit_attendance')
        .select('id, fingerprint_id, username, check_type, timestamp') // only these columns
        .eq('check_type', 'Check-in')
        .order('timestamp', ascending: true)
        .range(from, to);

    final List<Map<String, dynamic>> pageData =
    List<Map<String, dynamic>>.from(response);

    if (pageData.isEmpty) {
      hasMore = false;
    } else {
      allData.addAll(pageData);
      from += pageSize;
    }
  }

  return allData;
}


  Stream<List<EmployeeCheckinCountModel>> employeecheckinCount() {
    final count = Supabase.instance.client
        .from('summarycountattendance')
        .stream(primaryKey: ['id'])
        .order('checkin_count', ascending: true);
    return count.map((event) =>
        event.map((e) => EmployeeCheckinCountModel.fromJson(e)).toList());
  }
}