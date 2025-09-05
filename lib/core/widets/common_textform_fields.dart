import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool autocorrect;
  final bool obscureText;
  final TextEditingController controller;
  const CommonTextField(
      {super.key,
      required this.label,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.autocorrect = false,
      this.obscureText = false,
      required this.controller,
});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$label cannot be empty";
        }
        return null;
      },
    );
  }
}
