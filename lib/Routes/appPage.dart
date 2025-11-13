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
    GetPage(name: AppRoutes.splash, page: () => SplashView()),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.logout, page: () => LogoutScreen()),
    GetPage(name: AppRoutes.userprofile, page: () => UserProfileScreen()),
    GetPage(name: AppRoutes.overview, page: () => OverViewScreen()),
    GetPage(name: AppRoutes.dashboard, page: () => DashboardScreen()),
    GetPage(name: AppRoutes.attendance, page: () => AttendanceScreen()),
    GetPage(name: AppRoutes.LeaveRequest, page: () => LeaveRequest()),
    GetPage(name: AppRoutes.employee, page: () => EmployeeScreen()),
    GetPage(name: AppRoutes.department, page: () => DepartmentScreen()),
    GetPage(name: AppRoutes.schedule, page: () => ScheduleScreen()),
    GetPage(
      name: AppRoutes.employeecheckin,
      page: () => EmployeeCheckinScreen(),
    ),
    GetPage(name: AppRoutes.employeelate, page: () => EmployeeLateScreen()),
    GetPage(
      name: AppRoutes.employeeleavesummary,
      page: () => EmployeeLeaveSummaryScreen(),
    ),
    GetPage(name: AppRoutes.employeeabsent, page: () => EmployeeAbsentScreen()),
    GetPage(name: AppRoutes.employeeot, page: () => EmployeeOTScreen()),
    GetPage(
      name: AppRoutes.employeeprofile,
      page: () => EmployeeProfileScreen(),
    ),
    GetPage(name: AppRoutes.applyLeave, page: () => ApplyLeaveScreen()),
    GetPage(name: AppRoutes.history, page: () => HistoryScreen()),
    GetPage(name: AppRoutes.settingmobile, page: () => SettingScreenMobile()),
    GetPage(name: AppRoutes.requestleave, page: () => RequestLeaveScreen()),
  ];
}
