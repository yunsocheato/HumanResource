import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Model/leave_chart_model.dart';

class LeaveChartProvider {
  Future<List<LeaveChartModel>> getAllPendingLeaveRequests() async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      if (user == null) {
        return [];
      }
      final response = await supabase.rpc('get_pending_leave_requests');
      final List<dynamic> rawData =
          response is List ? response : (response.data ?? []);

      final data =
          rawData
              .map((e) => LeaveChartModel.fromMap(Map<String, dynamic>.from(e)))
              .toList();

      final userData =
          rawData
              .where((item) => item['user_id'] == user.id)
              .map((e) => LeaveChartModel.fromMap(Map<String, dynamic>.from(e)))
              .toList();

      return userData;
    } catch (error) {
      Get.snackbar('Error', 'Failed to fetch leave data: $error');
      return [];
    }
  }
}
