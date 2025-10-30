import 'package:get/get.dart';
import 'package:hrms/modules/AdminDept/Model/manageby_usermodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Provider/manage_user_provider.dart';

class ManageUserController extends GetxController {
  final ManageUserProvider _provider = ManageUserProvider();

  final userdata = <ManageByUsersModels>[].obs;
  var userRecord = <Map<String, dynamic>>[].obs;
  var currentUser = Rxn<User>();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        currentUser.value = session!.user;
        fetchManageUsers();
      } else if (event == AuthChangeEvent.signedOut) {
        currentUser.value = null;
        userdata.clear();
      }
    });

    currentUser.value = Supabase.instance.client.auth.currentUser;
    if (currentUser.value != null) {
      fetchManageUsers();
    }
  }

  @override
  void onClose() {
    super.onClose();
    userdata.clear();
  }

  Future<void> fetchManageUsers() async {
    try {
      isLoading.value = true;
      final data = await _provider.fetchManageUsers();
      userdata.value = data.map((e) => ManageByUsersModels.fromMap(e)).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
