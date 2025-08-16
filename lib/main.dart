import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Binding/Binding_main.dart';
import 'modules/Dashboard/views/dashboard_screen.dart';
import 'modules/Loginscreen/views/login_screen.dart';
import 'modules/Routes/Routes.dart';
   void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
      url: 'http://172.20.20.98:54321',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
    );
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
  }
  class MyApp extends StatefulWidget {
    const MyApp({super.key});
    @override
    State<MyApp> createState() => _MyAppState();
  }
  class _MyAppState extends State<MyApp> {
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
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DeamHR Web',
        home: session != null ? DashboardScreen() : LoginScreen(),
        getPages: appRoutes ,
        initialBinding: BindingMain(),
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
      );
    }
  }
