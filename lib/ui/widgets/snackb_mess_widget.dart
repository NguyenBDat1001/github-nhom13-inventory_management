import 'package:flutter/material.dart';

class SnackBMessWidget extends StatelessWidget {
  const SnackBMessWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: Colors.amber.shade700,
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
  }
}
