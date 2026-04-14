import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// RESPONSIVE SCREEN UTILS
// ─────────────────────────────────────────────────────────────────────────────
class ScreenUtils {
  final double width;
  final double height;

  ScreenUtils(BuildContext context)
      : width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;

  bool get isSmall => width < 360;
  bool get isMedium => width >= 360 && width < 420;
  bool get isLarge => width >= 420 && width < 600;
  bool get isTablet => width >= 600;

  /// Fluid value: [small, medium, large, tablet] — pick based on device
  T fluid<T>(T small, T medium, T large, T tablet) {
    if (isSmall) return small;
    if (isMedium) return medium;
    if (isTablet) return tablet;
    return large;
  }

  double get horizontalPad => fluid(12.0, 16.0, 20.0, 28.0);
  double get cardRadius => fluid(16.0, 18.0, 20.0, 24.0);
  double get bodyFontSize => fluid(14.0, 15.0, 16.0, 17.0);
  double get titleFontSize => fluid(18.0, 20.0, 22.0, 26.0);
  double get headFontSize => fluid(22.0, 26.0, 28.0, 34.0);
  double get iconSize => fluid(24.0, 28.0, 32.0, 36.0);
  int get gridCrossAxisCount => isTablet ? 3 : 2;
  double get gridChildAspectRatio => isTablet ? 1.2 : (isSmall ? 1.1 : 1.25);
  double get heroBannerHeight => fluid(160.0, 180.0, 200.0, 240.0);
  double get buttonHeight => fluid(52.0, 56.0, 60.0, 64.0);
}

// ─────────────────────────────────────────────────────────────────────────────
// VIBRANT PLAYFUL PALETTE — Decent & Attractive for Children
// ─────────────────────────────────────────────────────────────────────────────
class KidsColors {
  // ── Primary — Playful Coral/Red ────────────────────────────────────────
  static const saffron      = Color(0xFFFF6B6B);   // Bright coral 
  static const saffronLight = Color(0xFFFF8E8B);   
  static const saffronDark  = Color(0xFFE55050);   

  // ── Sunny Yellow — premium accent ─────────────────────────────────
  static const gold      = Color(0xFFFFD166);   // Bright yellow
  static const goldLight = Color(0xFFFFE099);   

  // ── Mint Green — secondary accent ───────────────────────────────
  static const teal      = Color(0xFF06D6A0);   // Mint green
  static const tealLight = Color(0xFF5EE8C4);   
  static const tealDark  = Color(0xFF04A77D);   

  // ── Utility / Legacy (mapped to playful palette) ──────────────────
  static const sunshine      = Color(0xFFFFD166);   // Yellow
  static const sunshineLight = Color(0xFFFFE099);
  static const bubblegum     = Color(0xFFFF9F1C);   // Bright Orange
  static const bubblegumLight= Color(0xFFFFBF69);
  static const sky           = Color(0xFF118AB2);   // Bright Blue
  static const skyLight      = Color(0xFF4AC2E6);
  static const grape         = Color(0xFF8338EC);   // Vibrant Purple
  static const grapeLight    = Color(0xFFA66BFA);
  static const forest        = Color(0xFF06D6A0);   // Mint Green
  static const forestLight   = Color(0xFF5EE8C4);

  // ── Dark Backgrounds (Deep Royal Blue) ───────────────────────────────
  static const backgroundDark = Color(0xFF0D1B2A);   // Deep space blue
  static const surfaceDark    = Color(0xFF1B263B);   // Dark card surface
  static const surfaceMid     = Color(0xFF415A77);   // Mid blue
  static const surfaceLight   = Color(0xFF778DA9);   // Lighter blue

  // ── Light Mode ──────────────────────────────────────────────────────────
  static const backgroundLight = Color(0xFFF7FBFC);   // Very soft icy white
  static const white = Colors.white;

  // ── Text ────────────────────────────────────────────────────────────────
  static const dark      = Color(0xFF0D1B2A);           // Deep text
  static const darkMid   = Color(0xFF1B263B);
  static const grey      = Color(0xFF8D99AE);
  static const lightGrey = Color(0xFFEDF2F4);           
  static const textPrimary   = Color(0xFFF7FBFC);       
  static const textSecondary = Color(0xFFE0E1DD);       

