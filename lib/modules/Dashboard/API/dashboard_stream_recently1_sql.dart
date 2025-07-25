import '../../LeaveRequest/API/leave_stream_rpc_sql.dart';
import '../models/dashboard_model.dart';

Stream<List<DashboardModel>> streamSignupUserAsModel() {
  return supabase
      .from('signupuser')
      .stream(primaryKey: ['user_id']) // Replace 'id' with your actual primary key
      .order('email', ascending: true)
      .map((rows) => rows.map((row) => DashboardModel.fromJson(row)).toList());

}

