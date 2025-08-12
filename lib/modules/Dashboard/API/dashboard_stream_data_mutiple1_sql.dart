import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/dashboard_get_mutiple1_data_model.dart';

final SupabaseClient supabase = Supabase.instance.client;

Stream<List<MutipleModel1>> employeeStream() {
  return supabase
      .from('signupuser')
      .stream(primaryKey: ['user_id'])
      .order('created_at', ascending: false)
      .map((rows) =>
      rows.map((row) =>
          MutipleModel1(
            title: row['name'] ?? 'name',
            photo: row['photo_url'] ?? '',
            description: 'join as ${row['position'] ?? ''}',
            icon: Icons.person,
            color1: Colors.deepPurple,
            color2: Colors.deepPurpleAccent,
            iconBgColor: Colors.grey,
          )).toList());
}

Stream<List<MutipleModel1>> leaveRequestStream() {
  return supabase
      .from('leave_requests')
      .stream(primaryKey: ['user_id'])
      .order('created_at', ascending: false)
      .map((rows) =>
      rows.map((row) =>
          MutipleModel1(
            photo: row['photo_url'] ?? '',
            title: row['name'] ?? 'name',
            description: 'Request Leave Type: ${row['request_type'] ?? ''}\nReason: ${row['reason'] ?? ''}',
            icon: Icons.calendar_month,
            color1: Colors.green,
            color2: Colors.lightGreen,
            iconBgColor: Colors.grey,
          )).toList());}

final Stream<List<MutipleModel1>> combinedStream1 = Rx.combineLatest2(
  employeeStream(),
  leaveRequestStream(),
      (List<MutipleModel1> e, List<MutipleModel1> l) => [...e, ...l],
).asBroadcastStream();

