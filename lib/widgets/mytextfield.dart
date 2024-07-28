import 'package:flutter/material.dart';

class MyFormTextField extends StatelessWidget {
  MyFormTextField({
    super.key,
    required this.hint,
    required this.onCahnged,
    this.iconButton,
    this.obscureText = false,
    this.isPassword = false,
  });

  final String hint;
  final Function(String)? onCahnged;
  final IconButton? iconButton;
  final bool obscureText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: isPassword ? obscureText : false,
        validator: (data) {
          if (data!.isEmpty) {
            return 'Field is required';
          }
          return null;
        },
        cursorErrorColor: Colors.red,
        onChanged: onCahnged,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          suffixIcon: isPassword ? iconButton : null,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
