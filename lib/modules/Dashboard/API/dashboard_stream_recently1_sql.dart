import '../../LeaveRequest/API/leave_stream_rpc_sql.dart';
import '../models/dashboard_model.dart';

Future<List<DashboardModel>> FetchUserasModel() async {
 try{
   final response = await supabase
       .from('signupuser')
       .select()
       .order('email', ascending: true);
   return (response as List).map((e) => DashboardModel.fromJson(e)).toList();
 } catch(e){
   return [];
 }
}

