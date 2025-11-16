import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/notification_model.dart';
import '../API/notification_sql.dart';

class NotificationController extends GetxController {
  Rxn<User> currentUser = Rxn<User>();
  var notifications = <NotificationModel>[].obs;
  var allnotifications = <NotificationModel>[].obs;
  var notificationcounts = 0.obs;
  var isLoading = false.obs;

  StreamSubscription? notificationStream;

  @override
  void onInit() {
    super.onInit();

    Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      final sessionUser = data.session?.user;

      if (sessionUser != null) {
        currentUser.value = sessionUser;
        await initializeNotifications(sessionUser.id);
      } else {
        currentUser.value = null;
        notifications.clear();
        allnotifications.clear();
        notificationcounts.value = 0;
        await notificationStream?.cancel();
      }
    });

    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      currentUser.value = user;
      initializeNotifications(user.id);
    }
  }

  Future<void> initializeNotifications(String userID) async {
    final notificationService = NotificationSQL(userID: userID);

    isLoading.value = true;
    try {
      notifications.value = await notificationService.getNotificationbyrow();
      allnotifications.value = await notificationService.ShowAllNotification();
      notificationcounts.value =
          await notificationService.CountRedotNotification();

      notificationStream?.cancel();
      notificationStream = notificationService.AlertNotificationStream().listen(
        (event) {
          allnotifications.value = event;
          notifications.value = event.take(5).toList();
          notificationcounts.value = event.length;
        },
      );
    } catch (e) {
      print("Notification load error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    notificationStream?.cancel();
    super.onClose();
  }
}
