import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/cultures.dart';
import '../data/training.dart';
import '../data/localization.dart';
import '../data/app_state.dart';
import '../main.dart';
import 'training_screen.dart';
import 'audio_player_card.dart';
import 'theme/kids_theme.dart';

class DetailScreen extends StatefulWidget {
  final CultureItem culture;
  const DetailScreen({super.key, required this.culture});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    AppStateService.instance.markExplored(widget.culture.name);
  }


  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final methods = trainingData[widget.culture.name] ?? [];
    final lang = XRTamilKidsApp.of(context).language;
    final service = AppStateService.instance;

    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final isFav = service.isFavorite(widget.culture.name);

        return Scaffold(
          backgroundColor: isDark ? KidsColors.backgroundDark : scheme.surfaceContainerHighest,
          body: CustomScrollView(
            slivers: [
              // ── Hero App Bar ─────────────────────────────────────────────
              SliverAppBar.large(
                backgroundColor: isDark ? KidsColors.surfaceDark : KidsColors.saffron,
                foregroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                expandedHeight: 260,
                pinned: true,
                actions: [
                  // Favorite toggle
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => service.toggleFavorite(widget.culture.name),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(50),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isFav ? KidsColors.bubblegum : Colors.white.withAlpha(60),
                          ),
                        ),
                        child: Icon(
                          isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: isFav ? KidsColors.bubblegum : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    widget.culture.localName(lang),
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),
                  ),
                  background: isDark
                      ? Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [KidsColors.saffron.withAlpha(80), KidsColors.backgroundDark],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        )
                      : Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              widget.culture.imagePath,
                              fit: BoxFit.cover,
                              color: Colors.black.withAlpha(110),
                              colorBlendMode: BlendMode.darken,
                            ),
                            // Right-edge watermark cover
                            Positioned(
                              top: 0, bottom: 0, right: 0,
                              width: 40,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.transparent, Colors.black54],
                                  ),
                                ),
                              ),
                            ),
                            // Type badge
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 56),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(100),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white.withAlpha(80)),
                                  ),
                                  child: Text(
                                    widget.culture.localType(lang),
                                    style: GoogleFonts.nunito(
                                        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ── Category badge ─────────────────────────────────────
                      if (isDark) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: KidsColors.saffron.withAlpha(25),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: KidsColors.saffron.withAlpha(80)),
                          ),
                          child: Text(
                            widget.culture.localType(lang),
                            style: GoogleFonts.nunito(
                              color: KidsColors.saffron, fontWeight: FontWeight.w700, fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // ── About card ─────────────────────────────────────────
                      Container(
                        decoration: isDark
                            ? KidsDecor.card(radius: 18)
                            : BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 12, offset: const Offset(0, 4))],
                              ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: KidsColors.saffron.withAlpha(isDark ? 30 : 20),
                                      shape: BoxShape.circle,
                                      border: isDark ? Border.all(color: KidsColors.saffron.withAlpha(60)) : null,
                                    ),
                                    child: Icon(Icons.auto_stories_rounded, color: KidsColors.saffron, size: 18),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    translate('About This Art Form', lang),
                                    style: GoogleFonts.poppins(
                                      fontSize: 15, fontWeight: FontWeight.w700,
                                      color: isDark ? KidsColors.textPrimary : KidsColors.dark,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                widget.culture.localDesc(lang),
                                  style: GoogleFonts.nunito(
                                    fontSize: 14, fontWeight: FontWeight.w600,
                                    color: isDark ? KidsColors.textSecondary : Colors.grey.shade700,
                                    height: 1.7,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // ── Audio Narration ───────────────────────────────────
                      AudioNarrationCard(
                        cultureName: widget.culture.name,
                        currentLanguage: lang,
                      ),
                      const SizedBox(height: 22),

                      // ── Learning Options ───────────────────────────────────
                      Text(
                        translate('Learning Options', lang),
                        style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w700,
                          color: isDark ? KidsColors.textPrimary : KidsColors.dark,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Step-by-Step Training
                      _LearningOptionCard(
                        icon: Icons.menu_book_rounded,
                        title: translate('Step-by-Step Training', lang),
                        subtitle: '${methods.length} ${translate('methods to master', lang)}',
                        color: KidsColors.saffron,
                        filled: true,
                        isDark: isDark,
                        onTap: () {
                          if (methods.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Training data not available yet.')),
                            );
                            return;
                          }
                          AppStateService.instance.markTrainingComplete();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TrainingScreen(
                                cultureName: widget.culture.name,
                                methods: methods,
                                color: KidsColors.saffron,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),

                      // AR View
                      _LearningOptionCard(
                        icon: Icons.view_in_ar_rounded,
                        title: translate('Learning in AR View', lang),
                        subtitle: translate('Augmented Reality Mode', lang),
                        color: const Color(0xFF0288D1),
                        filled: false,
                        isDark: isDark,
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('AR Mode — point camera at a flat surface')),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // VR View
                      _LearningOptionCard(
                        icon: Icons.vrpano_rounded,
                        title: translate('Learning in VR Immersive', lang),
                        subtitle: translate('XR 3D Experience', lang),
                        color: KidsColors.grape,
                        filled: false,
                        isDark: isDark,
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('VR Immersive — Requires Unity Engine')),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LEARNING OPTION CARD
// ─────────────────────────────────────────────────────────────────────────────
class _LearningOptionCard extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final Color color;
  final bool filled;
  final bool isDark;
  final VoidCallback onTap;

  const _LearningOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.filled,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = filled
        ? color
        : (isDark ? KidsColors.surfaceDark : Colors.white);
    final border = filled
        ? BorderSide.none
        : BorderSide(
            color: isDark ? color.withAlpha(80) : color.withAlpha(80),
            width: 1.5,
          );

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border.color, width: border.width),
        boxShadow: filled
            ? [BoxShadow(color: color.withAlpha(80), blurRadius: 16, offset: const Offset(0, 6))]
            : isDark
                ? [BoxShadow(color: Colors.black.withAlpha(40), blurRadius: 10, offset: const Offset(0, 4))]
                : [BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: filled ? Colors.white.withAlpha(35) : color.withAlpha(isDark ? 30 : 20),
                  shape: BoxShape.circle,
                  border: filled ? null : Border.all(color: color.withAlpha(60)),
                ),
                child: Icon(icon, color: filled ? Colors.white : color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w800, fontSize: 15,
                          color: filled ? Colors.white : (isDark ? KidsColors.textPrimary : KidsColors.dark),
                        )),
                    Text(subtitle,
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          color: filled ? Colors.white70 : (isDark ? KidsColors.textSecondary : Colors.grey.shade500),
                        )),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: filled ? Colors.white54 : (isDark ? KidsColors.textSecondary : Colors.grey.shade400)),
            ],
          ),
        ),
      ),
    );
  }
}
