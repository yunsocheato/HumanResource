import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/Model/leave_record_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class leaveprovider {
  Future<List<Map<String, dynamic>>> getPendingLeaveRequests() async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      if (user == null) return [];

      final response = await supabase
          .from('leave_requests')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: true)
          .limit(5);

      final List<Map<String, dynamic>> data =
          (response as List).map((e) => Map<String, dynamic>.from(e)).toList();

      return data;
    } catch (error) {
      Get.snackbar('Error', 'Failed to fetch leave requests: $error');
      return [];
    }
  }

  Future<List<LeaveRecordModel>> getLeaveDatabydate(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase
          .from('leave_requests')
          .select()
          .eq('user_id', userId)
          .gte('start_date', start.toIso8601String())
          .lte('end_date', end.toIso8601String())
          .order('created_at', ascending: true);

      final List<Map<String, dynamic>> data =
          (response as List).map((e) => Map<String, dynamic>.from(e)).toList();

      return data.map((e) => LeaveRecordModel.fromMap(e)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e');
      return [];
    }
  }

  Future<List<LeaveRecordModel>> getAllLeaveRequestsByDate(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase
          .from('leave_requests')
          .select()
          .gte('start_date', start.toIso8601String())
          .lte('end-date', end.toIso8601String())
          .order('start_date', ascending: false)
          .limit(5);

      final List<Map<String, dynamic>> data =
          (response as List).map((e) => Map<String, dynamic>.from(e)).toList();

      return data.map((e) => LeaveRecordModel.fromMap(e)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e');
      return [];
    }
  }
}
