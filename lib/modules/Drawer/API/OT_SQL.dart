import 'package:hrms/modules/Drawer/Model/OT_Model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OTPolicySql {

  Future<List<String>> fetchUsernameSuggestionsOTPolicy(String query) async {
    final result = await Supabase.instance.client
        .from('signupuser')
        .select('name')
        .ilike('name', query.isEmpty ? '%' : '%$query%');
    return List<String>.from(result.map((e) => e['name']));
  }

  Future<OTModel?> fetchUserByOTPolicy(String name) async {
    final results = await Supabase.instance.client
        .from('signupuser')
        .select()
        .ilike('name', '%$name%')
        .limit(1);
    return (results.isNotEmpty) ? OTModel.fromJson(results.first) : null;

  }
}