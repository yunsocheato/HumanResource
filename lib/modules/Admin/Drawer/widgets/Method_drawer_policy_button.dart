import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/view/overview_screen.dart';
import '../../../../Utils/Loadingui/ErrorScreen/Controller/ErrorMessage.dart';
import '../../../../Utils/Loadingui/Loading_Screen.dart';
import '../../../../Utils/Loadingui/loading_controller.dart';
import '../../Attendance/controllers/attendance_widget_controller.dart';
import '../../History/view/history_screen.dart';
import '../../Schedule/views/schedule_screen.dart';

Future<void> MethodButton1() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No Overview Data Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed('/overview'));
}

Future<void> MethodButton18() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No Dashboard Data Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed('/dashboard'));
}

Future<void> MethodButton2() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();
  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = ' No Attendance Data Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed('/attendance'));
}

Future<void> MethodButton3() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No Employee Data Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed('/employee'));
}

Future<void> MethodButton4() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No Department Data Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed('/department'));
}

Future<void> MethodButton5() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No Leave Data Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed('/leave-request'));
}

Future<void> MethodButton6() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No Checkin Report Data Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed('/employeecheckin'));
}

Future<void> MethodButton7() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No Late Report Data Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed('/employeelate'));
}

Future<void> MethodButton8() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No Leave Summary Report Data Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed('/employeeleavesummary'));
}

Future<void> MethodButton9() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No Absent Report Data Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed('/employeeabsent'));
}

Future<void> MethodButton10() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No OT Report Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed('/employeeot'));
}

Future<void> MethodButton11() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No Profile Data Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed('/employeeprofile'));
}

Future<void> MethodButton12() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No Schedule Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed(ScheduleScreen.routeName));
}

Future<void> MethodButton13() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No History Data';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed(HistoryScreen.routeName));
}

Future<void> MethodButton14() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No History Data';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed(ScheduleScreen.routeName));
}

Future<void> MethodButton15() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(backgroundColor: Colors.transparent, child: LoadingScreen()),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No Data Overview';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed(OverViewScreen.routeName));
}
