import 'package:flutter/material.dart';

void showBar(BuildContext context,
      {required String text, required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
      ),
    );
  }