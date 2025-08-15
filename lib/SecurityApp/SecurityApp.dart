import 'package:get/get.dart';

class SecurityApp extends GetConnect{
  final client = GetConnect(
    timeout: const Duration(seconds: 10),
    httpClient: HttpClient(),
  );
}

