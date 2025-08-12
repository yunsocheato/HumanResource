import 'package:hrms/Core/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FetchProfileSql{
  final String? userEmail = Supabase.instance.client.auth.currentUser?.email;


  Stream<UserProfileModel?> getProfileUser(String email)  {
  return Supabase.instance.client
      .from('signupuser')
      .stream(primaryKey: ['email'])
      .eq('email', email)
      .map((rows) {
      if (rows.isEmpty) return null;
    return UserProfileModel.fromJson(rows.first);
  });
  }



}