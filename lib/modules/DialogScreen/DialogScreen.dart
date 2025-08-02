import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void DialogScreen(BuildContext context, Widget content) {
  final isMobile = MediaQuery.of(context).size.width < 600;

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        insetPadding: EdgeInsets.all(16), // dialog margin
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 500,
          constraints: BoxConstraints(maxHeight: 350),
          child: content,
        ),
      );
    },
  );
}
