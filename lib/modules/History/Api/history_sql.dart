import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/history_model.dart' show HistoryModel;

class HistorySql {

  Future<List<HistoryModel>> fetchHistory() async {
    final database = Supabase.instance.client;
    try {
      final response = await database.from('history').select();
      final data = response as List<dynamic>;
      return data
          .map((e) => HistoryModel.fromjson(e as Map<String, dynamic>))
          .toList();
    }catch (e) {
      return[];
    }
  }
}