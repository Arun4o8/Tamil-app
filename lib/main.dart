import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/saved_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/theme/kids_theme.dart';
import 'data/localization.dart';
import 'data/app_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStateService.instance.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0A0A14),
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const XRTamilKidsApp());
}

class XRTamilKidsApp extends StatefulWidget {
  const XRTamilKidsApp({super.key});

  static _XRTamilKidsAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_XRTamilKidsAppState>()!;

  @override
  State<XRTamilKidsApp> createState() => _XRTamilKidsAppState();
}

class _XRTamilKidsAppState extends State<XRTamilKidsApp> {
  bool _darkMode = true; // Default: dark (Heritage Codex aesthetic)
  String _language = 'English';

  String get language => _language;

  void toggleDarkMode(bool val) => setState(() => _darkMode = val);
  void setLanguage(String lang) => setState(() => _language = lang);

  @override
  Widget build(BuildContext context) {
    final nunitoText = GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: KidsColors.textPrimary,
      displayColor: KidsColors.textPrimary,
    );

    // ── Dark Heritage Theme ──────────────────────────────────────────────────
    final darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: nunitoText,
      scaffoldBackgroundColor: KidsColors.backgroundDark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: KidsColors.saffron,
        brightness: Brightness.dark,
      ).copyWith(
        primary: KidsColors.saffron,
        secondary: KidsColors.teal,
        surface: KidsColors.surfaceDark,
        surfaceContainerHighest: KidsColors.backgroundDark,
        onSurface: KidsColors.textPrimary,
        onSurfaceVariant: KidsColors.textSecondary,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: KidsColors.surfaceDark,
        elevation: 0,
        indicatorColor: KidsColors.saffron.withAlpha(50),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.nunito(
              fontWeight: FontWeight.w800, fontSize: 12, color: KidsColors.saffron);
          }
          return GoogleFonts.nunito(
            fontWeight: FontWeight.w600, fontSize: 12, color: KidsColors.textSecondary);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: KidsColors.saffron);
          }
          return const IconThemeData(color: KidsColors.textSecondary);
        }),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: KidsColors.surfaceDark,
        surfaceTintColor: Colors.transparent,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: KidsColors.surfaceDark,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20, fontWeight: FontWeight.w700, color: KidsColors.textPrimary),
        iconTheme: const IconThemeData(color: KidsColors.textPrimary),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: KidsColors.saffron,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.nunito(fontSize: 17, fontWeight: FontWeight.w800),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: KidsColors.surfaceMid,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: KidsColors.borderFaint, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: KidsColors.saffron, width: 1.5),
        ),
        hintStyle: GoogleFonts.nunito(color: KidsColors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: KidsColors.surfaceLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        contentTextStyle: GoogleFonts.nunito(fontWeight: FontWeight.w700, color: KidsColors.textPrimary),
      ),
      dividerColor: KidsColors.borderFaint,
    );

    // ── Light Theme fallback ─────────────────────────────────────────────────
    final lightTheme = ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).apply(
        bodyColor: KidsColors.darkMid,
        displayColor: KidsColors.dark,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: KidsColors.saffron,
        brightness: Brightness.light,
      ).copyWith(
        primary: KidsColors.saffron,
        secondary: KidsColors.teal,
        surface: Colors.white,
        surfaceContainerHighest: KidsColors.backgroundLight,
        onSurface: KidsColors.dark,
        onSurfaceVariant: KidsColors.grey,
      ),
      scaffoldBackgroundColor: KidsColors.backgroundLight,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 1,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20, fontWeight: FontWeight.w700, color: KidsColors.dark),
        iconTheme: const IconThemeData(color: KidsColors.dark),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: KidsColors.saffron, width: 1.5),
        ),
        hintStyle: GoogleFonts.nunito(color: KidsColors.grey, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 8,
        shadowColor: Colors.black26,
        indicatorColor: KidsColors.saffron.withAlpha(35),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        contentTextStyle: GoogleFonts.nunito(fontWeight: FontWeight.w700),
      ),
    );

    return MaterialApp(
      title: 'Tamil Heritage Codex',
      debugShowCheckedModeBanner: false,
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const SplashScreen(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// APP SHELL — Bottom Navigation Container
// ─────────────────────────────────────────────────────────────────────────────
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with TickerProviderStateMixin {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final su = ScreenUtils(context);
    final lang = XRTamilKidsApp.of(context).language;

    final List<Widget> tabs = [
      const HomeScreen(),
      const ExploreScreen(),
      const SavedScreen(),
      const ProfileScreen(),
    ];

    return ListenableBuilder(
      listenable: AppStateService.instance,
      builder: (context, _) {
        // Show achievement toast if unlocked
        final newAchievement = AppStateService.instance.lastUnlocked;
        if (newAchievement != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showAchievementToast(context, newAchievement);
            AppStateService.instance.clearLastUnlocked();
          });
        }

        return Scaffold(
          backgroundColor: scheme.surfaceContainerHighest,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(64 + MediaQuery.of(context).padding.top),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? KidsColors.surfaceDark : Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? KidsColors.borderFaint : Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              padding: EdgeInsets.fromLTRB(
                su.horizontalPad,
                MediaQuery.of(context).padding.top + 10,
                su.horizontalPad,
                10,
              ),
              child: Row(
                children: [
                  // App logo glyph
                  Container(
                    width: 42, height: 42,
                    decoration: BoxDecoration(
                      gradient: KidsColors.saffronGrad,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: KidsColors.saffron.withAlpha(80),
                          blurRadius: 12, offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('த', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tamil Heritage',
                          style: GoogleFonts.poppins(
                            fontSize: su.fluid(15.0, 16.0, 17.0, 20.0),
                            fontWeight: FontWeight.w700,
                            color: isDark ? KidsColors.textPrimary : KidsColors.dark,
                          )),
                      Text('தமிழ் கலாச்சாரம்',
                          style: GoogleFonts.nunito(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: KidsColors.textSecondary,
                          )),
                    ],
                  ),
                  const Spacer(),
                  // Language toggle button
                  _LanguageToggle(
                    language: lang,
                    onToggle: () {
                      final newLang = lang == 'English' ? 'Tamil' : 'English';
                      XRTamilKidsApp.of(context).setLanguage(newLang);
                    },
                  ),
                ],
              ),
            ),
          ),
          body: IndexedStack(index: _currentTab, children: tabs),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: isDark ? KidsColors.surfaceDark : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? KidsColors.borderFaint : Colors.grey.shade200,
                ),
              ),
            ),
            child: NavigationBar(
              selectedIndex: _currentTab,
              onDestinationSelected: (i) => setState(() => _currentTab = i),
              animationDuration: const Duration(milliseconds: 300),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              height: 68,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined, size: 24),
                  selectedIcon: const Icon(Icons.home_rounded, size: 24, color: KidsColors.saffron),
                  label: translate('Home', lang),
                ),
                NavigationDestination(
                  icon: const Icon(Icons.explore_outlined, size: 24),
                  selectedIcon: const Icon(Icons.explore_rounded, size: 24, color: KidsColors.saffron),
                  label: translate('Explore', lang),
                ),
                NavigationDestination(
                  icon: const Icon(Icons.bookmark_outline_rounded, size: 24),
                  selectedIcon: const Icon(Icons.bookmark_rounded, size: 24, color: KidsColors.saffron),
                  label: translate('Saved', lang),
                ),
                NavigationDestination(
                  icon: const Icon(Icons.person_outline_rounded, size: 24),
                  selectedIcon: const Icon(Icons.person_rounded, size: 24, color: KidsColors.saffron),
                  label: translate('Profile', lang),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAchievementToast(BuildContext context, Achievement achievement) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(builder: (_) => _AchievementToast(achievement: achievement, onDismiss: () => entry.remove()));
    overlay.insert(entry);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LANGUAGE TOGGLE BUTTON
// ─────────────────────────────────────────────────────────────────────────────
class _LanguageToggle extends StatelessWidget {
  final String language;
  final VoidCallback onToggle;
  const _LanguageToggle({required this.language, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: KidsColors.saffron.withAlpha(20),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: KidsColors.saffron.withAlpha(80), width: 1),
        ),
        child: Row(
          children: [
            const Icon(Icons.language, size: 14, color: KidsColors.saffron),
            const SizedBox(width: 5),
            Text(
              language == 'English' ? 'EN' : 'தமிழ்',
              style: GoogleFonts.nunito(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: KidsColors.saffron,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ACHIEVEMENT TOAST
// ─────────────────────────────────────────────────────────────────────────────
class _AchievementToast extends StatefulWidget {
  final Achievement achievement;
  final VoidCallback onDismiss;
  const _AchievementToast({required this.achievement, required this.onDismiss});

  @override
  State<_AchievementToast> createState() => _AchievementToastState();
}

class _AchievementToastState extends State<_AchievementToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _slide = Tween<Offset>(begin: const Offset(0, -1.5), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _ctrl.reverse().then((_) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 80,
      left: 20, right: 20,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _fade,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: KidsColors.surfaceMid,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: widget.achievement.color.withAlpha(100), width: 1),
                boxShadow: [
                  BoxShadow(color: widget.achievement.color.withAlpha(60), blurRadius: 20),
                  const BoxShadow(color: Colors.black54, blurRadius: 30, offset: Offset(0, 10)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: widget.achievement.color.withAlpha(30),
                      shape: BoxShape.circle,
                      border: Border.all(color: widget.achievement.color.withAlpha(80)),
                    ),
                    child: Icon(widget.achievement.icon, color: widget.achievement.color, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Achievement Unlocked!',
                            style: GoogleFonts.nunito(
                              fontSize: 11, fontWeight: FontWeight.w700, color: widget.achievement.color)),
                        Text(widget.achievement.title,
                            style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w700, color: KidsColors.textPrimary)),
                        Text(widget.achievement.description,
                            style: GoogleFonts.nunito(
                              fontSize: 12, color: KidsColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
