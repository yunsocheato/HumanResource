import 'package:get/get.dart';
import 'package:hrms/modules/Report/controller/employee_report_controller3.dart';
import '../Core/user_profile_controller.dart';
import '../Update/controller/update_controller.dart';
import '../modules/Attendance/controllers/attendance_chart_controller.dart';
import '../modules/Attendance/controllers/attendance_chart_pie_controller.dart';
import '../modules/Attendance/controllers/attendance_widget_controller.dart';
import '../modules/CardInfo/controllers/card_controller.dart';
import '../modules/Dashboard/controllers/dashboard_recently_screen_controller.dart';
import '../modules/DialogScreen/Controller/dialog_screen_controller.dart';
import '../modules/Drawer/controllers/Leave_Policy_controller.dart';
import '../modules/Drawer/controllers/OT_policy_controller.dart';
import '../modules/Drawer/controllers/access_feature_controller.dart';
import '../modules/Drawer/controllers/drawer_controller.dart';
import '../modules/Drawer/controllers/employee_policy_controller.dart';
import '../modules/Drawer/controllers/fingerprint_setup_controller.dart';
import '../modules/Drawer/controllers/payroll_policy_controller.dart';
import '../modules/Employee/Controller/Employeetable_controller.dart';
import '../modules/Employee/Controller/employeefiltercontroller.dart';
import '../modules/LeaveRequest/controllers/leave_controller.dart';
import '../modules/Loadingui/ErrorScreen/Controller/DataUnavaiable.dart';
import '../modules/Loadingui/ErrorScreen/Controller/ErrorMessage.dart';
import '../modules/Loadingui/ErrorScreen/Controller/SuccessMessage.dart';
import '../modules/Loadingui/loading_controller.dart';
import '../modules/Loginscreen/controllers/login_card_controller.dart';
import '../modules/Loginscreen/controllers/login_controller.dart';
import '../modules/Loginscreen/controllers/loginscreen_animation_controller.dart';
import '../modules/Loginscreen/services/logout_services.dart';
import '../modules/Report/controller/employee_report_controller1.dart';
import '../modules/Report/controller/employee_report_controller2.dart';
import '../modules/Report/controller/employee_report_leavesummary_controller.dart';
import '../modules/Searchbar/controller/search_bar_controller.dart';

class BindingMain extends Bindings{
  @override
  void dependencies() {

    Get.put(AppDrawerController());
    Get.lazyPut<AppDrawerController>(() => AppDrawerController());

    Get.put(RecentlyControllerScreen());
    Get.lazyPut<RecentlyControllerScreen>(() => RecentlyControllerScreen());

    Get.put(CardController());
    Get.lazyPut<CardController>(() => CardController());

    Get.put(AttendanceController());
    Get.lazyPut<AttendanceController>(() => AttendanceController());

    Get.put(DialogScreenController());
    Get.lazyPut<DialogScreenController>(() => DialogScreenController());

    Get.put(LeavePolicyController());
    Get.lazyPut<LeavePolicyController>(() => LeavePolicyController());

    Get.put(ChartController());
    Get.lazyPut<ChartController>(() => ChartController());

    Get.put(ChartPieController());
    Get.lazyPut<ChartPieController>(() => ChartPieController());

    Get.put(LoginScreenWidgetDecor());
    Get.lazyPut<LoginScreenWidgetDecor>(() => LoginScreenWidgetDecor());

    Get.put(LoginCardController());
    Get.lazyPut<LoginCardController>(() => LoginCardController());

    Get.put(LoginController());
    Get.lazyPut<LoginController>(() => LoginController());

    Get.put(AuthController());
    Get.lazyPut<AuthController>(() => AuthController());

    Get.put(LoadingUiController());
    Get.lazyPut<LoadingUiController>(() => LoadingUiController());

    Get.put(ErrormessageController());
    Get.lazyPut<ErrormessageController>(() => ErrormessageController());

    Get.put(SuccessMesage());
    Get.lazyPut<SuccessMesage>(() => SuccessMesage());

    Get.put(SearchBarController());
    Get.lazyPut<SearchBarController>(() => SearchBarController());

    Get.put(DataUnavailable());
    Get.lazyPut<DataUnavailable>(() => DataUnavailable());

    Get.put(EmployeeFilterController());
    Get.lazyPut<EmployeeFilterController>(() => EmployeeFilterController());

    Get.put(LeaveController());
    Get.lazyPut<LeaveController>(() => LeaveController());

    Get.put(EmployeeTalbeController());
    Get.lazyPut<EmployeeTalbeController>(() => EmployeeTalbeController());

    Get.put(PayrollPolicyController());
    Get.lazyPut<PayrollPolicyController>(() => PayrollPolicyController());

    Get.put(FingerPrintController());
    Get.lazyPut<FingerPrintController>(() => FingerPrintController());

    Get.put(EmployeePolicyController());
    Get.lazyPut<EmployeePolicyController>(() => EmployeePolicyController());

    Get.put(OTPolicyController());
    Get.lazyPut<OTPolicyController>(() => OTPolicyController());

    Get.put(AccessFeatureController());
    Get.lazyPut<AccessFeatureController>(() => AccessFeatureController());

    Get.put(userprofilecontroller());
    Get.lazyPut<userprofilecontroller>(() => userprofilecontroller());

    Get.put(UpdateController());
    Get.lazyPut<UpdateController>(() => UpdateController());

    Get.put(EmployeeReportController());
    Get.lazyPut<EmployeeReportController>(() => EmployeeReportController());

    Get.put(EmployeeReportController2());
    Get.lazyPut<EmployeeReportController2>(() => EmployeeReportController2());

    Get.put(leavesummarycontroller());
    Get.lazyPut<leavesummarycontroller>(() => leavesummarycontroller());

    Get.put(EmployeeReportController3());
    Get.lazyPut<EmployeeReportController3>(() => EmployeeReportController3());

  }

}