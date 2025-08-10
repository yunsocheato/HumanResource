import 'dart:io'; // For SocketException
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../Loadingui/ErrorScreen/Controller/NetworkError.dart';

final networkError = Get.put(NetworkError());

Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://example.com/data'));
    if (response.statusCode == 200) {
    } else {
      networkError.error.value = 'Server error: ${response.statusCode}';
      await networkError.ErrorNetwork();
    }
  } on SocketException {
    networkError.error.value = 'No internet connection. Please check your network.';
    await networkError.ErrorNetwork();
  } catch (e) {
    networkError.error.value = 'Unexpected error: $e';
    await networkError.ErrorNetwork();
  }
}
