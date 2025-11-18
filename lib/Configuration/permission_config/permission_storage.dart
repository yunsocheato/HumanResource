import 'package:permission_handler/permission_handler.dart';

Future<bool> checkStoragePermission() async {
  final status = await Permission.storage.status;
  return status.isGranted;
}

Future<bool> requestStoragePermission() async {
  final status = await Permission.storage.request();
  return status.isGranted;
}
