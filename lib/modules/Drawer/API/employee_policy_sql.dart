import 'package:hrms/modules/Drawer/Model/employee_policy_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class employeepolicysql {
  Future<List<String>> fetchUsernameSuggestionsEmployee(String query) async {
    final result = await Supabase.instance.client
        .from('signupuser')
        .select('name')
        .ilike('name', query.isEmpty ? '%' : '%$query%');
    return List<String>.from(result.map((e) => e['name']));
  }

  Future<employeepolicymodel?> fetchUserByEmployee(String name) async {
    final userData =
        await Supabase.instance.client
            .from('signupuser')
            .select()
            .ilike('name', name)
            .maybeSingle();

    if (userData != null) {
      return employeepolicymodel.fromJson(userData);
    } else {
      return null;
    }
  }

  Future<void>UpdateUser(employeepolicymodel user) async {
    final userData = await Supabase.instance.client
        .from('signupuser')
        .insert(user.toJson())
        .eq('name', user.name)
        .select();
    if(userData.isEmpty != null){
      throw Exception('Failed to update user: No matching user found');
    }
  }
}
