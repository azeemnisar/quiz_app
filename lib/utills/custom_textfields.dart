import 'package:flutter/material.dart';

/// A reusable custom text field widget styled like the provided image
Widget buildCustomTextField(
  String hint,
  TextEditingController controller, {
  bool obscure = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF9F9F9), // light grey background
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.black26, // subtle border
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.black45, // slightly darker border when focused
            width: 1.2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
      ),
      style: const TextStyle(fontSize: 16, color: Colors.black),
    ),
  );
}
