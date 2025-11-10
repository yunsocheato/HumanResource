import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/dashboard_get_mutiple1_data_model.dart';

final SupabaseClient _supabase = Supabase.instance.client;

Future<List<MutipleModel1>> fetchLeaveRequests() async {
  try {
    final response = await _supabase
        .from('signupuser')
        .select()
        .order('created_at', ascending: false);

    final List rows = response as List;

    return await Future.wait(
      rows.map((row) async {
        return MutipleModel1(
          title: row['name'] ?? 'name',
          photo: row['photo_url'] ?? '',
          description: 'Join as ${row['position'] ?? ''}',
          icon: Icons.person,
          color1: Colors.deepPurple,
          color2: Colors.deepPurpleAccent,
          iconBgColor: Colors.grey,
        );
      }),
    );
  } catch (e) {
    print("Fetch employees error: $e");
    return [];
  }
}

Future<List<MutipleModel1>> leaveRequestFuture() async {
  try {
    final response = await _supabase
        .from('leave_requests')
        .select()
        .order('created_at', ascending: true);

    final List rows = response as List;

    return await Future.wait(
      rows.map((row) async {
        return MutipleModel1(
          photo: row['photo_url'] ?? '',
          title: row['name'] ?? 'name',
          description:
              'Request Leave Type: ${row['request_type'] ?? ''}\nReason: ${row['reason'] ?? ''}',
          icon: Icons.calendar_month,
          color1: Colors.green,
          color2: Colors.lightGreen,
          iconBgColor: Colors.grey,
        );
      }),
    );
  } catch (e) {
    print("Fetch leave requests error: $e");
    return [];
  }
}

Future<List<MutipleModel1>> fetchCombined1() async {
  try {
    final results = await Future.wait([
      fetchLeaveRequests(),
      leaveRequestFuture(),
    ]);

    return [...results[0], ...results[1]];
  } catch (e) {
    print("Fetch combined1 error: $e");
    return [];
  }
}
