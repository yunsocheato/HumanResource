import 'package:get/get.dart';
import 'package:hrms/modules/Report/view/employee_checkin.dart';
import '../Attendance/views/attendance_screen.dart';
import '../Dashboard/views/dashboard_screen.dart';
import '../Department/views/department_screen.dart';
import '../Employee/views/employee_screen.dart';
import '../LeaveRequest/views/leave_request_screen.dart';
import '../Loginscreen/views/login_screen.dart';
import '../Schedule/views/schedule_screen.dart';

final List<GetPage> appRoutes = [
  GetPage(name: LoginScreen.routeName, page: () => LoginScreen(),transition: Transition.rightToLeft),
  GetPage(name: DashboardScreen.routeName, page: () => DashboardScreen(),transition: Transition.rightToLeft),
  GetPage(name: AttendanceScreen.routeName, page: () => AttendanceScreen(),transition: Transition.rightToLeft),
  GetPage(name: LeaveRequest.routeName, page: () => LeaveRequest(),transition: Transition.rightToLeft),
  GetPage(name: EmployeeScreen.routeName, page: () => EmployeeScreen(),transition: Transition.rightToLeft),
  GetPage(name: DepartmentScreen.routeName, page: () => DepartmentScreen(),transition: Transition.rightToLeft),
  GetPage(name: schedulescreen.routeName, page: () => schedulescreen(),transition: Transition.rightToLeft),
  GetPage(name: EmployeeCheckIN.routeName, page: () => EmployeeCheckIN(),transition: Transition.rightToLeft),
];
