//signip_page.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_text_button.dart';
import '../../widgets/header_text.dart';
import '../../widgets/auth/social_icons_row.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Controllers to get the user's input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedGender; // Variable to hold the selected gender

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView( // Allow scrolling
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeaderText(),
              const SizedBox(height: 16),
              // Name input field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
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
              const SizedBox(height: 16),
              // Gender selection
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButtonFormField<String>(
                  value: _selectedGender,
                  hint: const Text('Select Gender'),
                  items: <String>['Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Sign-up button
              AuthButton(
                text: 'Sign Up',
                onPressed: () async {
                  // Capture user input
                  final name = _nameController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  if (name.isEmpty || email.isEmpty || password.isEmpty || _selectedGender == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                    return;
                  }

                  // Call signup API
                  final response = await http.post(
                    Uri.parse('http://10.0.2.2:5000/api/signup'), // Update with your backend URL
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, dynamic>{
                      'name': name,  // Use user input
                      'email': email,  // Use user input
                      'password': password,  // Use user input
                      'gender': _selectedGender,  // Use selected gender
                    }),
                  );

                  if (response.statusCode == 201) {
                    // Handle successful signup
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signup successful!')),
                    );
                  } else {
                    // Handle signup error
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signup failed!')),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              // Navigation to login page
              AuthTextButton(
                text: 'Already have an account?',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              const SocialIconsRow(),
            ],
          ),
        ),
      ),
    );
  }
}
