import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:hrms/modules/Report/view/employee_checkin_screen.dart';
import '../Attendance/views/attendance_screen.dart';
import '../Dashboard/views/dashboard_screen.dart';
import '../Department/views/department_screen.dart';
import '../Employee/views/employee_profile_screen.dart';
import '../Employee/views/employee_screen.dart';
import '../LeaveRequest/views/leave_request_screen.dart';
import '../Loginscreen/views/login_screen.dart';
import '../Report/view/employee_Late_screen.dart';
import '../Report/view/employee_absent_screen.dart';
import '../Report/view/employee_leave_summary_screen.dart';
import '../Report/view/employee_ot_screen.dart';
import '../Schedule/views/schedule_screen.dart';

final List<GetPage> appRoutes = [
  GetPage(name: LoginScreen.routeName, page: () => LoginScreen(),transition: Transition.upToDown,),
  GetPage(name: DashboardScreen.routeName, page: () => DashboardScreen(),transition: Transition.rightToLeft),
  GetPage(name: AttendanceScreen.routeName, page: () => AttendanceScreen(),transition: Transition.rightToLeft),
  GetPage(name: LeaveRequest.routeName, page: () => LeaveRequest(),transition: Transition.leftToRightWithFade),
  GetPage(name: EmployeeScreen.routeName, page: () => EmployeeScreen(),transition: Transition.rightToLeft),
  GetPage(name: DepartmentScreen.routeName, page: () => DepartmentScreen(),transition: Transition.rightToLeft),
  GetPage(name: ScheduleScreen.routeName, page: () => ScheduleScreen(),transition: Transition.rightToLeft),
  GetPage(name: EmployeeCheckinScreen.routeName, page: () => EmployeeCheckinScreen(),transition: Transition.rightToLeft),
  GetPage(name: EmployeeLateScreen.routeName, page: () => EmployeeLateScreen(),transition: Transition.rightToLeft),
  GetPage(name: EmployeeLeaveSummaryScreen.routeName, page: () => EmployeeLeaveSummaryScreen(),transition: Transition.rightToLeft),
  GetPage(name: EmployeeAbsentScreen.routeName, page: () => EmployeeAbsentScreen(),transition: Transition.rightToLeft),
  GetPage(name: EmployeeOTScreen.routeName, page: () => EmployeeOTScreen(),transition: Transition.rightToLeft),
  GetPage(name: EmployeeProfileScreen.routeName, page: () => EmployeeProfileScreen(),transition: Transition.rightToLeft),
];


