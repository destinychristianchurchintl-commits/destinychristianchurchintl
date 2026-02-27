import 'package:flutter/material.dart';

Widget buildFooter() {
  return Container(
    padding: const EdgeInsets.all(60),
    color: const Color(0xFF0D47A1), // Deep Blue
    child: Column(
      children: [
        Image.asset('assets/dcclogo.png', height: 80), // Logo in footer
        const SizedBox(height: 30),
        Wrap(
          spacing: 30,
          children: [
            _socialIcon(Icons.facebook),
            _socialIcon(Icons.camera_alt), // Instagram
            _socialIcon(Icons.play_circle_fill), // YouTube
          ],
        ),
        const SizedBox(height: 40),
        const Divider(color: Colors.white24),
        const SizedBox(height: 20),
        const Text(
          "© 2026 Destiny Christian Church International. All Rights Reserved.",
          style: TextStyle(color: Colors.white70),
        ),
      ],
    ),
  );
}

Widget _socialIcon(IconData icon) {
  return IconButton(
    icon: Icon(icon, color: Colors.white, size: 28),
    onPressed: () {}, // Link to your pages here
  );
}
