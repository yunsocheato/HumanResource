import 'dart:typed_data';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

Widget buildProfileAvatar(String path) {
  if (path.isEmpty) {
    return const CircleAvatar(
      radius: 50,
      child: Icon(Icons.person, size: 50),
    );
  }

  if (path.startsWith('http')) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(path),
    );
  }

  // Local file → use XFile
  return FutureBuilder<Uint8List>(
    future: XFile(path).readAsBytes(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircleAvatar(
          radius: 50,
          child: CircularProgressIndicator(),
        );
      }
      if (!snapshot.hasData) {
        return const CircleAvatar(
          radius: 50,
          child: Icon(Icons.person, size: 50),
        );
      }
      return CircleAvatar(
        radius: 50,
        backgroundImage: MemoryImage(snapshot.data!),
      );
    },
  );
}
