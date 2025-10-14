import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
Future<List<Map<String, dynamic>>> getPendingLeaveRequests() async {
  try {
    final response = await supabase.rpc('get_pending_leave_requests');

    return List<Map<String, dynamic>>.from(response as List);
  } catch (error) {
    throw Exception('Error fetching pending requests: $error');
  }
}

Future<bool> updateLeaveRequestStatus({
  required String requestId,
  required String newStatus,
  required String adminId,
}) async {
  try {
    final response = await supabase.rpc(
      'update_leave_request_status',
      params: {
        'request_id': requestId,
        'new_status': newStatus,
        'admin_id': adminId,
      },
    );

    return response == true;
  } catch (error) {
    throw Exception('Error updating request status: $error');
  }
}
