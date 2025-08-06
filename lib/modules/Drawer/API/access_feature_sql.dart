
import 'package:hrms/modules/Drawer/Model/employee_policy_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Model/access_feature_model.dart';

class AccessFeatureSQL {
  Future<List<String>> fetchUsernameSuggestionsAccessFeature(String query) async {
    final result = await Supabase.instance.client
        .from('signupuser')
        .select('name')
        .ilike('name', query.isEmpty ? '%' : '%$query%');
    return List<String>.from(result.map((e) => e['name']));
  }

  Future<AccessFeatureModel?> fetchUserByAccessFeature(String name) async {
    final userData =
    await Supabase.instance.client
        .from('signupuser')
        .select()
        .ilike('name', name)
        .maybeSingle();

    if (userData != null) {
      return AccessFeatureModel.fromJson(userData);
    } else {
      return null;
    }
  }

}
