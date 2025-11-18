import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hrms/Utils/SnackBar/snack_bar.dart';
import '../../../../Configuration/configuration_settings.dart';
import '../controllers/notification_controller.dart';
import '../model/notification_model.dart';
import 'package:get/get.dart';

class NotificationService {
  final controller = Get.put(NotificationController());

  static Future<void> showNotification(NotificationModel notification) async {
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          "Notification"
          "You are ${notification.title} , Your Status is : ${notification.status ?? ""}",
          notification.body,
          ContentType.success,
        );
      });
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
      sound: RawResourceAndroidNotificationSound('default_notification_send'),
    );

    final windowsDetails = WindowsNotificationDetails(
      audio: WindowsNotificationAudio.asset('default_notification_send.wav'),
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'default_notification_send.wav',
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
