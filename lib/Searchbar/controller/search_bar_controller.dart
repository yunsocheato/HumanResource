import 'package:get/get.dart';

class SearchBarController extends GetxController {
  final RxString searchQuery = ''.obs;
  final RxList<dynamic> searchResults = <dynamic>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSearching = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 0.obs;
  final RxInt pageSize = 10.obs;
  final RxInt totalItems = 0.obs;
  final RxBool hasMorePages = true.obs;
  final RxBool isRefreshing = false.obs;

  Future<void> search(String query) async {
    try {
      isLoading.value = true;
      isSearching.value = true;
      hasError.value = false;
      errorMessage.value = '';
      searchQuery.value = query;
      searchResults.clear();
      currentPage.value = 0;
      hasMorePages.value = true;

      final dummyData = List.generate(100, (index) => 'Item $index');
      final filtered = dummyData
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();

      totalItems.value = filtered.length;

      final paginated = filtered.take(pageSize.value).toList();
      searchResults.assignAll(paginated);

      hasMorePages.value = filtered.length > pageSize.value;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'An error occurred while searching.';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
      isSearching.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever(searchQuery, (query) {
      if (query.toString().isNotEmpty) {
        search(query.toString());
      }
    }, condition : const Duration(milliseconds: 500));
  }
}
