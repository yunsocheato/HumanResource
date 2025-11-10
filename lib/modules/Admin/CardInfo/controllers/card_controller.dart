import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/card_combine_stream_attendance.dart';
import '../widgets/card_stream_department.dart';
import '../widgets/card_stream_employee.dart';
import '../models/card_attendance_model.dart';

class CardController extends GetxController {
  late Stream<AttendanceStats> attendanceStream;

  var total = ''.obs;
  var growth = ''.obs;
  var icon = Icons.info.obs;
  var iconColor = Colors.grey.obs;
  var isLoading = true.obs;

  //Attendacne Stream
  var presentcount = 0.obs;
  RxInt percentage = 0.obs;
  var totalcount = 0.obs;
  var isLoading1 = true.obs;

  var totalDepartment = 0.obs;
  var largestDepartment = ''.obs;
  var isLoading3 = true.obs;

  @override
  void onInit() {
    super.onInit();
    attendanceStream = CombineStreamAttendance;
    totalemployeestream();
    AttendanceStream();
    DepartmentStream();
  }

  void totalemployeestream() {
    employeeStatsStream().listen(
      (data) {
        total.value = data['total'].toString();
        growth.value = data['growth'] as String;
        icon.value = data['icon'] as IconData;
        isLoading.value = false;
      },
      onError: (error) {
        error.error.value = 'No Employee Data Found';
        error.buildErrorMessages();
        isLoading.value = false;
      },
      onDone: () {
        isLoading.value = false;
      },
    );
  }

  void AttendanceStream() {
    attendanceStream.listen(
      (stats) {
        presentcount.value = stats.presentCount;
        percentage.value = stats.percentage.toInt();
        totalcount.value = stats.totalCount;
        isLoading1.value = false;
      },
      onError: (error) {
        print('Error: $error');
        isLoading1.value = false;
      },
      onDone: () {
        isLoading1.value = false;
      },
    );
  }

  void DepartmentStream() {
    streamDepartmentSummary().listen(
      (snap) {
        totalDepartment.value = snap['totalDepartments'] as int;
        largestDepartment.value = snap['largestDepartment'].toString();
        isLoading3.value = false;
      },
      onError: (error) {
        print('Error: $error');
        isLoading3.value = false;
      },
      onDone: () {
        isLoading3.value = false;
      },
    );
  }
}
