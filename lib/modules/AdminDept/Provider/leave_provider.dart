import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/modules/AdminDept/Model/leave_record_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class leaveprovider {
  Future<List<Map<String, dynamic>>> getPendingLeaveRequests() async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      if (user == null) {
        return [];
      }

      final response = await supabase
          .rpc('get_pending_leave_requests')
          .limit(5);

      final List<dynamic> rawData =
          response is List ? response : (response.data ?? []);

      final List<Map<String, dynamic>> data =
          rawData.map((e) => Map<String, dynamic>.from(e)).toList();

      final userData =
          data.where((item) => item['user_id'] == user.id).toList();

      return userData;
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
      final response = await supabase.rpc('get_pending_leave_requests');

      final List<dynamic> rawData =
          response is List ? response : (response.data ?? []);

      final List<Map<String, dynamic>> data =
          rawData.map((e) => Map<String, dynamic>.from(e)).toList();

      final userData = data.where((item) => item['user_id'] == userId).toList();

      final filtered =
          userData.where((item) {
            final fromDate = DateTime.parse(item['from_date'].toString());
            final toDate = DateTime.parse(item['to_date'].toString());
            return !(toDate.isBefore(start) || fromDate.isAfter(end));
          }).toList();

      return filtered.map((e) => LeaveRecordModel.fromMap(e)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e');
      return [];
    }
  }
}
