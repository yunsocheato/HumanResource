import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class Configuration {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static FlutterLocalNotificationsPlugin get plugin => _plugin;

  static Future<void> initialize() async {
    if (kIsWeb) {
      Get.snackbar(
        'Permission Required',
        "Web notifications require browser permissions",
      );
      return;
    }

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true,
    );

    const windowsSettings = WindowsInitializationSettings(
      appName: 'DEAM HR',
      appUserModelId: 'com.deam.hr',
      guid: '123e4567-e89b-12d3-a456-426614174000',
      iconPath: '@mipmap/ic_launcher',
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
      macOS: iosSettings,
      windows: windowsSettings,
    );

    await _plugin.initialize(initializationSettings);
  }
}
