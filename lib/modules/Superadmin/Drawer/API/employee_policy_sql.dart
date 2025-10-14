import 'package:supabase_flutter/supabase_flutter.dart';

import '../Model/employee_policy_model.dart';

class employeepolicysql {
  Future<List<String>> fetchUsernameSuggestionsEmployee(String query) async {
    final result = await Supabase.instance.client
        .from('signupuser')
        .select('name')
        .ilike('name', query.isEmpty ? '%' : '%$query%');
    return List<String>.from(result.map((e) => e['name']));
  }

  Future<employeepolicymodel?> fetchUserByEmployee(String name) async {
    final results = await Supabase.instance.client
        .from('signupuser')
        .select()
        .ilike('name', '%$name%')
        .limit(1);

    if (results.isNotEmpty) {
      return employeepolicymodel.fromJson(results.first);
    } else {
      return null;
    }
  }
}
