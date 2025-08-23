import 'package:get/get.dart';
import 'package:hrms/Core/user_profile_model.dart';
import 'package:hrms/Core/user_profile_sql.dart';

class userprofilecontroller extends GetxController{
  final _profileSql = FetchProfileSql();
  final userprofiles = Rxn<UserProfileModel>();


  @override
  void onInit() {
    super.onInit();
    _fetchuserProfile();

  }

  void _fetchuserProfile() async{
    final email = _profileSql.userEmail;
    if (email == null) return;
    userprofiles.bindStream(_profileSql.getProfileUser(email));
  }
}