import 'package:rxdart/rxdart.dart';

import '../models/card_attendance_model.dart';
import '../API/card_stream_total_employee_sql.dart';
import 'card_stream_percent_attendance.dart';

final CombineStreamAttendance =
    Rx.combineLatest2(presentTodayStream(), totalEmployeesStream(), (
      int present,
      int total,
    ) {
      return AttendanceStats(
        presentCount: present,
        totalCount: total,
        percentage: 0.0,
      );
    }).asBroadcastStream();
