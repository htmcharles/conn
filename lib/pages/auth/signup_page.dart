import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            const HeaderText(title: 'Create Account'),
            const SizedBox(height: 16),
            const TextInput(text: 'Full Name'),
            const TextInput(text: 'Email'),
            const TextInput(text: 'Password'),
            const TextInput(text: 'Confirm Password'),
            const SizedBox(height: 20),
            AuthButton(
              text: 'Sign Up',
              onPressed: () {
                // Handle sign up logic here
              },
            ),
            const SizedBox(height: 16),
            AuthTextButton(
              text: 'Already have an account? Login',
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back to login
              },
            ),
            const SizedBox(height: 16),
            const Text('Or sign up with'),
            const SizedBox(height: 16),
            const SocialIconsRow(),
          ],
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  final String title;

  const HeaderText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        const Text(
          'Join us and get started!',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AuthButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 50), // Adjust button size
      ),
    );
  }
}

class AuthTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AuthTextButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class SocialIconsRow extends StatelessWidget {
  const SocialIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialIcon(assetPath: 'images/google.png'),
        SizedBox(width: 16),
        SocialIcon(assetPath: 'images/facebook.png'),
        SizedBox(width: 16),
        SocialIcon(assetPath: 'images/apple.png'),
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String assetPath;

  const SocialIcon({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60, // Make the container square
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(8), // Optional: rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Shadow effect
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10), // Add padding to center the image
        child: Image.asset(assetPath, height: 40),
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
      child: SizedBox(
        width: 300, // Adjust width of the text field
        child: TextField(
          style: const TextStyle(color: Colors.black), // Set text color to black
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12), // Left padding
            hintText: text, // Placeholder
            hintStyle: const TextStyle(color: Colors.grey), // Hint text color
            filled: true,
            fillColor: const Color(0xFFF1F4FF), // Use correct background color in decoration
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
