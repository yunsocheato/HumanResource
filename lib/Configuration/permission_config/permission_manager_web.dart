import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:html' as html;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../Utils/SnackBar/snack_bar.dart';

Future<void> askAllPermissions() async {
  if (kIsWeb) {
    await requestWebNotificationPermission();
    await requestWebLocationPermission();
    await requestWebStoragePermission();
    await requestWebPhotoPermission();
    return;
  }

  await Permission.notification.request();
  await Permission.location.request();
  await Permission.storage.request();
  await Permission.photos.request();
}

Future<void> requestWebNotificationPermission() async {
  try {
    final result = await html.Notification.requestPermission();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAwesomeSnackBarGetx(
        "Errors",
        result == "granted"
            ? "Notification permission granted!"
            : "Notification permission denied!",
        ContentType.failure,
      );
    });
  } catch (_) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAwesomeSnackBarGetx(
        "Errors",
        "Notification permission denied!",
        ContentType.failure,
      );
    });
  }
}

Future<void> requestWebLocationPermission() async {
  try {
    await html.window.navigator.geolocation.getCurrentPosition();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAwesomeSnackBarGetx(
        "Location",
        "Location permission granted!",
        ContentType.success,
      );
    });
  } catch (_) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAwesomeSnackBarGetx(
        "Location",
        "Location permission denied!",
        ContentType.failure,
      );
    });
  }
}

Future<void> requestWebStoragePermission() async {
  try {
    // Create a hidden file input
    final upload = html.FileUploadInputElement();
    upload.accept = '*/*'; // Accept all file types or specify extensions
    upload.click(); // Open file picker

    // Listen when user selects a file
    upload.onChange.listen((event) {
      final files = upload.files;
      if (files != null && files.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAwesomeSnackBarGetx(
            "Storage",
            "User selected: ${files.first.name}",
            ContentType.success,
          );
        });
      }
    });
  } catch (e) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAwesomeSnackBarGetx("Storage", "Failed: $e", ContentType.failure);
    });
  }
}

Future<void> requestWebPhotoPermission() async {
  try {
    final picker =
        html.FileUploadInputElement()
          ..accept = 'image/*'
          ..click();

    picker.onChange.listen((event) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAwesomeSnackBarGetx(
          "Photo",
          "User selected a photo",
          ContentType.success,
        );
      });
    });
  } catch (e) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAwesomeSnackBarGetx("Photo", "Failed: $e", ContentType.failure);
    });
  }
}
