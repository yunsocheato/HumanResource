import 'package:hrms/modules/AdminDept/Model/leave_card_balance_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaveCardBalanceProvider {
  Future<List<LeaveCardModel>> getAllLeaveRecordBalance() async {
    try {
      final _supabase = Supabase.instance.client;
      final _user = _supabase.auth.currentUser;

      if (_user == null) {
        return [];
      }

      final response = await _supabase
          .from('leaverecord')
          .select('annualleave, maternityleave, unpaidleave, sickleave')
          .eq('user_id', _user.id)
          .order('id', ascending: true);
      return (response as List<dynamic>)
          .map((e) => LeaveCardModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
