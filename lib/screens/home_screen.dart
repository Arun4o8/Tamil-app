import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../data/cultures.dart';
import '../data/localization.dart';
import '../data/app_state.dart';
import '../screens/theme/kids_theme.dart';
import 'explore_screen.dart';
import 'celebrations_screen.dart';
import 'quiz_screen.dart';
import 'rules_screen.dart';
import 'detail_screen.dart';
import 'tamil_learning_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _heroCtrl;
  late Animation<double> _heroFade;
  late Animation<Offset> _heroSlide;
  int _tipIndex = 0;

  @override
  void initState() {
    super.initState();
    _heroCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _heroFade = CurvedAnimation(parent: _heroCtrl, curve: Curves.easeIn);
    _heroSlide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _heroCtrl, curve: Curves.easeOutCubic));
    _heroCtrl.forward();
    _tipIndex = DateTime.now().day % culturalTips.length;
  }

  @override
  void dispose() {
    _heroCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = XRTamilKidsApp.of(context).language;
    final su = ScreenUtils(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final today = DateTime.now().day;
    final cultureOfDay = allCultures[today % allCultures.length];

    return Scaffold(
      backgroundColor: isDark ? KidsColors.backgroundDark : KidsColors.backgroundLight,
      body: FadeTransition(
        opacity: _heroFade,
        child: SlideTransition(
          position: _heroSlide,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: su.horizontalPad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // ── Hero Banner ──────────────────────────────────────────────
                _HeroBanner(su: su, lang: lang, isDark: isDark),
                const SizedBox(height: 24),

                // ── Interactive Hub ──────────────────────────────────────────
                _SectionHeader(
                  title: translate('Interactive Hub', lang),
                  icon: Icons.touch_app_rounded,
                  color: KidsColors.saffron,
                  su: su,
                  isDark: isDark,
                ),
                const SizedBox(height: 14),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: su.gridCrossAxisCount,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: su.gridChildAspectRatio,
                  children: [
                    _ActionHubCard(
                      title: translate('Dances', lang),
                      imagePath: 'assets/images/app/home_dance.jpg',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExploreScreen())),
                    ),
                    _ActionHubCard(
                      title: translate('Celebration', lang),
                      imagePath: 'assets/images/app/home_celeb.jpg',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CelebrationsScreen())),
                    ),
                    _ActionHubCard(
                      title: translate('Learn Tamil', lang),
                      imagePath: 'assets/images/app/home_learn.jpg',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TamilLearningScreen())),
                    ),
                    _ActionHubCard(
                      title: translate('Quizzes', lang),
                      imagePath: 'assets/images/app/home_quiz.jpg',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizIntroScreen())),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ── Culture of the Day ───────────────────────────────────────
                _SectionHeader(
                  title: translate('Culture of the Day', lang),
                  icon: Icons.wb_sunny_rounded,
                  color: KidsColors.gold,
                  su: su,
                  isDark: isDark,
                ),
                const SizedBox(height: 14),
                _CultureOfTheDayCard(culture: cultureOfDay, su: su, lang: lang, isDark: isDark),
                const SizedBox(height: 24),

                // ── Daily Cultural Tip ───────────────────────────────────────
                _DailyTipCard(su: su, tipIndex: _tipIndex, isDark: isDark),
                const SizedBox(height: 20),

                // ── Guidelines ──────────────────────────────────────────────
                _GuidelinesBanner(su: su, lang: lang),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────── WIDGETS ──────────────────────

