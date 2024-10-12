import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Login Here'),
            Text('Welcome back you have been missed!'),
            TextInput(text: 'Email'),
            TextInput(text: 'Password'),
            Text('Forgot password'),
            
          ],
        ),
      ),
    );
  }
}
class TextInput extends StatelessWidget {
  final String text;

  const TextInput({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: text, // For placeholder
      ),
      style: const TextStyle(
        backgroundColor: Color(0xFFF1F4FF), // Use correct color definition
      ),
    );
  }
}
