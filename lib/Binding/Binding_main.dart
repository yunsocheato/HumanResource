import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/controller/attendance_chart_controller.dart';
import 'package:hrms/modules/AdminDept/controller/attendance_controller.dart';
import 'package:hrms/modules/AdminDept/controller/bottom_appbar_controller.dart';
import '../Core/user_profile_controller.dart';
import '../Utils/Bottomappbar/controller/bottomappbar_controller.dart';
import '../Utils/DialogScreen/Controller/dialog_screen_controller.dart';
import '../Utils/HoverMouse/controller/hover_mouse_controller.dart';
import '../Utils/Loadingui/ErrorScreen/Controller/DataUnavaiable.dart';
import '../Utils/Loadingui/ErrorScreen/Controller/ErrorMessage.dart';
import '../Utils/Loadingui/ErrorScreen/Controller/SuccessMessage.dart';
import '../Utils/Loadingui/loading_controller.dart';
import '../Utils/Searchbar/controller/search_bar_controller.dart';
import '../Utils/SplashScreen/controller/splash_controller.dart';
import '../modules/Admin/Attendance/controllers/attendance_chart_controller.dart'
    show ChartController;
import '../modules/Admin/Attendance/controllers/attendance_chart_pie_controller.dart';
import '../modules/Admin/Attendance/controllers/attendance_widget_controller.dart';
import '../modules/Admin/Attendance/controllers/attendane_screen_controller.dart';
import '../modules/Admin/CardInfo/controllers/card_controller.dart';
import '../modules/Admin/Dashboard/controllers/dashboard_recently_screen_controller.dart';
import '../modules/Admin/Dashboard/controllers/dashboard_screen_controller.dart';
import '../modules/Admin/Department/controllers/department_controller.dart';
import '../modules/Admin/Drawer/controllers/Leave_Policy_controller.dart';
import '../modules/Admin/Drawer/controllers/OT_policy_controller.dart';
import '../modules/Admin/Drawer/controllers/access_feature_controller.dart';
import '../modules/Admin/Drawer/controllers/drawer_controller.dart';
import '../modules/Admin/Drawer/controllers/employee_policy_controller.dart';
import '../modules/Admin/Drawer/controllers/fingerprint_setup_controller.dart';
import '../modules/Admin/Drawer/controllers/manage_users_controller.dart';
import '../modules/Admin/Drawer/controllers/payroll_policy_controller.dart';
import '../modules/Admin/Employee/Controller/Employeetable_controller.dart';
import '../modules/Admin/Employee/Controller/employee_profile_controller.dart';
import '../modules/Admin/Employee/Controller/employee_screen_controller.dart';
import '../modules/Admin/Employee/Controller/employeefiltercontroller.dart'
    show EmployeeFilterController;
import '../modules/Admin/History/controller/history_controller.dart';
import '../modules/Admin/LeaveRequest/controllers/apply_leave_screen_controller.dart';
import '../modules/Admin/LeaveRequest/controllers/leave_controller.dart';
import '../modules/Admin/Loginscreen/controllers/login_card_controller.dart';
import '../modules/Admin/Loginscreen/controllers/login_controller.dart';
import '../modules/Admin/Loginscreen/controllers/loginscreen_animation_controller.dart';
import '../modules/Admin/Loginscreen/services/logout_services.dart';
import '../modules/Admin/Report/controller/employee_report_controller1.dart';
import '../modules/Admin/Report/controller/employee_report_controller2.dart';
import '../modules/Admin/Report/controller/employee_report_controller3.dart';
import '../modules/Admin/Report/controller/employee_report_controller4.dart';
import '../modules/Admin/Report/controller/employee_report_leavesummary_controller.dart';
import '../modules/Admin/Schedule/controller/schedule_screen_controller.dart';
import '../modules/Admin/SettingScreen/controller/setting_controller.dart';
import '../modules/Admin/UserSetup/Controller/user_setup_controller.dart';
import '../modules/AdminDept/controller/leave_chart_controller.dart';
import '../modules/AdminDept/controller/leave_record_controller.dart';
import '../modules/AdminDept/controller/manageuser_controller.dart';
import '../modules/AdminDept/controller/overview_controller.dart';

