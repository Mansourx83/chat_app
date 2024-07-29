import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({
    super.key,
    required this.text,
    required this.function,
  });
  final String text;
  VoidCallback? function;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 60),
        ),
      ),
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
