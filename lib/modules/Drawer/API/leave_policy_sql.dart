import 'package:supabase_flutter/supabase_flutter.dart';
import '../Model/leave_policy_model.dart';


class LeavePolicySQL {


  Future<List<String>> fetchUsernameSuggestionsLeavePolicy(String query) async {
    final result = await Supabase.instance.client
        .from('signupuser')
        .select('name')
        .ilike('name', query.isEmpty ? '%' : '%$query%');
    return List<String>.from(result.map((e) => e['name']));
  }


  Future<LeavePolicyModel?> fetchUserByLeavePolicy(String name) async {
    final results = await Supabase.instance.client
        .from('signupuser')
        .select()
        .ilike('name', '%$name%')
        .limit(1);

    if (results.isNotEmpty) {
      return LeavePolicyModel.fromJson(results.first);
    } else {
      return null;
    }
  }
}