class _HeroBanner extends StatelessWidget {
  final ScreenUtils su;
  final String lang;
  final bool isDark;
  const _HeroBanner({required this.su, required this.lang, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: su.heroBannerHeight,
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
                colors: [Color(0xFF1A1230), Color(0xFF0D0D1F)],
                begin: Alignment.topLeft, end: Alignment.bottomRight)
            : KidsColors.heroGrad,
        borderRadius: BorderRadius.circular(su.cardRadius),
        border: isDark ? Border.all(color: KidsColors.borderFaint, width: 1) : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Decorative background glyph
          Positioned(
            right: -10, bottom: -10,
            child: Text('த',
              style: TextStyle(
                fontSize: su.fluid(120.0, 140.0, 160.0, 200.0),
                fontWeight: FontWeight.w900,
                color: Colors.white.withAlpha(isDark ? 12 : 30),
                fontFamily: 'NotoSansTamil',
              ),
            ),
          ),
          // Amber glow circle
          if (isDark)
            Positioned(
              top: -30, right: 60,
              child: Container(
                width: 120, height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: KidsColors.saffron.withAlpha(20),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(su.fluid(20.0, 24.0, 28.0, 32.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: KidsColors.saffron.withAlpha(isDark ? 40 : 60),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: KidsColors.saffron.withAlpha(80)),
                  ),
                  child: Text('தமிழ் வணக்கம்',
                      style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
                const SizedBox(height: 12),
                Text(
                  translate('Discover Tamil Heritage', lang),
                  style: GoogleFonts.poppins(
                    fontSize: su.fluid(20.0, 24.0, 26.0, 30.0),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  translate('Ancient traditions, timeless wisdom', lang),
                  style: GoogleFonts.nunito(
                    fontSize: 13, fontWeight: FontWeight.w600,
                    color: Colors.white.withAlpha(160),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Daily Cultural Tip ─────────────────────────────────────────────────────────
class _DailyTipCard extends StatelessWidget {
  final ScreenUtils su;
  final int tipIndex;
  final bool isDark;
  const _DailyTipCard({required this.su, required this.tipIndex, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final tip = culturalTips[tipIndex];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? KidsColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(su.cardRadius),
        border: Border.all(
          color: isDark ? KidsColors.gold.withAlpha(60) : KidsColors.gold.withAlpha(100),
          width: 1,
        ),
        boxShadow: isDark
            ? [BoxShadow(color: KidsColors.gold.withAlpha(20), blurRadius: 12)]
            : [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              gradient: KidsColors.goldGrad,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lightbulb_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip['title'] ?? 'Did You Know?',
                  style: GoogleFonts.nunito(
                    fontSize: 11, fontWeight: FontWeight.w800,
                    color: KidsColors.gold, letterSpacing: 0.3),
                ),
                const SizedBox(height: 3),
                Text(
                  tip['body'] ?? '',
                  style: GoogleFonts.nunito(
                    fontSize: 13, fontWeight: FontWeight.w600,
                    color: isDark ? KidsColors.textSecondary : KidsColors.grey,
                    height: 1.4,
                  ),
                  maxLines: 2, overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Guidelines Banner ──────────────────────────────────────────────────────────
class _GuidelinesBanner extends StatelessWidget {
  final ScreenUtils su;
  final String lang;
  const _GuidelinesBanner({required this.su, required this.lang});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RulesScreen())),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [KidsColors.grape, KidsColors.sky]),
          borderRadius: BorderRadius.circular(su.cardRadius),
          boxShadow: [BoxShadow(color: KidsColors.sky.withAlpha(60), blurRadius: 15, offset: const Offset(0, 6))],
        ),
        child: Padding(
          padding: EdgeInsets.all(su.fluid(14.0, 16.0, 20.0, 24.0)),
          child: Row(
            children: [
              Container(
                height: 48, width: 48,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: const Center(
                  child: Icon(Icons.menu_book_rounded, color: KidsColors.grape, size: 24),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(translate('Learning Guidelines', lang),
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text(translate('Best practices & step guides', lang),
                        style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Culture of the Day ─────────────────────────────────────────────────────────
class _CultureOfTheDayCard extends StatelessWidget {
  final CultureItem culture;
  final ScreenUtils su;
  final String lang;
  final bool isDark;
  const _CultureOfTheDayCard({required this.culture, required this.su, required this.lang, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(culture: culture))),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? KidsColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(su.cardRadius),
          border: isDark ? Border.all(color: KidsColors.borderFaint) : null,
          boxShadow: isDark
              ? [BoxShadow(color: Colors.black.withAlpha(80), blurRadius: 20, offset: const Offset(0, 8))]
              : [BoxShadow(color: Colors.black.withAlpha(12), blurRadius: 15, offset: const Offset(0, 6))],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(culture.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: culture.color.withAlpha(40))),
                  if (isDark)
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter, end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withAlpha(100)],
                        ),
                      ),
                    ),
                  // Right-edge watermark cover
                  Positioned(
                    top: 0, bottom: 0, right: 0,
                    width: 32,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.transparent,
                            isDark ? KidsColors.surfaceDark : Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Category badge
                  Positioned(
                    top: 12, left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(120),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withAlpha(60)),
                      ),
                      child: Text(culture.localType(lang),
                          style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(culture.localName(lang),
                      style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700,
                        color: isDark ? KidsColors.textPrimary : KidsColors.dark,
                      )),
                  const SizedBox(height: 6),
                  Text(culture.localDesc(lang),
                      style: GoogleFonts.nunito(
                        fontSize: 13, fontWeight: FontWeight.w600,
                        color: isDark ? KidsColors.textSecondary : KidsColors.grey,
                        height: 1.5,
                      ),
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Explore Now',
                          style: GoogleFonts.nunito(
                            fontSize: 13, fontWeight: FontWeight.w800, color: KidsColors.saffron)),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_rounded, size: 14, color: KidsColors.saffron),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Section Header ──────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final ScreenUtils su;
  final bool isDark;
  const _SectionHeader({required this.title, required this.icon, required this.color, required this.su, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withAlpha(isDark ? 30 : 25),
            shape: BoxShape.circle,
            border: Border.all(color: color.withAlpha(60)),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Text(title,
            style: GoogleFonts.poppins(
              fontSize: su.fluid(16.0, 18.0, 20.0, 22.0),
              fontWeight: FontWeight.w700,
              color: isDark ? KidsColors.textPrimary : KidsColors.dark,
            )),
      ],
    );
  }
}

// ── Action Hub Card ─────────────────────────────────────────────────────────────
class _ActionHubCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  const _ActionHubCard({required this.title, required this.imagePath, required this.onTap});

  @override
  State<_ActionHubCard> createState() => _ActionHubCardState();
}

class _ActionHubCardState extends State<_ActionHubCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) { setState(() => _pressed = false); widget.onTap(); },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(40),
                blurRadius: 16, offset: const Offset(0, 6),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(widget.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withAlpha(180)],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
                  child: Text(widget.title,
                      style: GoogleFonts.nunito(
                        fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white),
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
