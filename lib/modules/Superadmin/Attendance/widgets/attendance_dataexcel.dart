import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Map<String, dynamic>>> fetchAllAttendance() async {
  const int pageSize = 800;
  int from = 0;
  bool hasMore = true;
  List<Map<String, dynamic>> allData = [];

  while (hasMore) {
    final to = from + pageSize - 1;

    final response = await Supabase.instance.client
        .from('attendance')
        .select()
        .range(from, to);

    final List<Map<String, dynamic>> pageData = List<Map<String, dynamic>>.from(response);

    if (pageData.isEmpty) {
      hasMore = false;
    } else {
      allData.addAll(pageData);
      from += pageSize;
    }
  }

  return allData;
}
