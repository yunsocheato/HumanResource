import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/notification_model.dart';

class NotificationSQL {
  final String userID;
  NotificationSQL({required this.userID});

  Future<List<NotificationModel>> getNotificationbyrow() async {
    final response = await Supabase.instance.client
        .from('notifications')
        .select('*')
        .eq('user_id', userID)
        .order('created_at', ascending: false)
        .limit(5);
    return (response as List)
        .map((json) => NotificationModel.fromMap(json))
        .toList();
  }

  Future<List<NotificationModel>> ShowAllNotification() async {
    final response = await Supabase.instance.client
        .from('notifications')
        .select('*')
        .eq('user_id', userID)
        .order('created_at', ascending: true);
    return (response as List)
        .map((json) => NotificationModel.fromMap(json))
        .toList();
  }

  Future<int> CountRedotNotification() async {
    final response = await Supabase.instance.client
        .from('notifications')
        .select('id')
        .eq('user_id', userID);
    return (response as List).length;
  }

  Stream<List<NotificationModel>> AlertNotificationStream() {
    return Supabase.instance.client
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('user_id', userID)
        .order('created_at', ascending: true)
        .map(
          (event) =>
              event.map((json) => NotificationModel.fromMap(json)).toList(),
        );
  }
}
