import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

void main() => runApp(const DestinyApp());

class DestinyApp extends StatelessWidget {
  const DestinyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Destiny Christian Church International",
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF020817),
        primaryColor: const Color(0xFFD4AF37),
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
      ),
      home: const HomeScreen(),
    );
  }
}

/* ---------------- SCROLL REVEAL ---------------- */

class ScrollReveal extends StatefulWidget {
  final Widget child;
  const ScrollReveal({super.key, required this.child});

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.hashCode.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !visible) {
          setState(() => visible = true);
        }
      },
      child: widget.child
          .animate(target: visible ? 1 : 0)
          .fadeIn(duration: 800.ms)
          .slideY(begin: 0.4, duration: 800.ms, curve: Curves.easeOutCubic)
          .scale(begin: const Offset(0.96, 0.96)),
    );
  }
}


/* ---------------- HOME ---------------- */

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _visionKey = GlobalKey();
  final _branchesKey = GlobalKey();
  final _sermonKey = GlobalKey();
  final _givingKey = GlobalKey();
  final _goKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final box = key.currentContext!.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero).dy + _scrollController.offset;

    _scrollController.animateTo(
      offset - 80,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _navBar(isMobile),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            _HeroSection(key: _heroKey, isMobile: isMobile),
            ScrollReveal(child: _VisionMissionSection(key: _visionKey)),
            ScrollReveal(child: _BranchesSection(key: _branchesKey)),
            ScrollReveal(child: _SermonSection(key: _sermonKey)),
            ScrollReveal(child: _AboutSection(key: _aboutKey)),
            ScrollReveal(child: _GivingSection(key: _givingKey)),
            ScrollReveal(
              child: _GOSection(key: _goKey, isMobile: isMobile),
            ),
            const _ContactSection(),

            const _Footer(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _navBar(bool isMobile) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 4,
            sigmaY: 4,
          ), // lighter blur for web
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),
      ),
      title: Row(
        children: [
          Image.asset('assets/icon/icon.png', width: 36, height: 36),
          const SizedBox(width: 10),
          if (!isMobile)
            Text(
              "DCCI",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
        ],
      ),
      actions: isMobile
          ? null
          : [
              _navBtn("HOME", _heroKey),
              _navBtn("VISION", _visionKey),
              _navBtn("BRANCHES", _branchesKey),
              _navBtn("MESSAGES", _sermonKey),
              _navBtn("ABOUT", _aboutKey),
              _navBtn("GIVE", _givingKey),
              const SizedBox(width: 30),
            ],
    );
  }

  Widget _navBtn(String label, GlobalKey key) {
    return TextButton(
      onPressed: () => _scrollTo(key),
      child: Text(
        label,
        style: const TextStyle(letterSpacing: 2, fontSize: 12),
      ),
    );
  }
}

/* ---------------- HERO ---------------- */
class _HeroSection extends StatelessWidget {
  final bool isMobile;
  const _HeroSection({super.key, required this.isMobile});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://raw.githubusercontent.com/destinychristianchurchintl-commits/image_dump/refs/heads/main/photo-1438232992991-995b7058bbb3.jpeg',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TypewriterAnimatedText(
                    "DESTINY CHRISTIAN CHURCH INTERNATIONAL",
                    textAlign: TextAlign.center,
                    textStyle: GoogleFonts.montserrat(
                      fontSize: isMobile ? 30 : 60,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "...changing the world with the word",
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                color: Color(0xFFD4AF37),
                fontStyle: FontStyle.italic,
              ),
            ).animate().fadeIn(delay: 2.seconds),
          ],
        ),
      ),
    );
  }
}

/* ---------------- VISION ---------------- */
class _VisionMissionSection extends StatelessWidget {
  const _VisionMissionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      color: const Color(0xFF0B1220),
      child: Center(
        child: isMobile
            ? Column(
                children: const [
                  _VisionCard(
                    title: "OUR VISION",
                    text: "Changing the world with the Word.",
                  ),
                  SizedBox(height: 40),
                  _VisionCard(
                    title: "OUR MISSION",
                    text: "Making Men Heavenly Conscious and Earthly Relevant",
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _VisionCard(
                    title: "OUR VISION",
                    text: "Changing the world with the Word.",
                  ),
                  SizedBox(width: 60),
                  _VisionCard(
                    title: "OUR MISSION",
                    text: "Making Men Heavenly Conscious and Earthly Relevant",
                  ),
                ],
              ),
      ),
    );
  }
}

