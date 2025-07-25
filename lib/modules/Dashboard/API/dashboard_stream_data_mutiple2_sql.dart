import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/dashboard_get_mutiple2_data_model.dart';

final SupabaseClient supabase = Supabase.instance.client;

Stream<List<MutipleModel2>> employeeStreams() {
  final today = DateTime.now();

  return supabase
      .from('singupuser_fit_attendance')
      .stream(primaryKey: ['id'])
      .order('timestamp', ascending: false)
      .map((rows) {
        return rows
            .where((row) {
              final ts = DateTime.tryParse(row['timestamp'] ?? '');
              return ts != null &&
                  ts.year == today.year &&
                  ts.month == today.month &&
                  ts.day == today.day;
            })
            .map(
              (row) => MutipleModel2(
                title: 'Scan Record',
                description:
                    '${row['username'] ?? ''}  \n check in at ${row['timestamp'] ?? ''}',
                icon: Icons.group_add,
                color1: Colors.deepPurple,
                color2: Colors.deepPurpleAccent,
                iconBgColor: Colors.grey,
              ),
            )
            .toList();
      });
}

final Stream<List<MutipleModel2>> combinedStream2 = employeeStreams();
