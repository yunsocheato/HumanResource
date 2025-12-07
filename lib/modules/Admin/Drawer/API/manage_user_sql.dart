import 'package:supabase_flutter/supabase_flutter.dart';
import '../Model/employee_policy_model.dart';

class ManageUserSQL {
  final _client = Supabase.instance.client;

  Future<List<String>> fetchUsernameSuggestionsManageuser(String query) async {
    if (query.isEmpty) return [];

    try {
      final result = await _client
          .from('signupuser')
          .select('name')
          .ilike('name', '%$query%');

      if (result.isEmpty) return [];

      return List<String>.from(
        result.map((e) => e['name'] as String? ?? ''),
      ).where((name) => name.isNotEmpty).toList();
    } catch (e) {
      return [];
    }
  }

  Future<employeepolicymodel?> fetchUserByManageuser(String name) async {
    if (name.isEmpty) return null;

    try {
      final results = await _client
          .from('signupuser')
          .select()
          .ilike('name', '%$name%')
          .limit(1);

      if (results.isNotEmpty) {
        return employeepolicymodel.fromJson(results.first);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
