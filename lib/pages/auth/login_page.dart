import 'package:flutter/material.dart';
import 'package:conn/pages/auth/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            const Text('Login Here'),
            const Text('Welcome back, you have been missed!'),
            const TextInput(text: 'Email'),
            const TextInput(text: 'Password'),
            const Text('Forgot password?'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignupPage(),
                  ),
                );
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignupPage(),
                  ),
                );
              },
              child: const Text('Create Account'),
            ),
            const Text('Or continue with'),
            Image.asset('images/google.png'),
            Image.asset('images/facebook.png'),
            Image.asset('images/apple.png'),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Add padding
      child: TextField(
        decoration: InputDecoration(
          hintText: text, // Placeholder
          filled: true,
          fillColor: const Color(0xFFF1F4FF), // Use correct background color in decoration
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
