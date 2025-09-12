import 'package:supabase_flutter/supabase_flutter.dart';

import '../Model/apply_leave_model.dart';

class LeaveSql {

  String? get userEmail => Supabase.instance.client.auth.currentUser?.email;
  final profile = Supabase.instance.client;

  Future<List<String>> fetchUsernameSuggestionsLeave(String query) async {
    final result = await Supabase.instance.client
        .from('signupuser')
        .select('name')
        .ilike('name', query.isEmpty ? '%' : '%$query%');
    return List<String>.from(result.map((e) => e['name']));
  }

  Future<ApplyLeaveModel?> fetchUserByLeave(String name) async {
    final results = await Supabase.instance.client
        .from('signupuser')
        .select()
        .ilike('name', '%$name%')
        .limit(1);

    if (results.isNotEmpty) {
      return ApplyLeaveModel.fromJson(results.first);
    }
    return null;
  }


  Future<ApplyLeaveModel?> getEmployeeProfile() async {
    final email = userEmail;
    if (email == null) {
      print("ERROR: getEmployeeProfile called but currentUser is null!");
      return null;
    }

    final response = await profile.from('signupuser').select().eq('email', email).maybeSingle();
    return response != null ? ApplyLeaveModel.fromJson(response) : null;
  }

  Future<String?> loadProfileImage(String email) async {
    final response = await Supabase.instance.client
        .from('signupuser')
        .select('photo_url')
        .eq('email', email)
        .maybeSingle();

    return response?['photo_url'] as String?;
  }

}