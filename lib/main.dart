import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Binding/Binding_main.dart';
import 'Routes/appPage.dart';
import 'Routes/appRoutes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseKey = dotenv.env['SUPABASE_ANON_KEY'];
  final bucket = dotenv.env['SUPABASE_BUCKET'];
  if (supabaseUrl == null || supabaseKey == null || bucket == null) {
    throw Get.snackbar('Error', 'Data environment variables are missing!');
  }

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  if (kIsWeb) {
    FlutterNativeSplash.remove();
  }
  runApp(MyApp());
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
      initialBinding: BindingMain(),
      theme: ThemeData(primarySwatch: Colors.orange),
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.light,
      // builder: (context, data) {
      //   return MediaQuery(
      //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      //     child: data!,
      //   );
      // },
    );
  }
}
