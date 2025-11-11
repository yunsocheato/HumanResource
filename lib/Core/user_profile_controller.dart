import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hrms/Core/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfileController extends GetxController {
  var userprofiles = Rxn<UserProfileModel>();

  @override
  void onInit() {
    super.onInit();

    fetchUserProfile();

    Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      fetchUserProfile();
    });
  }

  Future<void> fetchUserProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      userprofiles.value = null;
      return;
    }

    final data =
        await Supabase.instance.client
            .from('signupuser')
            .select()
            .eq('user_id', user.id)
            .maybeSingle();

    if (data != null) {
      userprofiles.value = UserProfileModel.fromMap(data);
    }
  }
}
