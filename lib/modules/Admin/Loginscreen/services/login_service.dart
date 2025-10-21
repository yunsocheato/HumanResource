import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../Permission/Permission.dart';
import '../../../../Utils/Network/Method/method_internet_connection.dart';

class LoginService {
  final SupabaseClient _client = Supabase.instance.client;
  final Nointernetmethod CheckingEnternetError = Nointernetmethod();

  Future<Map<String, dynamic>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    print('Response: $response');
    final user = response.user;
    print('User: $user');

    if (user == null) {
      throw AuthException('Invalid email or password');
    }

    final roleResult =
        await _client
            .from('signupuser')
            .select('role')
            .eq('user_id', user.id)
            .maybeSingle();
    print('Role query result: $roleResult');

    if (roleResult == null || roleResult['role'] == null) {
      throw Exception('User role not found');
    }

    final roleString = roleResult['role']?.toString().toLowerCase();
    final UserRole? role = UserRoleExtension.fromString(roleString ?? '');
    print('Converted UserRole: $role');

    if (role == null) {
      throw Exception('Invalid role assigned to user: ${roleResult['role']}');
    }

    return {'user': user, 'role': role};
  }

  Future<bool> checkServer() async {
    try {
      final response = await http
          .get(Uri.parse('http://172.20.20.98'))
          .timeout(Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
