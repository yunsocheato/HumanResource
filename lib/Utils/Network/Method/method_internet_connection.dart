import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Loadingui/ErrorScreen/Controller/NetworkError.dart';

class Nointernetmethod {
  final networkError = Get.put(NetworkError());
  Future<bool> checkServer() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com')).timeout(Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
