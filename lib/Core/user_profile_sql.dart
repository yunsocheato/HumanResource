import 'package:hrms/Core/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<UserProfileModel> FetchProfileSql(String? email) async {
  String? userEmail = Supabase.instance.client.auth.currentUser?.email;

  final SupabaseClient client = Supabase.instance.client;
  if (email == null) {
    return UserProfileModel(name: '', image: '', role: '', Position: '');
  }

  final row =
      await client
          .from('signupuser')
          .select('name, role, photo_url, position')
          .eq('email', email)
          .maybeSingle();

  if (row == null) {
    return UserProfileModel(name: '', image: '', role: '', Position: '');
  } else {
    return UserProfileModel.fromMap(row);
  }
}
