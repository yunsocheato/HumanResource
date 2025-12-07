import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/schedule_model.dart';

class ScheduleSQL {
  Future<List<ScheduleModel>> getSchedule() async {
    final data = Supabase.instance.client;
    final response = await data
        .from('schedule')
        .select()
        .eq('is_active', true)
        .order('id', ascending: true);
    if (response.isEmpty) {
      throw Exception(response.isEmpty);
    }
    return response
        .map<ScheduleModel>((json) => ScheduleModel.fromJson(json))
        .toList();
  }
}