class _VisionCard extends StatelessWidget {
  final String title;
  final String text;
  const _VisionCard({required this.title, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width < 900 ? double.infinity : 500,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4AF37),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                height: 1.8,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      child: Column(
        children: const [
          Text(
            "ABOUT DCCI",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: 800,
            child: Text(
              "Destiny Christian Church International is a vibrant apostolic ministry committed to raising a people of destiny empowered by the Word and the Spirit to dominate in life.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                height: 1.8,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }
}

/* ---------------- GIVING ---------------- */
class _GivingSection extends StatelessWidget {
  const _GivingSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120),
      color: const Color(0xFFD4AF37),
      child: Wrap(
        spacing: 40,
        runSpacing: 40,
        alignment: WrapAlignment.center,
        children: const [
          _AccountCard(
            title: "LOCAL ACCOUNT",
            details: "Union Bank\nAcct No: 0123456789",
          ),
          _AccountCard(
            title: "DOMICILIARY (USD)",
            details: "Union Bank\nAcct No: 1234567890",
          ),
        ],
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final String title;
  final String details;
  const _AccountCard({required this.title, required this.details});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFD4AF37),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            details,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
} /* ---------------- GO SECTION ---------------- */

class _GOSection extends StatelessWidget {
  final bool isMobile;
  const _GOSection({super.key, required this.isMobile});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      child: Column(
        children: const [
          Text(
            "OUR GENERAL OVERSEER",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: 800,
            child: Text(
              "Rev. Prof. Dennis is a visionary apostolic leader with a mandate to raise a people of destiny through the transforming power of the Word and the Spirit.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                height: 1.8,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
} /* ---------------- FOOTER ---------------- */

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.facebook),
              SizedBox(width: 30),
              FaIcon(FontAwesomeIcons.youtube),
              SizedBox(width: 30),
              FaIcon(FontAwesomeIcons.instagram),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "© 2026 DESTINY CHRISTIAN CHURCH INTERNATIONAL",
            style: TextStyle(fontSize: 12, color: Colors.white38),
          ),
        ],
      ),
    );
  }
}
/* ---------------- SERMON FIX ---------------- */

class _SermonSection extends StatefulWidget {
  const _SermonSection({super.key});

  @override
  State<_SermonSection> createState() => _SermonSectionState();
}

class _SermonSectionState extends State<_SermonSection> {
  final videos = const ["IQFOMyAzJ3M", "Ml5R1Oyur4o", "GDiJPCnHCRc"];

  final Map<int, YoutubePlayerController> controllers = {};
  final Set<int> initialized = {};

