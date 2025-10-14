import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/modules/AdminDept/view/overview_screen.dart';
import '../../../../Utils/Loadingui/ErrorScreen/Controller/ErrorMessage.dart';
import '../../../../Utils/Loadingui/Loading_Screen.dart';
import '../../../../Utils/Loadingui/loading_controller.dart';
import '../../Attendance/controllers/attendance_widget_controller.dart';
import '../../Attendance/views/attendance_screen.dart';
import '../../Dashboard/views/dashboard_screen.dart';
import '../../Department/views/department_screen.dart';
import '../../Employee/views/employee_profile_screen.dart';
import '../../Employee/views/employee_screen.dart';
import '../../History/view/history_screen.dart';
import '../../LeaveRequest/views/leave_request_screen.dart';
import '../../Report/view/employee_Late_screen.dart';
import '../../Report/view/employee_absent_screen.dart';
import '../../Report/view/employee_checkin_screen.dart';
import '../../Report/view/employee_leave_summary_screen.dart';
import '../../Report/view/employee_ot_screen.dart';
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
    error.error.value = 'No Dashboard Data Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed(DashboardScreen.routeName));
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
  Future.microtask(() => Get.offAllNamed(AttendanceScreen.routeName));
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
  Future.microtask(() => Get.offAllNamed(EmployeeScreen.routeName));
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
  Future.microtask(() => Get.offAllNamed(DepartmentScreen.routeName));
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
  Future.microtask(() => Get.offAllNamed(LeaveRequest.routeName));
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
  Future.microtask(() => Get.offAllNamed(EmployeeCheckinScreen.routeName));
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
  Future.microtask(() => Get.offAllNamed(EmployeeLateScreen.routeName));
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
  Future.microtask(() => Get.offAllNamed(EmployeeLeaveSummaryScreen.routeName));
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
  Future.microtask(() => Get.offAllNamed(EmployeeAbsentScreen.routeName));
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
  Future.microtask(() => Get.offAllNamed(EmployeeOTScreen.routeName));
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
  Future.microtask(() => Get.offAllNamed(EmployeeProfileScreen.routeName));
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
