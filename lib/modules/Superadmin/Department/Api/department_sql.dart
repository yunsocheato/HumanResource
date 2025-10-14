import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/department_model.dart';

class DepartmentSQL {
  final data = Supabase.instance.client;
  String? get userEmail => Supabase.instance.client.auth.currentUser?.email;

  Future<List<DepartmentModel>> getUsersByDepartment() async {
    final response = await data
        .from('signupuser')
        .select('name , department , position');
    return (response as List)
        .map((json) => DepartmentModel.fromJson(json))
        .toList();
  }
}
