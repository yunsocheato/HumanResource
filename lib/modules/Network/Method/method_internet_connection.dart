import 'dart:io';
import 'package:get/get.dart';
import '../../Loadingui/ErrorScreen/Controller/NetworkError.dart';

class Nointernetmethod {

  final networkError = Get.put(NetworkError());
  Future<void> fetchData() async {
    networkError.isChecking.value = true;
    try {
      final result = await InternetAddress.lookup('172.20.20.98');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        networkError.error.value = '';
      } else {
        networkError.error.value = 'No internet connection';
      }
    } on SocketException catch (_) {
      networkError.error.value = 'No internet connection';
    } catch (e) {
      networkError.error.value = 'Error: $e';
    }finally {
      networkError.isChecking.value = false;
    }
  }
}
