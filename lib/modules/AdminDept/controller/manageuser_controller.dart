import 'package:get/get.dart';
import '../Provider/manage_user_provider.dart';

class ManageUserController extends GetxController {
  final ManageUserProvider _provider = ManageUserProvider();

  final RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchManageUsers();
  }

  Future<void> fetchManageUsers() async {
    try {
      isLoading.value = true;

      final data = await _provider.fetchManageUsers();
      users.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
