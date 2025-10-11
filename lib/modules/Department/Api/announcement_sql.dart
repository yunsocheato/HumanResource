import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/announcement_model.dart';

class AnnouncementSQL {
  final data = Supabase.instance.client;
  String? get userEmail => Supabase.instance.client.auth.currentUser?.email;

  Future<List<AnnouncementModel>> getUsersByAnnouncement() async {
    final response = await data
        .from('announcement')
        .select('*')
        .eq('email', userEmail!);
    return (response as List)
        .map((json) => AnnouncementModel.fromJson(json))
        .toList();
  }
}