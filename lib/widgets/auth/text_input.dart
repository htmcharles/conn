import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String text;

  const TextInput({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16), // Add bottom margin for spacing
        child: TextField(
          decoration: InputDecoration(
            labelText: text,
            border: const OutlineInputBorder(),
          ),
          obscureText: text == 'Password', // Hide password input
        ),
      ),
    );
  }
}
