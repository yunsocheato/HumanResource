import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../../Configuration/configuration_settings.dart';
import '../model/notification_model.dart';
import 'package:get/get.dart';

class NotificationService {
  static Future<void> showNotification(NotificationModel notification) async {
    if (kIsWeb) {
      Get.snackbar(
        "${notification.title} from ${notification.name ?? ""} Dept: ${notification.department ?? ""}",
        notification.body ?? "",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        animationDuration: const Duration(milliseconds: 500),
      );
      return;
    }

    final id = notification.id.hashCode & 0x7fffffff;

    final androidDetails = AndroidNotificationDetails(
      'leave_request_channel',
      'Leave Requests',
      channelDescription: 'Notifications for leave requests',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      showWhen: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('defualt_notification_send'),
    );

    final windowsDetails = WindowsNotificationDetails(
      audio: WindowsNotificationAudio.asset('defualt_notification_send.wav'),
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'defualt_notification_send.wav',
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
      macOS: iosDetails,
      windows: windowsDetails,
    );

    await Configuration.plugin.show(
      id,
      '${notification.title} from ${notification.name ?? ""}, Dept: ${notification.department ?? ""}',
      notification.body,
      details,
    );
  }
}