class BindingMain extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController(), permanent: true);
    Get.lazyPut<DashboardController>(() => DashboardController());

    Get.put(AppDrawerController(), permanent: true);
    Get.lazyPut<AppDrawerController>(() => AppDrawerController());

    Get.put(RecentlyControllerScreen(), permanent: true);
    Get.lazyPut<RecentlyControllerScreen>(() => RecentlyControllerScreen());

    Get.put(CardController(), permanent: true);
    Get.lazyPut<CardController>(() => CardController());

    Get.put(AttendanceController(), permanent: true);
    Get.lazyPut<AttendanceController>(() => AttendanceController());

    Get.put(DialogScreenController(), permanent: true);
    Get.lazyPut<DialogScreenController>(() => DialogScreenController());

    Get.put(LeavePolicyController(), permanent: true);
    Get.lazyPut<LeavePolicyController>(() => LeavePolicyController());

    Get.put(ChartController(), permanent: true);
    Get.lazyPut<ChartController>(() => ChartController());

    Get.put(ChartPieController(), permanent: true);
    Get.lazyPut<ChartPieController>(() => ChartPieController());

    Get.put(LoginScreenWidgetDecor(), permanent: true);
    Get.lazyPut<LoginScreenWidgetDecor>(() => LoginScreenWidgetDecor());

    Get.put(LoginCardController(), permanent: true);
    Get.lazyPut<LoginCardController>(() => LoginCardController());

    Get.put(LoginController(), permanent: true);
    Get.lazyPut<LoginController>(() => LoginController());

    Get.put(AuthController(), permanent: true);
    Get.lazyPut<AuthController>(() => AuthController());

    Get.put(LoadingUiController(), permanent: true);
    Get.lazyPut<LoadingUiController>(() => LoadingUiController());

    Get.put(ErrormessageController(), permanent: true);
    Get.lazyPut<ErrormessageController>(() => ErrormessageController());

    Get.put(SuccessMesage(), permanent: true);
    Get.lazyPut<SuccessMesage>(() => SuccessMesage());

    Get.put(SearchBarController(), permanent: true);
    Get.lazyPut<SearchBarController>(() => SearchBarController());

    Get.put(DataUnavailable(), permanent: true);
    Get.lazyPut<DataUnavailable>(() => DataUnavailable());

    Get.put(EmployeeFilterController(), permanent: true);
    Get.lazyPut<EmployeeFilterController>(() => EmployeeFilterController());

    Get.put(LeaveController(), permanent: true);
    Get.lazyPut<LeaveController>(() => LeaveController());

    Get.put(EmployeeTalbeController(), permanent: true);
    Get.lazyPut<EmployeeTalbeController>(() => EmployeeTalbeController());

    Get.put(PayrollPolicyController(), permanent: true);
    Get.lazyPut<PayrollPolicyController>(() => PayrollPolicyController());

    Get.put(FingerPrintController(), permanent: true);
    Get.lazyPut<FingerPrintController>(() => FingerPrintController());

    Get.put(EmployeePolicyController(), permanent: true);
    Get.lazyPut<EmployeePolicyController>(() => EmployeePolicyController());

    Get.put(OTPolicyController(), permanent: true);
    Get.lazyPut<OTPolicyController>(() => OTPolicyController());

    Get.put(AccessFeatureController(), permanent: true);
    Get.lazyPut<AccessFeatureController>(() => AccessFeatureController());

    Get.put(UserProfileController(), permanent: true);
    Get.lazyPut<UserProfileController>(() => UserProfileController());

    Get.put(EmployeeScreenController(), permanent: true);
    Get.lazyPut<EmployeeScreenController>(() => EmployeeScreenController());

    Get.put(EmployeeReportController(), permanent: true);
    Get.lazyPut<EmployeeReportController>(() => EmployeeReportController());

    Get.put(EmployeeReportController2(), permanent: true);
    Get.lazyPut<EmployeeReportController2>(() => EmployeeReportController2());

    Get.put(leavesummarycontroller(), permanent: true);
    Get.lazyPut<leavesummarycontroller>(() => leavesummarycontroller());

    Get.put(EmployeeReportController3(), permanent: true);
    Get.lazyPut<EmployeeReportController3>(() => EmployeeReportController3());

    Get.put(EmployeeReportController4(), permanent: true);
    Get.lazyPut<EmployeeReportController4>(() => EmployeeReportController4());

    Get.put(EmployeeProfileController(), permanent: true);
    Get.lazyPut<EmployeeProfileController>(() => EmployeeProfileController());

    Get.put(DepartmentScreenController(), permanent: true);
    Get.lazyPut<DepartmentScreenController>(() => DepartmentScreenController());

    Get.put(AttendanceScreenController(), permanent: true);
    Get.lazyPut<AttendanceScreenController>(() => AttendanceScreenController());

    Get.put(LeaveController(), permanent: true);
    Get.lazyPut<LeaveController>(() => LeaveController());

    Get.put(BottomAppBarController, permanent: true);
    Get.lazyPut<BottomAppBarController>(() => BottomAppBarController());

    Get.put(ApplyLeaveScreenController(), permanent: true);
    Get.lazyPut<ApplyLeaveScreenController>(() => ApplyLeaveScreenController());

    Get.put(DepartmentScreenController(), permanent: true);
    Get.lazyPut<DepartmentScreenController>(() => DepartmentScreenController());

    Get.put(ScheduleController(), permanent: true);
    Get.lazyPut<ScheduleController>(() => ScheduleController());

    Get.put(HistoryController(), permanent: true);
    Get.lazyPut<HistoryController>(() => HistoryController());

    Get.put(SettingController(), permanent: true);
    Get.lazyPut<SettingController>(() => SettingController());

    Get.put(HoverMouseController(), permanent: true);
    Get.lazyPut<HoverMouseController>(() => HoverMouseController());

    Get.put(SplashController(), permanent: true);
    Get.lazyPut<SplashController>(() => SplashController());

    Get.put(UserSetupController(), permanent: true);
    Get.lazyPut<UserSetupController>(() => UserSetupController());

    Get.put(OverViewController(), permanent: true);
    Get.lazyPut<OverViewController>(() => OverViewController());

    Get.put(LeaveRecordController(), permanent: true);
    Get.lazyPut<LeaveRecordController>(() => LeaveRecordController());

    Get.put(BottomAppBarController1(), permanent: true);
    Get.lazyPut<BottomAppBarController1>(() => BottomAppBarController1());

    Get.put(AttendanceChartController(), permanent: true);
    Get.lazyPut<AttendanceChartController>(() => AttendanceChartController());

    Get.put(LeaveChartController(), permanent: true);
    Get.lazyPut<LeaveChartController>(() => LeaveChartController());

    Get.put(Attendancecontroller(), permanent: true);
    Get.lazyPut<Attendancecontroller>(() => Attendancecontroller());

    Get.put(ManageUsersController(), permanent: true);
    Get.lazyPut<ManageUsersController>(() => ManageUsersController());

    Get.put(ManageUserController(), permanent: true);
    Get.lazyPut<ManageUserController>(() => ManageUserController());
  }
}
