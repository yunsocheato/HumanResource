import 'package:supabase_flutter/supabase_flutter.dart';

class ManageUserProvider {
  Future<List<Map<String, dynamic>>> fetchManageUsers() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      return [];
    }

    final response = await supabase
        .from('manage_user')
        .select('*')
        .eq('user_id', user.id);

    final data =
        (response as List).map((item) => item as Map<String, dynamic>).toList();

    return data;
  }
}
