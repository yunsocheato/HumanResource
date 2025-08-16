import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../Model/employee_checkin_model.dart';
class empoloyeecheckINSQL {

  Stream<List<EmployeeCheckinModel>> employeecheckin() {
    final stream = Supabase.instance.client
        .from('singupuser_fit_attendance')
        .stream(primaryKey: ['id'])
        .eq('check_type', 'Check-in')
        .order('id', ascending: true);
    return stream.map(
          (event) => event.map((e) => EmployeeCheckinModel.fromJson(e)).toList(),
    );
  }

  Stream<List<EmployeeCheckinCountModel>>employeecheckinCount(){
    final count =  Supabase.instance.client
        .from('summarycountattendance')
        .stream(primaryKey: ['id'])
        .order('checkin_count', ascending: true);
    return count.map((event) => event.map((e) => EmployeeCheckinCountModel.fromJson(e)).toList());

  }
}