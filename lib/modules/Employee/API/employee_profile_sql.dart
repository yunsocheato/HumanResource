import 'package:cross_file/cross_file.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/employee_profile_model.dart';

class EmployeeProfilesql {
  String? get userEmail => Supabase.instance.client.auth.currentUser?.email;
    final profile = Supabase.instance.client;

  Future<List<String>> fetchUsernameSuggestionsEmployeeProfile(String query) async {
    final result = await Supabase.instance.client
        .from('signupuser')
        .select('name')
        .ilike('name', query.isEmpty ? '%' : '%$query%');

    return List<String>.from(result.map((e) => e['name']));
  }

  Future<EmployeeProfileModel?> fetchUserByEmployeeProfile(String name) async {
    final results = await Supabase.instance.client
        .from('signupuser')
        .select()
        .ilike('name', '%$name%')
        .limit(1);

    if (results.isNotEmpty) {
      return EmployeeProfileModel.fromJson(results.first);
    }
    return null;
  }

  Future<EmployeeProfileModel?> getEmployeeProfile() async {
    final email = userEmail;
    if (email == null) {
      print("ERROR: getEmployeeProfile called but currentUser is null!");
      return null;
    }

    final response = await profile.from('signupuser').select().eq('email', email).maybeSingle();
    return response != null ? EmployeeProfileModel.fromJson(response) : null;
  }
  Future<String?> loadProfileImage(String email) async {
    final response = await Supabase.instance.client
        .from('signupuser')
        .select('photo_url')
        .eq('email', email)
        .maybeSingle();

    return response?['photo_url'] as String?;
  }

  Future<void> updateUserInfo(String userId, Map<String, dynamic> updates) async {
    updates.removeWhere((key, value) => value == null || (value is String && value.isEmpty));

    try {
      await profile.from('signupuser').update(updates).eq('user_id', userId);
    } catch (e, st) {
      print("ERROR in updateUserInfo: $e\n$st");
      rethrow;
    }
  }

  Future<String> uploadImage(XFile file) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads/$fileName.jpg';

    final Bytes = await file.readAsBytes();


    await profile.storage.from('photo').updateBinary(
      path,
      Bytes,
      fileOptions: FileOptions(upsert: true),
    );

    return profile.storage.from('photo').getPublicUrl(path);
  }
}
