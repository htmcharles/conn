import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;

  const SocialIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      iconSize: 30,
      onPressed: () {
        // Handle social icon button press
      },
    );
  }
}
