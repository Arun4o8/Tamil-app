import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import 'about_screen.dart';
import 'edit_profile_screen.dart';
import 'language_screen.dart';
import 'settings_screen.dart';
import 'support_screen.dart';
import '../data/localization.dart';
import '../data/app_state.dart';
import '../data/cultures.dart';
import 'detail_screen.dart';
import 'theme/kids_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = XRTamilKidsApp.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final language = appState.language;

    return ListenableBuilder(
      listenable: AppStateService.instance,
      builder: (context, _) {
        final service = AppStateService.instance;
        return Scaffold(
          backgroundColor: isDark ? KidsColors.backgroundDark : KidsColors.backgroundLight,
          body: CustomScrollView(
            slivers: [
              // ── Profile header ─────────────────────────────────────────────
              SliverAppBar(
                expandedHeight: 210,
                pinned: false,
                backgroundColor: isDark ? KidsColors.surfaceDark : Colors.transparent,
                foregroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: isDark
                          ? const LinearGradient(
                              colors: [Color(0xFF1A1230), Color(0xFF0A0A1A)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : LinearGradient(
                              colors: [KidsColors.saffron, const Color(0xFFFF8F00)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      border: isDark
                          ? const Border(bottom: BorderSide(color: KidsColors.borderFaint))
                          : null,
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Avatar with Progress Ring
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 92, height: 92,
                                child: CircularProgressIndicator(
                                  value: (service.totalExplored / 14).clamp(0.0, 1.0),
                                  strokeWidth: 4,
                                  backgroundColor: Colors.white12,
                                  color: KidsColors.saffron,
                                ),
                              ),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    width: 78, height: 78,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isDark ? KidsColors.surfaceMid : Colors.white,
                                        width: 2,
                                      ),
                                      color: isDark ? const Color(0xFF2A2240) : Colors.white24,
                                    ),
                                    child: Icon(Icons.person, size: 40,
                                        color: isDark ? KidsColors.saffron.withAlpha(200) : Colors.white),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: isDark ? KidsColors.surfaceMid : Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: KidsColors.saffron.withAlpha(80)),
                                    ),
                                    child: const Icon(Icons.camera_alt, size: 10, color: KidsColors.saffron),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Name
                          GestureDetector(
                            onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const EditProfileScreen())),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  service.userName.isNotEmpty
                                      ? service.userName
                                      : 'Heritage Explorer',
                                  style: GoogleFonts.poppins(
                                    color: isDark ? KidsColors.textPrimary : Colors.white,
                                    fontSize: 18, fontWeight: FontWeight.w700,
                                  )),
                                const SizedBox(width: 6),
                                Icon(Icons.edit_rounded,
                                    size: 14,
                                    color: isDark ? KidsColors.saffron.withAlpha(180) : Colors.white70),
                              ],
                            ),
                          ),
                          // Rank Banner
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            decoration: BoxDecoration(
                              color: KidsColors.saffron.withAlpha(isDark ? 30 : 50),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: KidsColors.saffron.withAlpha(80)),
                            ),
                            child: Text(
                              _getRankName(service.totalExplored),
                              style: GoogleFonts.nunito(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ── Stats row ──────────────────────────────────────────
                      Row(
                        children: [
                          _StatCard(
                            label: translate('Explored', language),
                            value: '${service.totalExplored}',
                            icon: Icons.explore_rounded,
                            iconColor: KidsColors.teal,
                            isDark: isDark,
                          ),
                          const SizedBox(width: 10),
                          _StatCard(
                            label: translate('Best Score', language),
                            value: service.bestQuizPct > 0 ? '${service.bestQuizPct}%' : '--',
                            icon: Icons.psychology_rounded,
                            iconColor: KidsColors.grape,
                            isDark: isDark,
                          ),
                          const SizedBox(width: 10),
                          _StatCard(
                            label: translate('Favorites', language),
                            value: '${service.favorites.length}',
                            icon: Icons.favorite_rounded,
                            iconColor: KidsColors.bubblegum,
                            isDark: isDark,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // ── Achievements ───────────────────────────────────────
                      _SectionTitle(title: 'Achievements', isDark: isDark),
                      const SizedBox(height: 12),
                      _AchievementsGrid(service: service, isDark: isDark),
                      const SizedBox(height: 20),

                      // ── Favorites ──────────────────────────────────────────
                      if (service.favorites.isNotEmpty) ...[
                        _SectionTitle(title: translate('Saved Cultures', language), isDark: isDark),
                        const SizedBox(height: 12),
                        _FavoritesRow(service: service, language: language, isDark: isDark),
                        const SizedBox(height: 20),
                      ],

                      // ── General Settings ───────────────────────────────────
                      _SettingsCard(
                        title: translate('General', language),
                        isDark: isDark,
                        items: [
                          _MenuItem(
                            icon: Icons.language,
                            iconColor: KidsColors.sky,
                            label: translate('Language', language),
                            trailing: language,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LanguageScreen(
                                  currentLanguage: language,
                                  onLanguageChanged: appState.setLanguage,
                                ),
                              ),
                            ),
                          ),
                          _MenuItem(
                            icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                            iconColor: Colors.indigo,
                            label: isDark ? 'Light Mode' : 'Dark Mode',
                            isSwitch: true,
                            switchValue: isDark,
                            onSwitchChanged: (v) => appState.toggleDarkMode(v),
                            onTap: () {},
                          ),
                          _MenuItem(
                            icon: Icons.settings_rounded,
                            iconColor: KidsColors.textSecondary,
                            label: translate('Settings', language),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SettingsScreen(
                                  darkMode: isDark,
                                  onDarkModeChanged: appState.toggleDarkMode,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // ── More ───────────────────────────────────────────────
                      _SettingsCard(
                        title: translate('More', language),
                        isDark: isDark,
                        items: [
                          _MenuItem(
                            icon: Icons.info_outline_rounded,
                            iconColor: KidsColors.teal,
                            label: translate('About App', language),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen())),
                          ),
                          _MenuItem(
                            icon: Icons.headset_mic_rounded,
                            iconColor: KidsColors.forest,
                            label: translate('Support', language),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportScreen())),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // ── Logout ─────────────────────────────────────────────
                      _SettingsCard(
                        title: '',
                        isDark: isDark,
                        items: [
                          _MenuItem(
                            icon: Icons.logout_rounded,
                            iconColor: Colors.red,
                            label: translate('Log Out', language),
                            labelColor: Colors.red,
                            onTap: () => showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                backgroundColor: isDark ? KidsColors.surfaceMid : Colors.white,
                                title: Text(translate('Log Out?', language),
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700,
                                      color: isDark ? KidsColors.textPrimary : KidsColors.dark)),
                                content: Text(
                                  translate('Are you sure you want to log out of your heritage journey?', language),
                                  style: GoogleFonts.nunito(color: isDark ? KidsColors.textSecondary : KidsColors.grey),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(translate('Cancel', language),
                                        style: GoogleFonts.nunito(color: KidsColors.textSecondary, fontWeight: FontWeight.w700)),
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Logged out successfully')),
                                      );
                                    },
                                    style: FilledButton.styleFrom(backgroundColor: Colors.red),
                                    child: Text(translate('Log Out', language),
                                        style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
  String _getRankName(int explored) {
    if (explored >= 12) return 'CODEX GUARDIAN';
    if (explored >= 8) return 'HERITAGE SCHOLAR';
    if (explored >= 4) return 'CULTURAL EXPLORER';
    return 'NOVICE LEARNER';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ACHIEVEMENTS GRID
// ─────────────────────────────────────────────────────────────────────────────
class _AchievementsGrid extends StatelessWidget {
  final AppStateService service;
  final bool isDark;
  const _AchievementsGrid({required this.service, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      itemCount: allAchievements.length,
      itemBuilder: (_, i) {
        final a = allAchievements[i];
        final earned = service.earnedAchievements.contains(a.id);
        return GestureDetector(
          onTap: () => _showAchievementDialog(context, a, earned, isDark),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 58, height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: earned
                      ? a.color.withAlpha(isDark ? 30 : 20)
                      : (isDark ? KidsColors.surfaceMid : Colors.grey.shade100),
                  border: Border.all(
                    color: earned ? a.color.withAlpha(isDark ? 120 : 100) : KidsColors.borderFaint,
                    width: earned ? 1.5 : 1,
                  ),
                  boxShadow: earned
                      ? [BoxShadow(color: a.color.withAlpha(50), blurRadius: 10)]
                      : null,
                ),
                child: Icon(
                  a.icon,
                  size: 26,
                  color: earned ? a.color : (isDark ? KidsColors.surfaceLight : Colors.grey.shade300),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                a.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.nunito(
                  fontSize: 9.5, fontWeight: FontWeight.w700,
                  color: earned
                      ? (isDark ? KidsColors.textPrimary : KidsColors.dark)
                      : KidsColors.textSecondary,
                  height: 1.2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAchievementDialog(BuildContext context, Achievement a, bool earned, bool isDark) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: isDark ? KidsColors.surfaceMid : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: earned ? a.color.withAlpha(30) : KidsColors.surfaceLight.withAlpha(100),
                border: Border.all(color: earned ? a.color.withAlpha(100) : KidsColors.borderFaint),
              ),
              child: Icon(a.icon, size: 36, color: earned ? a.color : KidsColors.textSecondary),
            ),
            const SizedBox(height: 16),
            Text(a.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w700,
                  color: isDark ? KidsColors.textPrimary : KidsColors.dark,
                )),
            const SizedBox(height: 8),
            Text(a.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 13, fontWeight: FontWeight.w600,
                  color: KidsColors.textSecondary,
                )),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: earned ? KidsColors.teal.withAlpha(20) : Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: earned ? KidsColors.teal.withAlpha(80) : Colors.grey.withAlpha(50)),
              ),
              child: Text(
                earned ? 'Unlocked' : 'Locked',
                style: GoogleFonts.nunito(
                  fontSize: 12, fontWeight: FontWeight.w800,
                  color: earned ? KidsColors.teal : KidsColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: GoogleFonts.nunito(fontWeight: FontWeight.w700, color: KidsColors.saffron)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FAVORITES ROW
// ─────────────────────────────────────────────────────────────────────────────
class _FavoritesRow extends StatelessWidget {
  final AppStateService service;
  final String language;
  final bool isDark;
  const _FavoritesRow({required this.service, required this.language, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final favCultures = allCultures.where((c) => service.isFavorite(c.name)).toList();
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: favCultures.length,
        itemBuilder: (_, i) {
          final c = favCultures[i];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _CultureDetailFromProfile(culture: c))),
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isDark ? KidsColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: c.color.withAlpha(60)),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(isDark ? 60 : 10), blurRadius: 8)],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(c.imagePath, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: c.color.withAlpha(30))),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter, end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withAlpha(160)],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 6, left: 0, right: 0,
                    child: Text(c.name,
                        textAlign: TextAlign.center,
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                          fontSize: 9, fontWeight: FontWeight.w800, color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Thin routing wrapper (avoids circular import issues)
class _CultureDetailFromProfile extends StatelessWidget {
  final dynamic culture;
  const _CultureDetailFromProfile({required this.culture});
  @override
  Widget build(BuildContext context) {
    return DetailScreen(culture: culture);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION TITLE
// ─────────────────────────────────────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  final bool isDark;
  const _SectionTitle({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 15, fontWeight: FontWeight.w700,
        color: isDark ? KidsColors.textPrimary : KidsColors.dark,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STAT CARD
// ─────────────────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color iconColor;
  final bool isDark;
  const _StatCard({required this.label, required this.value, required this.icon, required this.iconColor, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: isDark ? KidsColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isDark ? Border.all(color: KidsColors.borderFaint) : null,
          boxShadow: isDark
              ? [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 10)]
              : [BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 8)],
        ),
        child: Column(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: iconColor.withAlpha(isDark ? 30 : 20),
                shape: BoxShape.circle,
                border: isDark ? Border.all(color: iconColor.withAlpha(60)) : null,
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(height: 6),
            Text(value,
                style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w700,
                  color: isDark ? KidsColors.textPrimary : KidsColors.dark,
                )),
            Text(label,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 10, fontWeight: FontWeight.w600, color: KidsColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SETTINGS CARD + MENU ITEM
// ─────────────────────────────────────────────────────────────────────────────
class _SettingsCard extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;
  final bool isDark;
  const _SettingsCard({required this.title, required this.items, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              title.toUpperCase(),
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w700, fontSize: 11,
                color: KidsColors.textSecondary, letterSpacing: 0.8,
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: isDark ? KidsColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: isDark ? Border.all(color: KidsColors.borderFaint) : null,
            boxShadow: isDark
                ? [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 10)]
                : [BoxShadow(color: Colors.black.withAlpha(6), blurRadius: 8, offset: const Offset(0, 2))],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final item = entry.value;
              final isFirst = entry.key == 0;
              final isLast = entry.key == items.length - 1;
              final radius = BorderRadius.vertical(
                top: isFirst ? const Radius.circular(18) : Radius.zero,
                bottom: isLast ? const Radius.circular(18) : Radius.zero,
              );
              return Column(
                children: [
                  InkWell(
                    borderRadius: radius,
                    onTap: item.isSwitch ? null : item.onTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: item.iconColor.withAlpha(isDark ? 30 : 20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(item.icon, color: item.iconColor, size: 17),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(item.label,
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w700, fontSize: 15,
                                  color: item.labelColor ?? (isDark ? KidsColors.textPrimary : KidsColors.darkMid),
                                )),
                          ),
                          if (item.isSwitch && item.onSwitchChanged != null)
                            Switch(
                              value: item.switchValue ?? false,
                              onChanged: item.onSwitchChanged,
                              activeColor: KidsColors.saffron,
                            )
                          else if (item.trailing != null)
                            Text(item.trailing!,
                                style: GoogleFonts.nunito(
                                  color: KidsColors.textSecondary, fontWeight: FontWeight.w600))
                          else if (!item.isSwitch)
                            Icon(Icons.chevron_right_rounded,
                                color: isDark ? KidsColors.textSecondary : Colors.grey.shade400),
                        ],
                      ),
                    ),
                  ),
                  if (!isLast)
                    Divider(height: 1, indent: 60, color: KidsColors.borderFaint),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Color? labelColor;
  final String? trailing;
  final bool isSwitch;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
    this.labelColor,
    this.trailing,
    this.isSwitch = false,
    this.switchValue,
    this.onSwitchChanged,
  });
}
