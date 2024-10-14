import 'package:flutter/material.dart';
import 'social_icon.dart';

class SocialIconsRow extends StatelessWidget {
  const SocialIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialIcon(icon: Icons.facebook),
        SizedBox(width: 16),
        SocialIcon(icon: Icons.movie_creation_rounded),
        SizedBox(width: 16),
        SocialIcon(icon: Icons.apple),
      ],
    );
  }
}
