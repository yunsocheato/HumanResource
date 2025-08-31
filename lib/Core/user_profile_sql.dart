import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hrms/Core/user_profile_model.dart';

class FetchProfileSql {
  String? userEmail = Supabase.instance.client.auth.currentUser?.email;
  final data = Supabase.instance.client;

  Future<UserProfileModel> ProfileImage(String email) async {
    final row = await data
        .from('signupuser')
        .select()
        .eq('email', email)
        .maybeSingle();

    if (row == null) {
      return UserProfileModel(
        name: '',
        email: email,
        image: '', role: '', Position: '',
      );
    }

    return UserProfileModel.fromJson(row);
  }
}
