import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/modules/Dashboard/views/dashboard_screen.dart';
import 'package:hrms/modules/Department/views/department_screen.dart';
import 'package:hrms/modules/LeaveRequest/views/leave_request_screen.dart';
import 'package:hrms/modules/Report/view/employee_checkin_screen.dart';
import '../../Attendance/controllers/attendance_widget_controller.dart';
import '../../Attendance/views/attendance_screen.dart';
import '../../Employee/views/employee_screen.dart';
import '../../Loadingui/ErrorScreen/Controller/ErrorMessage.dart';
import '../../Loadingui/Loading_Screen.dart';
import '../../Loadingui/loading_controller.dart';

Future<void> MethodButton1() async {
  final error = Get.put<ErrormessageController>(ErrormessageController());
  final attendanceController = Get.find<AttendanceController>();

  if (!Get.isRegistered<LoadingUiController>()) {
    Get.put(LoadingUiController());
  }
  final loading = Get.find<LoadingUiController>();
  loading.isLoading.value = true;
  Get.dialog(
    const Dialog(
      backgroundColor: Colors.transparent,
      child: LoadingScreen(),
    ),
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
  Future.microtask(() => Get.offAllNamed(AttendanceScreen.routeName));
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
    const Dialog(
      backgroundColor: Colors.transparent,
      child: LoadingScreen(),
    ),
    barrierDismissible: false,
  );
  await Future.delayed(const Duration(seconds: 2));
  if (attendanceController.attendanceData.isEmpty) {
    error.error.value = 'No Attendance Data Found';
    error.buildErrorMessages();
    await Future.delayed(const Duration(seconds: 1));
  }
  loading.isLoading.value = false;
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  Future.microtask(() => Get.offAllNamed(DashboardScreen.routeName));
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
    const Dialog(
      backgroundColor: Colors.transparent,
      child: LoadingScreen(),
    ),
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
    const Dialog(
      backgroundColor: Colors.transparent,
      child: LoadingScreen(),
    ),
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
    const Dialog(
      backgroundColor: Colors.transparent,
      child: LoadingScreen(),
    ),
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
    const Dialog(
      backgroundColor: Colors.transparent,
      child: LoadingScreen(),
    ),
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
  Future.microtask(() => Get.offAllNamed(EmployeeCheckinWidget.routeName));
}