  // ── Glows / Borders ─────────────────────────────────────────────────────
  static const glowAmber  = Color(0x60FFD166);   // Yellow glow
  static const glowTeal   = Color(0x5006D6A0);   // Mint glow
  static const borderFaint  = Color(0x38F7FBFC); 
  static const borderAccent = Color(0x80FFD166); 

  // ── Gradients ───────────────────────────────────────────────────────────
  /// Primary button / badge — Coral/Orange
  static LinearGradient get saffronGrad => const LinearGradient(
        colors: [Color(0xFFFF6B6B), Color(0xFFFF9F1C)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      );

  /// Mint/Sky green gradient
  static LinearGradient get tealGrad => const LinearGradient(
        colors: [Color(0xFF06D6A0), Color(0xFF118AB2)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      );

  /// Yellow → Coral gradient
  static LinearGradient get goldGrad => const LinearGradient(
        colors: [Color(0xFFFFD166), Color(0xFFFF6B6B)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      );

  /// Hero — Vibrant Purple/Blue gradient
  static LinearGradient get heroGrad => const LinearGradient(
        colors: [Color(0xFF8338EC), Color(0xFF3A0CA3)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      );

  /// Dance — Coral → Blue
  static LinearGradient get danceGrad => const LinearGradient(
        colors: [Color(0xFFFF6B6B), Color(0xFF8338EC)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      );

  /// Celebrations — Mint → Yellow
  static LinearGradient get celebGrad => const LinearGradient(
        colors: [Color(0xFF06D6A0), Color(0xFFFFD166)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      );

  /// Quiz — Purple → Orange
  static LinearGradient get quizGrad => const LinearGradient(
        colors: [Color(0xFF8338EC), Color(0xFFFF9F1C)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      );

  /// Codex card gradient
  static LinearGradient get codexGrad => const LinearGradient(
        colors: [Color(0xFF118AB2), Color(0xFF06D6A0)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// TYPOGRAPHY  (Clean Poppins — readable on both light and dark)
// ─────────────────────────────────────────────────────────────────────────────
class KidsText {
  /// Headings / display — Poppins Bold. Default: dark (visible on light bg).
  static TextStyle display(double size, {Color color = KidsColors.dark}) =>
      GoogleFonts.poppins(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.3,
      );

  /// Section titles — Poppins ExtraBold.
  static TextStyle title(double size, {Color color = KidsColors.dark}) =>
      GoogleFonts.poppins(
        fontSize: size, fontWeight: FontWeight.w800,
        color: color,
      );

  /// Body / description — Nunito SemiBold. Default: grey (readable on both).
  static TextStyle body(double size, {Color color = KidsColors.grey}) =>
      GoogleFonts.nunito(
        fontSize: size, fontWeight: FontWeight.w600,
        color: color,
      );

  /// Labels / chips — Nunito Bold. Default: dark (readable on both).
  static TextStyle label(double size, {Color color = KidsColors.darkMid}) =>
      GoogleFonts.nunito(
        fontSize: size, fontWeight: FontWeight.w700,
        color: color,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// HERITAGE DECORATIONS  (Glassmorphism, dark cards)
// ─────────────────────────────────────────────────────────────────────────────
class KidsDecor {
  /// Glassmorphism dark card
  static BoxDecoration card({
    double radius = 20,
    Color color = KidsColors.surfaceDark,
    Color borderColor = KidsColors.borderFaint,
  }) =>
      BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(60),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      );

  /// Glowing gradient card
  static BoxDecoration gradient(LinearGradient grad, {double radius = 20}) =>
      BoxDecoration(
        gradient: grad,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: grad.colors.first.withAlpha(80),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      );

  /// Amber glow border card
  static BoxDecoration glowCard({double radius = 16, Color glow = KidsColors.glowAmber}) =>
      BoxDecoration(
        color: KidsColors.surfaceMid,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: KidsColors.borderAccent, width: 1),
        boxShadow: [
          BoxShadow(color: glow, blurRadius: 16, spreadRadius: 1),
          BoxShadow(color: Colors.black.withAlpha(80), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      );

  static BoxDecoration circle(Color color, {double opacity = 0.15}) =>
      BoxDecoration(
        color: color.withAlpha((255 * opacity).toInt()),
        shape: BoxShape.circle,
      );
}
