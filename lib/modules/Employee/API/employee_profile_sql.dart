import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/employee_profile_model.dart';

class EmployeeProfilesql {
  final String? userEmail = Supabase.instance.client.auth.currentUser?.email;

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
    } else {
      return null;
    }
  }

  Future<EmployeeProfileModel?> getEmployeeProfile(String email) async {
    final response =
        await profile
            .from('signupuser')
            .select()
            .eq('email', email)
            .maybeSingle();
    if (response != null) {
      return EmployeeProfileModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future<String?> loadProfileImage(String email) async {
    final response = await Supabase.instance.client
        .from('signupuser')
        .select('photo_url')
        .eq('email', email)
        .maybeSingle();

    if (response != null) {
      return response['photo_url'] as String?;
    }
    return null;
  }

  Future<void> UpdateUserInfo(String userId, Map<String, dynamic> updates) async {
    await profile.from('signupuser').update(updates).eq('user_id', userId);
  }

  Future<String> uploadImage(File file) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads/$fileName.jpg';

    await profile.storage.from('photo').upload(
      path,
      file,
      fileOptions: const FileOptions(upsert: true),
    );

    return profile.storage.from('photo').getPublicUrl(path);
  }
}
