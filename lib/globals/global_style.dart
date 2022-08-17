import 'package:flutter/material.dart';

class GlobalStyle {
  static InputDecoration textFieldDecoration(String hint) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12.0),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide:
            BorderSide(width: 1, color: Color.fromARGB(255, 108, 99, 255)),
      ),
      hintText: hint,
    );
  }
}
