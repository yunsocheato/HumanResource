import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool is_sucess = true;
bool is_warning = false;
bool is_error = false;

void showAwesomeSnackBarGetx(String title, String message, ContentType type) {
  final ctx = Get.context;
  if (ctx == null) {
    print("Cannot show SnackBar: Get.context is null");
    return;
  }

  final snackBar = SnackBar(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    behavior: SnackBarBehavior.floating,
    animation: null,
    duration: Duration(seconds: 3),
    backgroundColor: Colors.transparent,

    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: type,
      inMaterialBanner: true,
    ),
  );

  ScaffoldMessenger.of(ctx)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
