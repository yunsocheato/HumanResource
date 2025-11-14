import 'package:get/get.dart';
import 'package:hrms/modules/Admin/LogoutScreen/logout_screen.dart';
import '../../Utils/SplashScreen/widget/splash_view.dart';
import '../modules/Admin/Attendance/views/attendance_screen.dart';
import '../modules/Admin/Dashboard/views/dashboard_screen.dart';
import '../modules/Admin/Department/views/department_screen.dart';
import '../modules/Admin/Employee/views/employee_profile_screen.dart';
import '../modules/Admin/Employee/views/employee_screen.dart';
import '../modules/Admin/History/view/history_screen.dart';
import '../modules/Admin/LeaveRequest/views/apply_leave_screen.dart';
import '../modules/Admin/LeaveRequest/views/leave_request_screen.dart';
import '../modules/Admin/Loginscreen/views/login_screen.dart';
import '../modules/Admin/Report/view/employee_Late_screen.dart';
import '../modules/Admin/Report/view/employee_absent_screen.dart';
import '../modules/Admin/Report/view/employee_checkin_screen.dart';
import '../modules/Admin/Report/view/employee_leave_summary_screen.dart';
import '../modules/Admin/Report/view/employee_ot_screen.dart';
import '../modules/Admin/Schedule/views/schedule_screen.dart';
import '../modules/Admin/SettingScreen/view/setting_screen_mobile.dart';
import '../modules/AdminDept/view/overview_screen.dart';
import '../modules/AdminDept/view/profileuser_screen.dart';
import '../modules/AdminDept/view/request_leave_screen.dart';
import 'appRoutes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.logout,
      page: () => LogoutScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.userprofile,
      page: () => UserProfileScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.overview,
      page: () => OverViewScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.attendance,
      page: () => AttendanceScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.LeaveRequest,
      page: () => LeaveRequest(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.employee,
      page: () => EmployeeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.department,
      page: () => DepartmentScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.schedule,
      page: () => ScheduleScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.employeecheckin,
      page: () => EmployeeCheckinScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.employeelate,
      page: () => EmployeeLateScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.employeeleavesummary,
      page: () => EmployeeLeaveSummaryScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.employeeabsent,
      page: () => EmployeeAbsentScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.employeeot,
      page: () => EmployeeOTScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.employeeprofile,
      page: () => EmployeeProfileScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.applyLeave,
      page: () => ApplyLeaveScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.history,
      page: () => HistoryScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.settingmobile,
      page: () => SettingScreenMobile(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.requestleave,
      page: () => RequestLeaveScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
  ];
}
