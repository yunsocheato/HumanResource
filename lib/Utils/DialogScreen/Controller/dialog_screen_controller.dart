import 'package:get/get.dart';

class DialogScreenController extends GetxController{
  final isLoading = false.obs;
  final isExpanded = false.obs;

  void toggleLoading() => isLoading.value = true ;
  void toggleExpanded() => isExpanded.toggle();
  void hideLoading() => isLoading.value = false;

}