import 'package:flutter/material.dart';

class MyFormTextField extends StatelessWidget {
  MyFormTextField({
    super.key,
    required this.hint,
    required this.onCahnged,
  });
  final String hint;
  Function(String)? onCahnged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            return 'Field is requierd';
          }
        },
        cursorErrorColor: Colors.red,
        onChanged: onCahnged,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
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
