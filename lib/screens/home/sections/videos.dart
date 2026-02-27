import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

Widget buildSermonSection() {
  // Replace these with actual YouTube Video IDs from your channel
  final List<String> videoIds = ['VIDEO_ID_1', 'VIDEO_ID_2', 'VIDEO_ID_3'];

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
    color: const Color(0xFFF8FAFC), // Very light blue/grey tint
    child: Column(
      children: [
        const Text(
          "Latest Sermons",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 25,
          runSpacing: 25,
          alignment: WrapAlignment.center,
          children: videoIds.map((id) => _sermonCard(id)).toList(),
        ),
      ],
    ),
  );
}

Widget _sermonCard(String id) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Container(
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              'https://img.youtube.com/vi/$id/maxresdefault.jpg', // Fetches YT thumbnail automatically
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Victory Through the Word",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
      ),
    ),
  ).animate().shimmer(delay: 400.ms);
}
