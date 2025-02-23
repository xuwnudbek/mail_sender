import 'package:flutter/material.dart';

class CustomSnackbars {
  static void showSnackBar(
    BuildContext context,
    String message,
    Color color,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        closeIconColor: Colors.white,
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        width: 400,
        duration: Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
  }

  static void success(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    showSnackBar(context, message, Colors.green);
  }

  static void error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    showSnackBar(context, message, Colors.red);
  }

  static void warning(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    showSnackBar(context, message, Colors.orange);
  }
}
