// login_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<Map<String, dynamic>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) {
      throw AuthException('Invalid email or password');
    }

    final roleResult = await _client
        .from('signupuser')
        .select('role')
        .eq('user_id', user.id)
        .maybeSingle();

    if (roleResult == null || roleResult['role'] == null) {
      throw Exception('User role not found');
    }

    return {
      'user': user,
      'role': roleResult['role'],
    };
  }
}
