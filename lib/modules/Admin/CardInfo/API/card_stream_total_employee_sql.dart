import 'package:supabase_flutter/supabase_flutter.dart';

Stream<int> totalEmployeesStream() {
  return Supabase.instance.client
      .from('signupuser')
      .stream(primaryKey: ['id'])
      .map((data) => data.length);
}
