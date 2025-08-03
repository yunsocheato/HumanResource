import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrms/ErrorScreen/Controller/SuccessMessage.dart';
import 'package:hrms/modules/Drawer/controllers/Leave_Policy_controller.dart';
import 'package:hrms/modules/Drawer/controllers/OT_policy_controller.dart';
import 'package:hrms/modules/Drawer/controllers/employee_policy_controller.dart';
import 'package:hrms/modules/LeaveRequest/controllers/leave_controller.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ErrorScreen/Controller/DataUnavaiable.dart';
import 'ErrorScreen/Controller/ErrorMessage.dart';
import 'Loadingui/loading_controller.dart';
import 'Searchbar/controller/search_bar_controller.dart';
import 'modules/Attendance/controllers/attendance_chart_controller.dart';
import 'modules/Attendance/controllers/attendance_chart_pie_controller.dart';
import 'modules/Attendance/controllers/attendance_widget_controller.dart';
import 'modules/CardInfo/controllers/card_controller.dart';
import 'modules/Dashboard/views/dashboard_screen.dart';
import 'modules/Dashboard/controllers/dashboard_recently_screen_controller.dart';
import 'modules/DialogScreen/Controller/dialog_screen_controller.dart';
import 'modules/Drawer/controllers/drawer_controller.dart';
import 'modules/Drawer/controllers/fingerprint_setup_controller.dart';
import 'modules/Drawer/controllers/payroll_policy_controller.dart';
import 'modules/Employee/Controller/Employeetable_controller.dart';
import 'modules/Employee/Controller/employeefiltercontroller.dart';
import 'modules/Loginscreen/controllers/login_card_controller.dart';
import 'modules/Loginscreen/controllers/login_controller.dart';
import 'modules/Loginscreen/controllers/loginscreen_animation_controller.dart';
import 'modules/Loginscreen/services/logout_services.dart';
import 'modules/Loginscreen/views/login_screen.dart';
import 'modules/Routes/Routes.dart';

   void main() async {

    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
      url: 'http://172.20.20.98:54321',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
    );
    WidgetsFlutterBinding.ensureInitialized();
    Get.put(AppDrawerController());
    Get.put(RecentlyControllerScreen());
    Get.put(CardController());
    Get.put(AttendanceController());
    Get.put(DialogScreenController());
    Get.put(LeavePolicyController());
    Get.put(ChartController());
    Get.put(ChartPieController());
    Get.put(LoginScreenWidgetDecor());
    Get.put(LoginCardController());
    Get.put(LoginController());
    Get.put(AuthController());
    Get.put(LoadingUiController());
    Get.put(ErrormessageController());
    Get.put(SuccessMesage());
    Get.put(SearchBarController());
    Get.put(DataUnavailable());
    Get.put(EmployeeFilterController());
    Get.put(LeaveController());
    Get.put(EmployeeTalbeController());
    Get.put(PayrollPolicyController());
    Get.put(FingerPrintController());
    Get.put(EmployeePolicyController());
    Get.put(OTPolicyController());

    if (!Get.isRegistered<LoadingUiController>()) {
      Get.put(LoadingUiController());
    }

    runApp(MyApp());
  }

  class MyApp extends StatefulWidget {
    const MyApp({super.key});

    @override
    State<MyApp> createState() => _MyAppState();
  }

  class _MyAppState extends State<MyApp> {
    final AppDrawerController controller = Get.find<AppDrawerController>();

    @override
    void initState(){
      super.initState();
      initialization();
      Future.delayed(const Duration(seconds: 2), () {
        final session = Supabase.instance.client.auth.currentSession;

        if (session != null) {
          Get.offAllNamed(DashboardScreen.routeName);
        } else {
          Get.offAllNamed(LoginScreen.routeName);
        }
      });
    }

    void initialization() async {
      await Future.delayed(Duration(seconds:3));
    }
    @override
    Widget build(BuildContext context) {
      final session = Supabase.instance.client.auth.currentSession;

      return ScreenUtilInit(
        designSize:  Size(1024, 1918),
        builder: (context, child) {
          return GetMaterialApp(
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
            debugShowCheckedModeBanner: false,
            title: 'Web Admin Panel',
            home: session != null ? DashboardScreen() : LoginScreen(),
            getPages: appRoutes ,
          );
        },
      );
    }
  }
