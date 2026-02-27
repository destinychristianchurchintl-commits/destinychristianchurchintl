import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildGOSection(BuildContext context) {
  bool isMobile = MediaQuery.of(context).size.width < 800;

  return Container(
    padding: EdgeInsets.symmetric(
      vertical: 80,
      horizontal: isMobile ? 20 : 100,
    ),
    color: Colors.white,
    child: Flex(
      direction: isMobile ? Axis.vertical : Axis.horizontal,
      children: [
        // GO Image
        Expanded(
          flex: isMobile ? 0 : 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://via.placeholder.com/500x600', // Replace with Actual GO Photo
              fit: BoxFit.cover,
            ),
          ).animate().fadeIn(duration: 1.seconds).slideX(begin: -0.2),
        ),
        const SizedBox(width: 50, height: 30),
        // GO Bio
        Expanded(
          flex: isMobile ? 0 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "OUR LEADERSHIP",
                style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "The Visionary: [GO Name Here]",
                style: GoogleFonts.montserrat(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Under the divine guidance of our General Overseer, DCCI has grown into a beacon of hope in Aba and beyond. Our mission remains rooted in changing the world through the unadulterated word of God.",
                style: TextStyle(
                  fontSize: 18,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
