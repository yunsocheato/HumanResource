import 'package:get/get.dart';

import '../../Superadmin/Drawer/widgets/Method_drawer_policy_button.dart';

class OverViewController extends GetxController {
  var isClockedIn = true.obs;
  var isLeaveRequestPending = false.obs;
  var isPayslipAvailable = true.obs;

  var attendanceData = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  void toggleClockStatus(bool value) {
    isClockedIn.value = value;
    Get.snackbar(
      "Status",
      value ? "Clocked In successfully!" : "Clocked Out successfully!",
    );
  }

  void toggleLeaveRequest(bool value) {
    isLeaveRequestPending.value = value;
    Get.snackbar(
      "Status",
      value ? "Leave request initiated." : "Leave request cancelled.",
    );
  }

  void fetchDashboardData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));

    attendanceData.value = [
      {'dept': 'HR', 'count': 0.5},
      {'dept': 'IT', 'count': 1.0},
    ];
    isLoading.value = false;
  }

  void refreshdata() async {
    await MethodButton1();
    update();
  }
}
