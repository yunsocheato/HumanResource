import 'package:supabase_flutter/supabase_flutter.dart';

class leaveprovider {
  Future<List<Map<String, dynamic>>> getleavebyuser() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return [];

    final response = await Supabase.instance.client
        .from('leave_requests')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (response as List).cast<Map<String, dynamic>>();
  }
}
