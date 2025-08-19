import 'package:supabase_flutter/supabase_flutter.dart';
import '../Model/employee_checkin_model.dart';
class empoloyeecheckINSQL {
final _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> employeecheckin({
    required int page,
    required int pageSize,
    required DateTime StartDate,
    required DateTime endDate,
  }) async {

    final int currentPage = page < 1 ? 1 : page;
    final int start = (currentPage - 1) * pageSize;
    final int end = start + pageSize - 1;

    try {
      final response = await Supabase.instance.client
          .from('singupuser_fit_attendance')
          .select()
          .eq('check_type', 'Check-in')
          .order('timestamp', ascending: true)
          .range(start, end);
      return List<Map<String, dynamic>>.from(response);
    } catch (e){
      print('Error fetching data: $e');
      return [] ;
    }
  }


Future<List<Map<String, dynamic>>> employeeReportCheckin({
  required DateTime StartDate,
  required DateTime endDate,
  required int from,
  required int to,
}) async {
  final response = await _client
      .from('singupuser_fit_attendance')
      .select('id, fingerprint_id, username, check_type, timestamp')
      .eq('check_type', 'Check-in')
      .order('timestamp', ascending: true)
      .range(from, to);

  final List<Map<String, dynamic>> allData = List<Map<String, dynamic>>.from(response);
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