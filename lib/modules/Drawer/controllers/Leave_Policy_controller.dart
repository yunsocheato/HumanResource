import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../API/leave_policy_sql.dart';

class LeavePolicyController extends GetxController {
  final LeavePolicySQL _sql = LeavePolicySQL();
  final TextEditingController UsernameController = TextEditingController();
  final TextEditingController useridController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final suggestionList = <String>[].obs;
  final isSwitched1 = false.obs;
  final isSwitched2 = false.obs;
  final isSwitched3 = false.obs;

  final blockAnualleave = false.obs;
  final blockSickleave = false.obs;
  final blockVacationleave = false.obs;
  final blockOtherleave = false.obs;

  final isDeduction = false.obs;

  final isLoading = false.obs;

  final IconData icon = Icons.search ;
  final Color color = Colors.blue.shade900;

  final RxString Username = ''.obs;

  final RxString MonthlySalary = ''.obs;
  final RxString DailySalary = ''.obs;
  final Rx<int> isLeave= 0.obs;

  final useragreement = false.obs;
  final leaveagreement = false.obs;
  final leavepolicyagreement = false.obs;
  final leavebalancepolicy = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSuggestionsLeavePolicy('');
    debounce(Username, (value) {
      fetchSuggestionsLeavePolicy(value);
    }, time: const Duration(milliseconds: 300));
  }

  Future<void> fetchSuggestionsLeavePolicy(String query) async {
    suggestionList.value = await _sql.fetchUsernameSuggestionsLeavePolicy(query);
  }

  Future<void> fetchUserByLeavePolicy(String name) async {
    isLoading.value = true;
    try {
      var data = await _sql.fetchUserByLeavePolicy(name);
      if (data != null) {
        userMapDataFields(data.Name);
        Username.value = data.Name;
      } else {
        clearData();
        Get.snackbar('Error', 'User Not Found');
      }
    }catch (e) {
      clearData();
      Get.snackbar("Error", "Failed to load user: $e");
    }finally {
      isLoading.value = false;
    }
  }

  Future<void> InsertData() async {
    try {
      final response = await Supabase.instance.client.from('leave_policy')
          .upsert({
        'user_id': useridController.text,
        'name': nameController.text,
        'monthly_salary': MonthlySalary.value,
        'daily_salary': DailySalary.value,
        'leave_days': isLeave.value,
        'block_anual_leave': blockAnualleave.value,
        'block_sick_leave': blockSickleave.value,
        'block_vacation_leave': blockVacationleave.value,
        'block_other_leave': blockOtherleave.value,
        'deductionable': isDeduction.value,
        'agreement': useragreement.value,
        'leave_agreement': leaveagreement.value,
        'leave_policy_agreement': leavepolicyagreement.value,
        'leave_balance_policy': leavebalancepolicy.value,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      }).select();
      if (response.isEmpty) {
        Get.snackbar('Error', 'Failed to insert data');
      }
      else{
        Get.snackbar(
          'Success',
          'Leave Policy for ${nameController.text} has been saved successfully.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white.withOpacity(0.5),
          colorText: Colors.black,);
      }
    }catch (e) {
      Get.snackbar("Error", "Failed to insert data: $e");
      clearData();
    }finally {
      clearData();
    }
  }


  void toggleLeaveBlock(RxBool switchValue, RxBool blockValue, bool newValue) {
    switchValue.value = newValue;
    blockValue.value = newValue;
  }
  void toggleDeduction(bool newValue) {
    isDeduction.value = newValue;
  }
  void toggleAgreement(bool newValue) {
    useragreement.value = newValue;
    leaveagreement.value = newValue;
    leavepolicyagreement.value = newValue;
    leavebalancepolicy.value = newValue;
  }

 void clearData() {
    UsernameController.clear();
    useridController.clear();
    nameController.clear();
 }

 void userMapDataFields(String name) {
    Username.value = name;
    nameController.text = name;
    useridController.text = name ;
 }

}