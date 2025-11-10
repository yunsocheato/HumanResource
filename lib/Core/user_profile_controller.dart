import 'package:get/get.dart';
import 'package:hrms/Core/user_profile_sql.dart';
import 'user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfileController extends GetxController {
  Rx<UserProfileModel?> userprofiles = Rxn<UserProfileModel>();

  @override
  void onInit() {
    super.onInit();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final email = Supabase.instance.client.auth.currentUser?.email;

    if (email == null) return;

    try {
      final profile = await FetchProfileSql(email);
      userprofiles.value = profile;
    } catch (e) {
      userprofiles.value = UserProfileModel(
        name: 'No Name',
        image: 'No Image',
        role: 'No Role',
        Position: 'No Position',
      );
    }
  }
}
