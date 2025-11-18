import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../API/notification_sql.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxList<NotificationModel> allNotifications = <NotificationModel>[].obs;
  RxInt unreadCount = 0.obs;
  Rxn<User> currentUser = Rxn<User>();
  final ValueNotifier<bool> hasNewNotification = ValueNotifier(false);
  final ValueNotifier<int> notificationCount = ValueNotifier(1);
  final supabase = Supabase.instance.client;
  RealtimeChannel? _channel;

  @override
  void onInit() {
    super.onInit();

    currentUser.value = supabase.auth.currentUser;

    if (currentUser.value != null) {
      fetchAllNotifications();
      fetch5Notifications();
      subscribeRealtime();
    }

    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        currentUser.value = session!.user;
        fetchAllNotifications();
        fetch5Notifications();
        subscribeRealtime();
      } else if (event == AuthChangeEvent.signedOut) {
        clearOnLogout();
      }
    });
  }

  void clearOnLogout() {
    notifications.clear();
    allNotifications.clear();
    unreadCount.value = 0;
    currentUser.value = null;
    if (_channel != null) {
      supabase.removeChannel(_channel!);
      _channel = null;
    }
  }

  Future<void> fetchAllNotifications() async {
    final user = currentUser.value;
    if (user == null) return;

    final data = await supabase
        .from('notifications')
        .select('*')
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    final list =
        (data as List).map((e) => NotificationModel.fromMap(e)).toList();
    allNotifications.value = list;
    notifications.value = list.take(5).toList();

    updateUnreadCount();
  }

  Future<void> fetch5Notifications() async {
    final user = currentUser.value;
    if (user == null) return;

    final data = await supabase
        .from('notifications')
        .select('*')
        .eq('user_id', user.id)
        .limit(5)
        .order('created_at', ascending: false);

    final list =
        (data as List).map((e) => NotificationModel.fromMap(e)).toList();
    notifications.value = list.take(5).toList();
    updateUnreadCount();
  }

  void subscribeRealtime() {
    final user = currentUser.value;
    if (user == null) return;

    if (_channel != null) {
      supabase.removeChannel(_channel!);
      _channel = null;
    }

    _channel = supabase.channel('public:notifications');

    _channel!
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'notifications',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: user.id,
          ),
          callback: (PostgresChangePayload payload) {
            final newData = payload.newRecord;

            if (newData == null) return;

            final newNotification = NotificationModel.fromMap(newData);

            allNotifications.insert(0, newNotification);
            notifications.value = allNotifications.take(5).toList();
            updateUnreadCount();

            NotificationService.showNotification(newNotification);
            hasNewNotification.value = true;
            notificationCount.value++;
          },
        )
        .subscribe();
  }

  void updateUnreadCount() {
    final count = notifications.where((n) => !(n.isRead ?? false)).length;
    unreadCount.value = count;
  }

  Future<void> markAllAsRead() async {
    final user = currentUser.value;
    if (user == null) return;

    await supabase
        .from('notifications')
        .update({'is_read': true})
        .eq('user_id', user.id);

    for (var n in allNotifications) n.isRead = true;
    allNotifications.refresh();
    notifications.refresh();
    updateUnreadCount();
  }

  Future<void> markAsRead(String id) async {
    await supabase.from('notifications').update({'is_read': true}).eq('id', id);

    final idx = allNotifications.indexWhere((n) => n.id == id);
    if (idx != -1) {
      allNotifications[idx].isRead = true;
      allNotifications.refresh();
      notifications.refresh();
      updateUnreadCount();
    }
  }

  Future<void> markAsUnread(String id) async {
    await supabase
        .from('notifications')
        .update({'is_read': false})
        .eq('id', id);

    final idx = allNotifications.indexWhere((n) => n.id == id);
    if (idx != -1) {
      allNotifications[idx].isRead = false;
      allNotifications.refresh();
      notifications.refresh();
      updateUnreadCount();
    }
  }

  Future<void> deleteNotification(String id) async {
    await supabase.from('notifications').delete().eq('id', id);

    allNotifications.removeWhere((n) => n.id == id);
    notifications.removeWhere((n) => n.id == id);
    updateUnreadCount();
  }

  Future<void> deleteAllNotifications() async {
    final user = currentUser.value;
    if (user == null) return;

    await supabase.from('notifications').delete().eq('user_id', user.id);
    allNotifications.clear();
    notifications.clear();
    unreadCount.value = 0;
  }
}
