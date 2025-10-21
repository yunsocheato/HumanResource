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
    final results = await Supabase.instance.client
        .from('signupuser')
        .select()
        .ilike('name', '%$name%')
        .limit(1);

    if (results.isNotEmpty) {
      return AccessFeatureModel.fromJson(results.first);
    } else {
      return null;
    }
  }

}
