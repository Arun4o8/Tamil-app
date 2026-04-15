import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/celebrations.dart';
import '../data/cultures.dart';
import 'mattu_pongal_ar_screen.dart';
import '../screens/theme/kids_theme.dart';
import '../main.dart';

class CelebrationsScreen extends StatelessWidget {
  const CelebrationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final su = ScreenUtils(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? KidsColors.backgroundDark : KidsColors.backgroundLight,
      appBar: AppBar(
        title: Text('Cultural Celebrations', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: su.horizontalPad, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Intro
            Text('Festivals of Tamil Nadu', 
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: KidsColors.saffron)),
            const SizedBox(height: 4),
            Text('Vibrant traditions passed down through generations.', 
              style: GoogleFonts.nunito(fontSize: 14, color: KidsColors.textSecondary, fontWeight: FontWeight.w600)),
            
            const SizedBox(height: 24),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: su.gridCrossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.82,
              ),
              itemCount: allCelebrations.length,
              itemBuilder: (context, index) {
                final fest = allCelebrations[index];
                return _CelebrationCard(fest: fest, isDark: isDark);
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _CelebrationCard extends StatelessWidget {
  final CelebrationItem fest;
  final bool isDark;
  const _CelebrationCard({required this.fest, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => _CelebrationSheet(fest: fest),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? KidsColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDark ? KidsColors.borderFaint : Colors.grey.shade200),
          boxShadow: isDark 
            ? [BoxShadow(color: fest.color.withAlpha(20), blurRadius: 10)]
            : [BoxShadow(color: Colors.black.withAlpha(5), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Center Emoji Background
            Positioned(
              top: 20, left: 0, right: 0,
              child: Center(
                child: Text(fest.emoji, style: const TextStyle(fontSize: 56)),
              ),
            ),
            // Bottom Label Panel
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, fest.color.withAlpha(isDark ? 50 : 30), fest.color.withAlpha(isDark ? 100 : 80)],
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fest.name,
                        style: GoogleFonts.poppins(color: KidsColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 14)),
                    Text(fest.type,
                        style: GoogleFonts.nunito(color: KidsColors.textSecondary, fontSize: 10, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CelebrationSheet extends StatelessWidget {
  final CelebrationItem fest;
  const _CelebrationSheet({required this.fest});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (_, ctrl) => Container(
        decoration: BoxDecoration(
          color: isDark ? KidsColors.surfaceDark : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 40)],
        ),
        child: ListView(
          controller: ctrl,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          children: [
            // Drag handle
            Center(
              child: Container(width: 40, height: 4,
                  decoration: BoxDecoration(color: KidsColors.borderFaint, borderRadius: BorderRadius.circular(2))),
            ),
            const SizedBox(height: 24),
            
            // Header
            Row(
              children: [
                Container(
                  width: 64, height: 64,
                  decoration: BoxDecoration(
                    color: fest.color.withAlpha(30),
                    shape: BoxShape.circle,
                    border: Border.all(color: fest.color.withAlpha(80)),
                  ),
                  child: Center(child: Text(fest.emoji, style: const TextStyle(fontSize: 32))),
                ),
                const SizedBox(width: 16),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fest.name,
                        style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: KidsColors.textPrimary)),
                    Text(fest.type, 
                        style: GoogleFonts.nunito(fontSize: 13, color: fest.color, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                  ],
                )),
              ],
            ),
            
            const SizedBox(height: 24),
            const Divider(color: KidsColors.borderFaint),
            const SizedBox(height: 24),
            
            Text('Significance & Rituals', 
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: KidsColors.saffron)),
            const SizedBox(height: 12),
            Text(fest.description,
                style: GoogleFonts.nunito(fontSize: 15, height: 1.7, color: KidsColors.textSecondary, fontWeight: FontWeight.w600)),
            
            const SizedBox(height: 32),
            
            // ── AR Action Card (Premium) ──────────────────────────────────
            if (fest.name.contains('Pongal'))
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MattuPongalARScreen())),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [fest.color, fest.color.withAlpha(180)],
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: fest.color.withAlpha(80), blurRadius: 20, offset: const Offset(0, 8))],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white.withAlpha(40), shape: BoxShape.circle),
                        child: const Icon(Icons.view_in_ar_rounded, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('AR Celebration',
                              style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17)),
                          Text('Experience 3D objects in your home!',
                              style: GoogleFonts.nunito(color: Colors.white.withAlpha(200), fontSize: 12, fontWeight: FontWeight.w600)),
                        ],
                      )),
                      const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
