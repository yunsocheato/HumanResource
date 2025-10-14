import 'package:get/get.dart';

class LoadingUiController extends GetxController {
 var isLoading = false.obs;

 void  beginLoading (){
   isLoading.value = true;
 }

 void terminateLoading(){
   isLoading.value = false;
 }
}
