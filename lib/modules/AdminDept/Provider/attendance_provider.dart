import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceProvider {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAttendancedata() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return [];

    final response = await Supabase.instance.client
        .from('singupuser_fit_attendance')
        .select()
        .eq('user_id', user.id)
        .order('timestamp', ascending: false);

    return (response as List).cast<Map<String, dynamic>>();
  }
}
