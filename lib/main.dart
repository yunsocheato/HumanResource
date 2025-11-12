import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hrms/Utils/SplashScreen/widget/splash_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Binding/Binding_main.dart';
import 'Routes/appPage.dart';
import 'Routes/appRoutes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await dotenv.load(fileName: ".env");

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseKey = dotenv.env['SUPABASE_ANON_KEY'];
  final bucket1 = dotenv.env['SUPABASE_BUCKET1'];
  final bucket2 = dotenv.env['SUPABASE_BUCKET2'];
  final bucket3 = dotenv.env['SUPABASE_BUCKET3'];
  if (supabaseUrl == null ||
      supabaseKey == null ||
      bucket1 == null ||
      bucket2 == null ||
      bucket3 == null) {
    Get.snackbar('Error', 'Data environment variables are missing!');
    return;
  }
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  if (!kIsWeb && (GetPlatform.isAndroid || GetPlatform.isIOS)) {
    FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  }

  runApp(const MyApp());

  if (!kIsWeb && (GetPlatform.isAndroid || GetPlatform.isIOS)) {
    FlutterNativeSplash.remove();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeamHR Web',
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      enableLog: true,
      routingCallback: (routing) {},
      initialBinding: BindingMain(),
      theme: ThemeData(primarySwatch: Colors.orange),
    );
  }
}