  @override
  void dispose() {
    for (final c in controllers.values) {
      c.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "FEATURED SERMONS",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: List.generate(videos.length, (index) {
              return VisibilityDetector(
                key: Key("video_$index"),
                onVisibilityChanged: (info) {
                  if (info.visibleFraction > 0.3 &&
                      !initialized.contains(index)) {
                    controllers[index] =
                        YoutubePlayerController.fromVideoId(
                          videoId: videos[index],
                        );
                    initialized.add(index);
                    setState(() {});
                  }
                },
                child: SizedBox(
                  width: 450,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: initialized.contains(index)
                        ? YoutubePlayer(controller: controllers[index]!)
                        : Container(
                      color: Colors.black,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFD4AF37),
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: (index * 200).ms)
                  .slideY(begin: 0.3);
            }),
          ),
        ),
      ],
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      color: const Color(0xFF0B1220),
      child: Column(
        children: [
          const Text(
            "CONTACT US",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Color(0xFFD4AF37),
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 40,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: const [
              _ContactCard(
                icon: FontAwesomeIcons.phone,
                title: "Phone 1",
                value: "+234 800 000 0000",
              ),
              _ContactCard(
                icon: FontAwesomeIcons.phone,
                title: "Phone 2",
                value: "+234 801 000 0000",
              ),
              _ContactCard(
                icon: FontAwesomeIcons.envelope,
                title: "Email",
                value: "info@destinychurch.org",
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.3);
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 320,
        padding: const EdgeInsets.all(30),
        transform: hovering
            ? (Matrix4.identity()..translate(0, -6))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: hovering ? const Color(0xFF111C2E) : const Color(0xFF020817),
          border: Border.all(
            color: hovering ? const Color(0xFFD4AF37) : Colors.white24,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 25,
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            FaIcon(widget.icon, color: const Color(0xFFD4AF37), size: 28),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.value,
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
/* ---------------- BRANCH HOVER ---------------- */

class _BranchesSection extends StatelessWidget {
  const _BranchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      child: Column(
        children: [
          const Text(
            "OUR PARISHES",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 60),

          /// DESKTOP GRID (2 x 2)
          if (!isMobile)
            SizedBox(
              width: 1100,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 40,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.6,
                children: const [
                  _BranchCard(
                    name: "Upper Room Parish",
                    address: "80 School Road by Asa Road, Aba",
                    sunday: "Sunday: 8:00am",
                    midweek: "Wednesday: 5:00pm",
                    prayer: "Friday: 5:00pm",
                  ),
                  _BranchCard(
                    name: "Glory Land Parish",
                    address: "109 Iheorji Avenue off Ohanku, Aba",
                    sunday: "Sunday: 7:30am",
                    midweek: "Thursday: 5:00pm",
                    prayer: "Monday: 6:00am",
                  ),
                  _BranchCard(
                    name: "Grace Arena",
                    address: "109 EbuleIheorji Avenue off Ohanku, Aba",
                    sunday: "Sunday: 9:00am",
                    midweek: "Tuesday: 6:00pm",
                    prayer: "Thursday: 5:30pm",
                  ),
                  _BranchCard(
                    name: "Potters House",
                    address: "33 Umuocha Street",
                    sunday: "Sunday: 8:30am",
                    midweek: "Wednesday: 6:00pm",
                    prayer: "Saturday: 7:00am",
                  ),
                ],
              ),
            ),

          /// MOBILE LAYOUT (stacked & bigger)
          if (isMobile)
            Column(
              children: const [
                _BranchCard(
                  name: "Upper Room Parish",
                  address: "80 School Road by Asa Road, Aba",
                  sunday: "Sunday: 8:00am",
                  midweek: "Wednesday: 5:00pm",
                  prayer: "Friday: 5:00pm",
                ),
                _BranchCard(
                  name: "Glory Land Parish",
                  address: "109 Iheorji Avenue off Ohanku, Aba",
                  sunday: "Sunday: 7:30am",
                  midweek: "Thursday: 5:00pm",
                  prayer: "Monday: 6:00am",
                ),
                _BranchCard(
                  name: "Grace Arena",
                  address: "109 EbuleIheorji Avenue off Ohanku, Aba",
                  sunday: "Sunday: 9:00am",
                  midweek: "Tuesday: 6:00pm",
                  prayer: "Thursday: 5:30pm",
                ),
                _BranchCard(
                  name: "Potters House",
                  address: "33 Umuocha Street",
                  sunday: "Sunday: 8:30am",
                  midweek: "Wednesday: 6:00pm",
                  prayer: "Saturday: 7:00am",
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _BranchCard extends StatefulWidget {
  final String name;
  final String address;
  final String sunday;
  final String midweek;
  final String prayer;

  const _BranchCard({
    required this.name,
    required this.address,
    required this.sunday,
    required this.midweek,
    required this.prayer,
  });

  @override
  State<_BranchCard> createState() => _BranchCardState();
}

class _BranchCardState extends State<_BranchCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isMobile ? double.infinity : null,
        padding: const EdgeInsets.all(40),
        transform: hovering
            ? (Matrix4.identity()..translate(0, -8))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: hovering ? const Color(0xFF111C2E) : const Color(0xFF0B1220),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: hovering
                ? const Color(0xFFD4AF37)
                : const Color(0xFFD4AF37).withOpacity(0.25),
            width: hovering ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: hovering ? 30 : 20,
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PARISH NAME (BIGGER & STRONGER)
            Text(
              widget.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: Color(0xFFD4AF37),
              ),
            ),

            const SizedBox(height: 12),

            /// ADDRESS (clearer hierarchy)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, size: 18, color: Colors.white54),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.address,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Divider(color: Colors.white12),

            const SizedBox(height: 20),

            /// SERVICE TIMES (VISUALLY STRONG)
            _serviceRow(Icons.wb_sunny_outlined, widget.sunday),
            const SizedBox(height: 12),
            _serviceRow(Icons.menu_book_outlined, widget.midweek),
            const SizedBox(height: 12),
            _serviceRow(FontAwesomeIcons.personPraying, widget.prayer),
          ],
        ),
      ),
    );
  }

  Widget _serviceRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFFD4AF37)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
