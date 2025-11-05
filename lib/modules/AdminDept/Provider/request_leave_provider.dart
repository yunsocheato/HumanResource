import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Admin/LeaveRequest/Model/apply_leave_model.dart';
import '../Model/request_leave_model.dart';

class RequestLeaveProvider {
  final _supabase = Supabase.instance.client;

  String? get userEmail => _supabase.auth.currentUser?.email;

  Future<ApplyLeaveModel?> getEmployeeProfile() async {
    final email = userEmail;
    if (email == null) {
      print("ERROR: getEmployeeProfile called but currentUser is null!");
      return null;
    }

    final response = await _supabase
        .from('signupuser')
        .select()
        .eq('email', email)
        .maybeSingle();

    return response != null ? ApplyLeaveModel.fromJson(response) : null;
  }

  Future<List<RequestLeaveModel>> fetchLeaveRequests() async {
    final response = await _supabase
        .from('leave_requests')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((e) => RequestLeaveModel.fromMap(e)).toList();
  }

  Future<void> approveLeave(String requestId, String reviewerId, String role) async {
    await _supabase.rpc('approve_leave_request', params: {
      'p_request_id': requestId,
      'p_reviewer': reviewerId,
      'p_role': role,
    });
  }

  Future<void> rejectLeave(String requestId, String reviewerId, String role) async {
    await _supabase.rpc('reject_leave_request', params: {
      'p_request_id': requestId,
      'p_reviewer': reviewerId,
      'p_role': role,
    });
  }


}
