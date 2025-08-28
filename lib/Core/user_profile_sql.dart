import 'package:hrms/Core/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FetchProfileSql{
  final String? userEmail = Supabase.instance.client.auth.currentUser?.email;
  final data = Supabase.instance.client;

  Future<UserProfileModel?> getProfileUser(String email) async{
  final answer = await data
      .from('signupuser')
      .select()
      .eq('email', email)
      .maybeSingle();
  if (answer == null) return null;
  return UserProfileModel.fromJson(answer);

  }



}