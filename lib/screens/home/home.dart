import 'package:destinychristianchurchintl/screens/home/sections/footer.dart'
    show buildFooter;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/parish.dart';
import 'sections/go_section.dart';
import 'sections/videos.dart';

class DCCIHomePage extends StatelessWidget {
  const DCCIHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildNavBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            buildGOSection(context),
            _buildBranchSection(),
            buildSermonSection(),
            // buildGivingSection(),
            buildFooter(),
          ],
        ),
      ),
    );
  }

  // 1. Sleek Navigation Bar
  PreferredSizeWidget _buildNavBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Image.asset('assets/dcclogo.png', height: 50),
      actions: [
        if (MediaQuery.of(context).size.width > 800) ...[
          _navItem("Home"),
          _navItem("About"),
          _navItem("Branches"),
          _navItem("Sermons"),
          _navButton("Give Online"),
        ] else
          IconButton(
            icon: Icon(Icons.menu, color: Colors.blue),
            onPressed: () {},
          ),
      ],
    );
  }

  // 2. Hero Section (Dynamic & Elegant)
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade900, Colors.blue.shade400],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "DESTINY CHRISTIAN CHURCH\nINTERNATIONAL",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3),
            const SizedBox(height: 20),
            Text(
              "...Changing the world with the word",
              style: TextStyle(color: Colors.white70, fontSize: 20),
            ).animate().fadeIn(delay: 500.ms),
          ],
        ),
      ),
    );
  }

  // 3. Branches Section (Responsive Grid)
  Widget _buildBranchSection() {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: [
          const Text(
            "Our Parishes in Aba",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: dcciParishes.map((p) => _parishCard(p)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _parishCard(Parish p) {
    return Container(
      width: 350,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            p.name,
            style: TextStyle(
              fontSize: 22,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.location_on, color: Colors.blue),
            title: Text(p.address),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today, color: Colors.blue),
            title: Text(
              "Sunday: ${p.sunday}\nWed: ${p.weekday}\nFri: ${p.prayer}",
            ),
          ),
        ],
      ),
    ).animate().scale(delay: 200.ms);
  }

  // Helper Widgets
  Widget _navItem(String title) => TextButton(
    onPressed: () {},
    child: Text(title, style: TextStyle(color: Colors.black87)),
  );

  Widget _navButton(String title) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () {},
      child: Text(title),
    ),
  );
}
