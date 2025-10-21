import 'package:get/get.dart';
import 'package:hrms/Core/user_profile_model.dart';
import 'package:hrms/Core/user_profile_sql.dart';

class UserProfileController extends GetxController {
  final _profileSql = FetchProfileSql();
  Rx<UserProfileModel?> userprofiles = Rxn<UserProfileModel>();

  @override
  void onInit() {
    super.onInit();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final email = _profileSql.userEmail;
    if (email == null) return;

    final profile = await _profileSql.ProfileImage(email);
    userprofiles.value = profile;
  }
}
