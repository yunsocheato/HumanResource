import 'package:permission_handler/permission_handler.dart';

Future<bool> CheckLocationPermission() async {
  final status = await Permission.location.status;
  return status.isGranted;
}

Future<bool> requestLocationPermission() async {
  final status = await Permission.location.request();
  return status.isGranted;
}
