import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'login_screen.dart';
import 'theme/kids_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _scaleAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.elasticOut, // Bouncy elastic effect
    ));

    _fadeController.forward();

    // Navigate to Home AppShell after 4 seconds
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fallback background
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image (Clean landscape)
          Image.asset(
            'assets/splash_bg.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: KidsColors.backgroundDark),
          ),

          // Dark gradient overlay to make text pop
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withAlpha(20), Colors.black.withAlpha(160)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Content Layer
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),

                  // Animated App Icon
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(150),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                          BoxShadow(
                            color: const Color(0xFFFFDAB9).withAlpha(50),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage('assets/images/app/app_icon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // The Tamil Slogan
                  Text(
                    'யாதும் ஊரே யாவரும் கேளிர்',
                    style: KidsText.display(
                      30,
                      color: const Color(0xFFFFDAB9), // Soft golden/peach color matching the sunset
                    ).copyWith(
                      shadows: [
                        Shadow(color: Colors.black.withAlpha(200), blurRadius: 10, offset: const Offset(0, 4)),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(flex: 2),

                  // Loading Text
                  Text(
                    'LOADING...',
                    style: KidsText.label(14, color: Colors.white).copyWith(
                      letterSpacing: 4,
                      shadows: [Shadow(color: Colors.black, blurRadius: 8)],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Loading Bar (Real Material Widget)
                  SizedBox(
                    width: 250,
                    child: LinearProgressIndicator(
                      color: const Color(0xFFFDE4C8), // Champagne gold
                      backgroundColor: Colors.black.withAlpha(150),
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
