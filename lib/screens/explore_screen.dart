import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/cultures.dart';
import '../data/localization.dart';
import '../data/app_state.dart';
import '../main.dart';
import 'detail_screen.dart';
import 'theme/kids_theme.dart';

class ExploreScreen extends StatefulWidget {
  final CultureItem? initialCulture;
  const ExploreScreen({super.key, this.initialCulture});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedCategory = 'All';
  List<CultureItem> _filtered = allCultures;
  String _lang = 'English';

  final List<({String label, String value, IconData icon})> _categories = [
    (label: 'All', value: 'All', icon: Icons.all_inclusive_rounded),
    (label: 'Classical', value: 'Classical', icon: Icons.auto_awesome_rounded),
    (label: 'Folk', value: 'Folk', icon: Icons.groups_rounded),
    (label: 'Martial Arts', value: 'Martial Arts', icon: Icons.security_rounded),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialCulture != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailScreen(culture: widget.initialCulture!)),
        );
      });
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _filter() {
    final query = _searchCtrl.text.toLowerCase();
    setState(() {
      _filtered = allCultures.where((c) {
        final matchSearch = query.isEmpty ||
            c.name.toLowerCase().contains(query) ||
            c.type.toLowerCase().contains(query);
        final matchCat = _selectedCategory == 'All' || c.category == _selectedCategory;
        return matchSearch && matchCat;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = XRTamilKidsApp.of(context).language;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (_lang != lang) _lang = lang;

    return Scaffold(
      backgroundColor: isDark ? KidsColors.backgroundDark : KidsColors.backgroundLight,
      appBar: AppBar(
        title: Text(translate('Explore', lang)),
        backgroundColor: isDark ? KidsColors.surfaceDark : Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // ── Search + Filters bar ─────────────────────────────────────────
          Container(
            color: isDark ? KidsColors.surfaceDark : Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
            child: Column(
              children: [
                // ── Search bar (clean, single border) ──────────────────────
                TextField(
                  controller: _searchCtrl,
                  onChanged: (_) => _filter(),
                  style: GoogleFonts.nunito(
                    fontSize: 14, fontWeight: FontWeight.w600,
                    color: isDark ? KidsColors.textPrimary : KidsColors.dark,
                  ),
                  decoration: InputDecoration(
                    hintText: translate('Search dances...', lang),
                    hintStyle: GoogleFonts.nunito(
                        color: KidsColors.textSecondary, fontSize: 14),
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: KidsColors.textSecondary, size: 20),
                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () { _searchCtrl.clear(); _filter(); },
                            child: const Icon(Icons.close_rounded,
                                color: KidsColors.textSecondary, size: 18),
                          )
                        : null,
                    filled: true,
                    fillColor: isDark
                        ? const Color(0xFF2E3048)
                        : const Color(0xFFF4F1DE),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isDark
                            ? KidsColors.borderFaint
                            : const Color(0xFFD5D0BE),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: KidsColors.teal, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // ── Filter chips ─────────────────────────────────────────────
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((cat) {
                      final isSelected = _selectedCategory == cat.value;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _selectedCategory = cat.value);
                            _filter();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? KidsColors.saffron
                                  : (isDark
                                      ? const Color(0xFF2E3048)
                                      : const Color(0xFFF4F1DE)),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? KidsColors.saffron
                                    : (isDark
                                        ? KidsColors.borderFaint
                                        : const Color(0xFFD5D0BE)),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(cat.icon,
                                    size: 14,
                                    color: isSelected
                                        ? Colors.white
                                        : KidsColors.textSecondary),
                                const SizedBox(width: 6),
                                Text(
                                  translate(cat.label, lang),
                                  style: GoogleFonts.nunito(
                                    fontSize: 13, fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? Colors.white
                                        : KidsColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // ── Grid of culture cards ────────────────────────────────────────
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off_rounded,
                            size: 52, color: KidsColors.textSecondary.withAlpha(100)),
                        const SizedBox(height: 12),
                        Text(translate('No dances found', lang),
                            style: GoogleFonts.nunito(
                              fontSize: 16, fontWeight: FontWeight.w700,
                              color: KidsColors.textSecondary,
                            )),
                      ],
                    ),
                  )
                : ListenableBuilder(
                    listenable: AppStateService.instance,
                    builder: (context, _) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: _filtered.length,
                        itemBuilder: (ctx, i) => _CultureCard(
                          culture: _filtered[i],
                          lang: lang,
                          isDark: isDark,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CULTURE CARD
// ─────────────────────────────────────────────────────────────────────────────
class _CultureCard extends StatelessWidget {
  final CultureItem culture;
  final String lang;
  final bool isDark;
  const _CultureCard({required this.culture, required this.lang, required this.isDark});

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
                  // ── Watermark cover: right-edge fade ─────────────────────
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
