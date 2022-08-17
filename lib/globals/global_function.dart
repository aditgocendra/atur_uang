import 'package:flutter/material.dart';

class GlobalFunction {
  static void snackbarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 108, 99, 255),
        content: Text(message),
        action: SnackBarAction(
          label: 'Ok',
          textColor: Colors.white,
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }
}
