import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Binding/Binding_main.dart';
import 'modules/Dashboard/views/dashboard_screen.dart';
import 'modules/Loginscreen/views/login_screen.dart';
import 'modules/Routes/Routes.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseKey = dotenv.env['SUPABASE_ANON_KEY'];
  final bucket = dotenv.env['SUPABASE_BUCKET'];
  if (supabaseUrl == null || supabaseKey == null || bucket == null) {
    throw Get.snackbar('Error','Data environment variables are missing!');
  }

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final supabase = Supabase.instance.client;
  @override
  void initState() {
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
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeamHR Web',
      home: session != null ? DashboardScreen() : LoginScreen(),
      getPages: appRoutes,
      initialBinding: BindingMain(),
      theme: ThemeData(primarySwatch: Colors.orange),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      builder: (context, data) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: data!,
        );
      },
    );
  }
}
