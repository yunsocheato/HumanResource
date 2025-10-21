import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/Model/leave_record_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Provider/leave_provider.dart';

class LeaveRecordController extends GetxController {
  final leaveprovider _service = leaveprovider();
  final _supabase = Supabase.instance.client;

  var leaves = <LeaveRequestModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getLeaves();
  }

  Future<void> getLeaves() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    try {
      isLoading.value = true;

      final response = await _supabase
          .from('leave_requests')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      leaves.value =
          (response as List).map((e) => LeaveRequestModel.fromMap(e)).toList();
    } catch (e) {
      print('Error fetching leaves: $e');
      leaves.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
