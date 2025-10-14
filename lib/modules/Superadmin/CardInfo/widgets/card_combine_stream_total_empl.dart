import 'package:rxdart/rxdart.dart'; // Required for combineLatest2
import '../models/card_attendance_model.dart';
import 'card_stream_percent_attendance.dart';
import '../API/card_stream_total_employee_sql.dart';

final CombineStreamAttendance = CombineLatestStream.combine2<int, int, AttendanceStats>(
  presentTodayStream(),
  totalEmployeesStream(),
      (int present, int total) {
    final percentage = total == 0 ? 0.0 : (present / total) * 100;
    return AttendanceStats(
      presentCount: present,
      percentage: percentage,
      totalCount: total, // Use total here
    );
  },
).asBroadcastStream();
