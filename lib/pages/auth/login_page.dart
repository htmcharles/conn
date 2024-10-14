import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../pages/feeds/feeds.dart'; // Import the Feeds page
import 'signup_page.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_text_button.dart';
import '../../widgets/header_text.dart';
import '../../widgets/auth/social_icons_row.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            const HeaderText(),
            const SizedBox(height: 16),
            // Email input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Password input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text('Forgot password?', style: TextStyle(color: Colors.blue)),
            const SizedBox(height: 20),
            // Login button
            AuthButton(
              text: 'Login',
              onPressed: () async {
                // Capture user input
                final email = _emailController.text;
                final password = _passwordController.text;

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter both email and password')),
                  );
                  return;
                }

                // Call login API
                final response = await http.post(
                  Uri.parse('http://10.0.2.2:5000/api/login'), // Update with your backend URL
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'email': email,  // Use user input
                    'password': password,  // Use user input
                  }),
                );

                if (response.statusCode == 200) {
                  // Handle successful login
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login successful!')),
                  );

                  // Navigate to the Feeds page
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const FeedsPage(), // Navigate to Feeds page
                    ),
                  );
                } else {
                  // Handle login error
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login failed!')),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            // Create Account button
            AuthTextButton(
              text: 'Create Account',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignupPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const Text('Or continue with'),
            const SizedBox(height: 16),
            const SocialIconsRow(),
          ],
        ),
      ),
    );
  }
}
