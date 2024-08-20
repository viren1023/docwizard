import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message) {
  // Create the SnackBar widget with the provided message
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
  );

  // Use ScaffoldMessenger to show the SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
