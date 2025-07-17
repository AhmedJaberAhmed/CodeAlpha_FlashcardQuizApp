import 'package:flutter/material.dart';

AppBar HomeAppBar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 2,
    title: const Text(
      "Flashcard Quiz",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ),
  );
}
