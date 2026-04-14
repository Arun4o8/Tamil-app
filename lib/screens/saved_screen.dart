import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/kids_theme.dart';
import '../data/localization.dart';
import '../data/cultures.dart';
import '../data/app_state.dart';
import '../main.dart';
import 'detail_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = XRTamilKidsApp.of(context).language;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(translate('Saved Items', lang)),
      ),
      body: ListenableBuilder(
        listenable: AppStateService.instance,
        builder: (context, _) {
          final service = AppStateService.instance;
          final savedItems = allCultures.where((c) => service.isFavorite(c.name)).toList();

          if (savedItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border_rounded, size: 80, color: KidsColors.saffron.withAlpha(128)),
                  const SizedBox(height: 20),
                  Text(
                    translate('No saved items yet', lang),
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: isDark ? KidsColors.textSecondary : KidsColors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.8,
            ),
            itemCount: savedItems.length,
            itemBuilder: (ctx, i) => _SavedCultureCard(
              culture: savedItems[i],
              lang: lang,
              isDark: isDark,
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CULTURE CARD
// ─────────────────────────────────────────────────────────────────────────────
class _SavedCultureCard extends StatelessWidget {
  final CultureItem culture;
  final String lang;
  final bool isDark;
  const _SavedCultureCard({required this.culture, required this.lang, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final service = AppStateService.instance;
    final isFav = service.isFavorite(culture.name);
    final isExplored = service.exploredCultures.contains(culture.name);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailScreen(culture: culture)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? KidsColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: isDark ? Border.all(color: KidsColors.borderFaint) : null,
          boxShadow: isDark
              ? [BoxShadow(color: Colors.black.withAlpha(60), blurRadius: 12, offset: const Offset(0, 4))]
              : [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // Image + overlays
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(culture.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: culture.color.withAlpha(30))),
                  if (isDark)
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter, end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withAlpha(80)],
                        ),
                      ),
                    ),
                  // Watermark cover: right-edge fade
                  Positioned(
                    top: 0, bottom: 0, right: 0,
                    width: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.transparent,
                            isDark
                                ? KidsColors.surfaceDark
                                : Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Explored check
                  if (isExplored)
                    Positioned(
                      top: 8, right: 8,
                      child: Container(
                        width: 24, height: 24,
                        decoration: const BoxDecoration(color: KidsColors.teal, shape: BoxShape.circle),
                        child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
                      ),
                    ),
                ],
              ),
            ),
            // Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          culture.localName(lang),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w800, fontSize: 13,
                            color: isDark ? KidsColors.textPrimary : KidsColors.dark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          culture.localType(lang),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                            fontSize: 11, fontWeight: FontWeight.w600,
                            color: KidsColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    // Favorite + view link row
                    Row(
                      children: [
                        Text(translate('View Details', lang),
                            style: GoogleFonts.nunito(
                              fontSize: 11, fontWeight: FontWeight.w700, color: KidsColors.saffron)),
                        const Icon(Icons.chevron_right_rounded, size: 14, color: KidsColors.saffron),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => service.toggleFavorite(culture.name),
                          child: Icon(
                            isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            size: 18,
                            color: isFav ? KidsColors.bubblegum : KidsColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
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
