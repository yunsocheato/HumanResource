import 'package:get/get.dart';
import 'package:hrms/modules/Admin/Calendar_Mobile/calendar_mobile.dart';
import 'package:hrms/modules/Admin/ChangePassword/view/otp_screen.dart';
import 'package:hrms/modules/Admin/Drawer/views/employee_policy_screen_mobile.dart';
import 'package:hrms/modules/Admin/Drawer/views/manage_user_mobile_screen.dart';
import 'package:hrms/modules/Admin/Employee/views/employee_profile_mobile_screen.dart';
import 'package:hrms/modules/Admin/LeaveRequest/widgets/request_leave_widget_mobile.dart';
import 'package:hrms/modules/Admin/LogoutScreen/logout_screen.dart';
import 'package:hrms/modules/Admin/UserSetup/View/user_setup_screen_mobile.dart';
import '../../Utils/SplashScreen/widget/splash_view.dart';
import '../modules/Admin/Attendance/views/attendance_screen.dart';
import '../modules/Admin/ChangePassword/view/change_password_screen.dart';
import '../modules/Admin/ChangePassword/view/email_verify_screen.dart';
import '../modules/Admin/Dashboard/views/dashboard_screen.dart';
import '../modules/Admin/Department/views/department_screen.dart';
import '../modules/Admin/Drawer/views/menu_drawer_screen_admin.dart';
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
import '../modules/Admin/ResetPassword/view/check_mail_link_screen.dart';
import '../modules/Admin/ResetPassword/view/otp_reset_password_screen.dart';
import '../modules/Admin/ResetPassword/view/reset_verify_email_screen.dart';
import '../modules/Admin/Schedule/views/schedule_screen.dart';
import '../modules/Admin/SettingScreen/view/setting_screen_mobile.dart';
import '../modules/AdminDept/view/attendance_screen.dart';
import '../modules/AdminDept/view/overview_screen.dart';
import '../modules/AdminDept/view/profileuser_screen.dart';
import '../modules/AdminDept/view/report_screen.dart';
import '../modules/AdminDept/view/request_leave_screen.dart';
import '../modules/AdminDept/widget/menu_drawer_user.dart';
import 'appRoutes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
      transition: Transition.leftToRight,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      transition: Transition.cupertinoDialog,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.logout,
      page: () => LogoutScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.userprofile,
      page: () => UserProfileScreen(),
      transition: Transition.upToDown,
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
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.attendance,
      page: () => AttendanceScreen(),
      transition: Transition.rightToLeftWithFade,
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
      transition: Transition.zoom,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.department,
      page: () => DepartmentScreen(),
      transition: Transition.fade,
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
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.applyLeave,
      page: () => ApplyLeaveScreen(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.history,
      page: () => HistoryScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.settingmobile,
      page: () => SettingScreenMobile(),
      transition: Transition.size,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.requestleave,
      page: () => RequestLeaveScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.attendanceuser,
      page: () => AttendanceUserScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.report,
      page: () => ReportScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.emailverify,
      page: () => EmailVerifyScreen(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => OTPScreen(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.change_password,
      page: () => ChangePasswordScreen(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.email_verify_reset,
      page: () => resetverification(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.otp_reset,
      page: () => OTPResetPasswordScreen(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.check_mail,
      page: () => CheckMailBoxScreen(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.menu_admin,
      page: () => MenuMobileScreenAdmin(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.menu_user,
      page: () => MenuMobileScreenUser(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.mobile_calendar,
      page: () => MobileCalendarScreen(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.mobile_calendar,
      page: () => MobileCalendarScreen(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.user_setup_mobile,
      page: () => UserSetupScreenMobile(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.user_update_mobile,
      page: () => EmployeePolicyMobile(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.manage_user_mobile,
      page: () => ManageUserMobile(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.employee_policy_mobile,
      page: () => EmployeeProfileMobile(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.mobile_request_leave,
      page: () => RequestLeaveWidgetMobile(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 500),
    ),
  ];
}
