import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/quiz.dart';
import '../data/localization.dart';
import '../data/app_state.dart';
import '../main.dart';
import '../screens/theme/kids_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// QUIZ INTRO SCREEN
// ─────────────────────────────────────────────────────────────────────────────
class QuizIntroScreen extends StatefulWidget {
  const QuizIntroScreen({super.key});

  @override
  State<QuizIntroScreen> createState() => _QuizIntroScreenState();
}

class _QuizIntroScreenState extends State<QuizIntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale, _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = XRTamilKidsApp.of(context).language;
    final su = ScreenUtils(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final service = AppStateService.instance;
    final bestPct = service.bestQuizPct;
    final attempts = service.quizAttempts;

    return Scaffold(
      backgroundColor: isDark ? KidsColors.backgroundDark : KidsColors.backgroundLight,
      appBar: AppBar(
        title: Text(translate('Cultural Quiz', lang)),
        backgroundColor: isDark ? KidsColors.surfaceDark : Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: FadeTransition(
        opacity: _fade,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(su.horizontalPad + 4),
          child: Column(
            children: [
              SizedBox(height: su.fluid(20.0, 28.0, 36.0, 48.0)),

              // ── Trophy icon ──────────────────────────────────────────────
              ScaleTransition(
                scale: _scale,
                child: Container(
                  width: su.fluid(110.0, 130.0, 150.0, 180.0),
                  height: su.fluid(110.0, 130.0, 150.0, 180.0),
                  decoration: BoxDecoration(
                    gradient: KidsColors.quizGrad,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: KidsColors.grape.withAlpha(100), blurRadius: 30, offset: const Offset(0, 12)),
                      BoxShadow(color: Colors.black.withAlpha(isDark ? 100 : 30), blurRadius: 20, offset: const Offset(0, 6)),
                    ],
                    border: Border.all(color: Colors.white.withAlpha(30), width: 1),
                  ),
                  child: Icon(Icons.emoji_events_rounded,
                      size: su.fluid(52.0, 62.0, 72.0, 90.0),
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),

              // ── Title ─────────────────────────────────────────────────────
              Text(
                'Master the Heritage',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: su.headFontSize,
                  fontWeight: FontWeight.w700,
                  color: isDark ? KidsColors.textPrimary : KidsColors.dark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Test your Tamil cultural knowledge',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 14, fontWeight: FontWeight.w600,
                  color: KidsColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),

              // ── Description card ──────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: isDark
                    ? KidsDecor.card(radius: su.cardRadius)
                    : BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(su.cardRadius),
                        boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 12)],
                      ),
                child: Text(
                  'Select a topic below to begin your challenge. Answer questions about Tamil Nadu\'s vibrant dance forms, cuisine, and history.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: su.bodyFontSize, fontWeight: FontWeight.w600,
                    color: isDark ? KidsColors.textSecondary : KidsColors.grey,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ── Stats row ─────────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _StatChip(
                      label: '${quizQuestions.length} Total Qs',
                      icon: Icons.quiz_rounded,
                      color: KidsColors.sky,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatChip(
                      label: attempts == 0 ? 'No Attempts' : 'Best: $bestPct%',
                      icon: attempts == 0 ? Icons.star_outline_rounded : Icons.star_rounded,
                      color: KidsColors.gold,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
              SizedBox(height: su.fluid(24.0, 30.0, 36.0, 44.0)),

              // ── Topics List ──────────────────────────────────────────────
              ...quizQuestions.map((e) => e.topic).toSet().map((topic) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ActiveQuizScreen(topic: topic)),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: su.buttonHeight + 10,
                      decoration: KidsDecor.gradient(KidsColors.quizGrad, radius: su.cardRadius),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 24),
                          const SizedBox(width: 12),
                          Text(topic,
                              style: GoogleFonts.nunito(
                                fontSize: su.fluid(16.0, 17.0, 18.0, 20.0),
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ACTIVE QUIZ SCREEN
// ─────────────────────────────────────────────────────────────────────────────
class ActiveQuizScreen extends StatefulWidget {
  final String topic;
  const ActiveQuizScreen({super.key, required this.topic});

  @override
  State<ActiveQuizScreen> createState() => _ActiveQuizScreenState();
}

class _ActiveQuizScreenState extends State<ActiveQuizScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  int _score = 0;
  bool _answered = false;
  int _selectedOption = -1;
  late List<QuizQuestion> _questions;

  late AnimationController _questionCtrl;
  late Animation<Offset> _questionSlide;

  @override
  void initState() {
    super.initState();
    _questions = quizQuestions.where((q) => q.topic == widget.topic).toList();
    _questions.shuffle();
    _questionCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _questionSlide = Tween<Offset>(begin: const Offset(0.05, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _questionCtrl, curve: Curves.easeOut));
    _questionCtrl.forward();
  }

  @override
  void dispose() {
    _questionCtrl.dispose();
    super.dispose();
  }

  void _submitAnswer(int optionIndex) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _selectedOption = optionIndex;
      if (optionIndex == _questions[_currentIndex].answerIndex) _score++;
    });

    Future.delayed(const Duration(milliseconds: 1100), () {
      if (!mounted) return;
      if (_currentIndex < _questions.length - 1) {
        _questionCtrl.reset();
        setState(() {
          _currentIndex++;
          _answered = false;
          _selectedOption = -1;
        });
        _questionCtrl.forward();
      } else {
        // Record the quiz score
        AppStateService.instance.recordQuizScore(_score, _questions.length);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => QuizResultScreen(score: _score, total: _questions.length, topic: widget.topic)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;
    final lang = XRTamilKidsApp.of(context).language;
    final su = ScreenUtils(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? KidsColors.backgroundDark : KidsColors.backgroundLight;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: Text(widget.topic),
        backgroundColor: isDark ? KidsColors.surfaceDark : Colors.white,
        surfaceTintColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              gradient: KidsColors.goldGrad,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.star_rounded, color: Colors.white, size: 15),
              const SizedBox(width: 4),
              Text('${_score * 10} pts',
                  style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white)),
            ]),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(su.horizontalPad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Progress area ───────────────────────────────────────────
              Row(
                children: [
                  Text(
                    'Q ${_currentIndex + 1} / ${_questions.length}',
                    style: GoogleFonts.nunito(
                      fontSize: su.bodyFontSize,
                      fontWeight: FontWeight.w800,
                      color: KidsColors.grape,
                    ),
                  ),
                  const Spacer(),
                  // Dot progress indicators
                  Row(
                    children: List.generate(_questions.length, (i) {
                      Color dotColor;
                      if (i < _currentIndex) {
                        dotColor = KidsColors.teal;
                      } else if (i == _currentIndex) {
                        dotColor = KidsColors.saffron;
                      } else {
                        dotColor = isDark ? KidsColors.surfaceLight : Colors.grey.shade300;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: i == _currentIndex ? 18 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: dotColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: isDark ? KidsColors.surfaceLight : Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation(KidsColors.grape),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 18),

              // ── Question card ────────────────────────────────────────────
              SlideTransition(
                position: _questionSlide,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(su.fluid(18.0, 20.0, 24.0, 28.0)),
                  decoration: isDark
                      ? KidsDecor.card(radius: su.cardRadius)
                      : BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(su.cardRadius),
                          boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 12)],
                        ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: KidsColors.grape.withAlpha(isDark ? 30 : 20),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: KidsColors.grape.withAlpha(60)),
                            ),
                            child: Row(children: [
                              const Icon(Icons.psychology_rounded, size: 14, color: KidsColors.grape),
                              const SizedBox(width: 5),
                              Text('Think carefully',
                                  style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: KidsColors.grape)),
                            ]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        question.question,
                        style: GoogleFonts.nunito(
                          fontSize: su.titleFontSize - 2,
                          fontWeight: FontWeight.w800,
                          color: isDark ? KidsColors.textPrimary : KidsColors.dark,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── Answer options ─────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: question.options.length,
                  itemBuilder: (_, index) {
                    final isCorrect = _answered && index == question.answerIndex;
                    final isWrong = _answered && index == _selectedOption && index != question.answerIndex;
                    final isNeutral = !_answered || (!isCorrect && !isWrong);

                    Color bgColor;
                    Color borderColor;
                    Color textColor;
                    Color labelBg;
                    Color labelText;
                    IconData? trailingIcon;

                    if (isCorrect) {
                      bgColor = KidsColors.forest.withAlpha(isDark ? 30 : 20);
                      borderColor = KidsColors.forest;
                      textColor = KidsColors.forest;
                      labelBg = KidsColors.forest;
                      labelText = Colors.white;
                      trailingIcon = Icons.check_circle_rounded;
                    } else if (isWrong) {
                      bgColor = KidsColors.bubblegum.withAlpha(isDark ? 30 : 20);
                      borderColor = KidsColors.bubblegum;
                      textColor = KidsColors.bubblegum;
                      labelBg = KidsColors.bubblegum;
                      labelText = Colors.white;
                      trailingIcon = Icons.cancel_rounded;
                    } else {
                      bgColor = isDark ? KidsColors.surfaceMid : Colors.white;
                      borderColor = isDark ? KidsColors.borderFaint : Colors.grey.shade200;
                      textColor = isDark ? KidsColors.textPrimary : KidsColors.darkMid;
                      labelBg = isDark ? KidsColors.surfaceLight : Colors.grey.shade100;
                      labelText = isDark ? KidsColors.textSecondary : KidsColors.grey;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => _submitAnswer(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: EdgeInsets.all(su.fluid(14.0, 15.0, 16.0, 18.0)),
                          decoration: BoxDecoration(
                            color: bgColor,
                            border: Border.all(color: borderColor, width: isNeutral ? 1 : 1.5),
                            borderRadius: BorderRadius.circular(su.cardRadius - 4),
                            boxShadow: isCorrect || isWrong
                                ? [BoxShadow(color: borderColor.withAlpha(50), blurRadius: 12, offset: const Offset(0, 4))]
                                : null,
                          ),
                          child: Row(
                            children: [
                              // Letter bubble
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                width: su.fluid(34.0, 36.0, 38.0, 42.0),
                                height: su.fluid(34.0, 36.0, 38.0, 42.0),
                                decoration: BoxDecoration(color: labelBg, shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + index),
                                    style: GoogleFonts.nunito(
                                      fontSize: su.fluid(14.0, 15.0, 15.0, 16.0),
                                      fontWeight: FontWeight.w800,
                                      color: labelText,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  question.options[index],
                                  style: GoogleFonts.nunito(
                                    fontSize: su.fluid(14.0, 14.0, 15.0, 16.0),
                                    fontWeight: FontWeight.w700,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              if (trailingIcon != null)
                                Icon(trailingIcon, color: textColor, size: 22),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// QUIZ RESULT SCREEN
// ─────────────────────────────────────────────────────────────────────────────
class QuizResultScreen extends StatefulWidget {
  final int score;
  final int total;
  final String topic;
  const QuizResultScreen({super.key, required this.score, required this.total, required this.topic});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale, _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = XRTamilKidsApp.of(context).language;
    final su = ScreenUtils(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pct = widget.score / widget.total;

    final IconData icon = pct == 1.0
        ? Icons.emoji_events_rounded
        : (pct >= 0.6 ? Icons.star_rounded : Icons.fitness_center_rounded);
    final LinearGradient grad = pct == 1.0
        ? const LinearGradient(colors: [Color(0xFFFFD600), Color(0xFFFF8F00)])
        : (pct >= 0.6
            ? const LinearGradient(colors: [KidsColors.forest, KidsColors.teal])
            : const LinearGradient(colors: [KidsColors.sky, KidsColors.grape]));
    final String message = pct == 1.0
        ? 'Perfect! You are a Culture Master!'
        : (pct >= 0.6 ? 'Well done! Keep exploring!' : 'Keep learning! Read more in Explore!');
    final int litStars = pct == 1.0 ? 3 : (pct >= 0.6 ? 2 : 1);

    return Scaffold(
      backgroundColor: isDark ? KidsColors.backgroundDark : KidsColors.backgroundLight,
      body: FadeTransition(
        opacity: _fade,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(su.horizontalPad + 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: su.fluid(40.0, 48.0, 56.0, 70.0)),

              // Result icon
              ScaleTransition(
                scale: _scale,
                child: Container(
                  width: su.fluid(110.0, 130.0, 150.0, 180.0),
                  height: su.fluid(110.0, 130.0, 150.0, 180.0),
                  decoration: BoxDecoration(
                    gradient: grad,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withAlpha(30), width: 1),
                    boxShadow: [
                      BoxShadow(color: grad.colors.first.withAlpha(100), blurRadius: 30, offset: const Offset(0, 12)),
                      BoxShadow(color: Colors.black.withAlpha(80), blurRadius: 20, offset: const Offset(0, 8)),
                    ],
                  ),
                  child: Icon(icon, size: su.fluid(52.0, 62.0, 72.0, 88.0), color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),

              Text('Quiz Complete', textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: su.headFontSize, fontWeight: FontWeight.w700,
                    color: isDark ? KidsColors.textPrimary : KidsColors.dark,
                  )),
              const SizedBox(height: 20),

              // Star rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  final bool lit = i < litStars;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: AnimatedScale(
                      scale: lit ? 1.0 : 0.7,
                      duration: Duration(milliseconds: 300 + i * 100),
                      child: Icon(
                        lit ? Icons.star_rounded : Icons.star_outline_rounded,
                        color: lit ? KidsColors.gold : (isDark ? KidsColors.surfaceLight : Colors.grey.shade300),
                        size: su.fluid(44.0, 50.0, 56.0, 68.0),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Score card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(su.fluid(20.0, 24.0, 26.0, 30.0)),
                decoration: isDark
                    ? KidsDecor.card(radius: su.cardRadius)
                    : BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(su.cardRadius),
                        boxShadow: [BoxShadow(color: Colors.black.withAlpha(12), blurRadius: 15)],
                      ),
                child: Column(
                  children: [
                    Text('${widget.score} / ${widget.total}',
                        style: GoogleFonts.poppins(
                          fontSize: su.headFontSize + 4,
                          fontWeight: FontWeight.w700,
                          color: grad.colors.first,
                        )),
                    const SizedBox(height: 4),
                    Text('Correct Answers',
                        style: GoogleFonts.nunito(
                          fontSize: su.bodyFontSize, fontWeight: FontWeight.w700,
                          color: KidsColors.textSecondary,
                        )),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: pct,
                        valueColor: AlwaysStoppedAnimation(grad.colors.first),
                        backgroundColor: isDark ? KidsColors.surfaceLight : Colors.grey.shade100,
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(message,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: su.bodyFontSize, fontWeight: FontWeight.w700,
                          color: isDark ? KidsColors.textSecondary : KidsColors.grey,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Retry button
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => ActiveQuizScreen(topic: widget.topic)),
                ),
                child: Container(
                  width: double.infinity,
                  height: su.buttonHeight,
                  decoration: KidsDecor.gradient(KidsColors.quizGrad, radius: su.cardRadius),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.refresh_rounded, color: Colors.white, size: 22),
                      const SizedBox(width: 10),
                      Text('Try Again',
                          style: GoogleFonts.nunito(
                            fontSize: su.fluid(15.0, 16.0, 17.0, 18.0),
                            fontWeight: FontWeight.w800, color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Home button
              GestureDetector(
                onTap: () => Navigator.popUntil(context, (r) => r.isFirst),
                child: Container(
                  width: double.infinity,
                  height: su.buttonHeight,
                  decoration: BoxDecoration(
                    color: isDark ? KidsColors.surfaceMid : Colors.white,
                    borderRadius: BorderRadius.circular(su.cardRadius),
                    border: Border.all(
                      color: isDark ? KidsColors.borderFaint : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home_rounded,
                          color: isDark ? KidsColors.textPrimary : KidsColors.darkMid, size: 22),
                      const SizedBox(width: 10),
                      Text(translate('Back to Home', lang),
                          style: GoogleFonts.nunito(
                            fontSize: su.fluid(15.0, 16.0, 17.0, 18.0),
                            fontWeight: FontWeight.w800,
                            color: isDark ? KidsColors.textPrimary : KidsColors.darkMid,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STAT CHIP
// ─────────────────────────────────────────────────────────────────────────────
class _StatChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isDark;
  const _StatChip({required this.label, required this.icon, required this.color, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? KidsColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withAlpha(isDark ? 60 : 80)),
        boxShadow: isDark
            ? [BoxShadow(color: color.withAlpha(20), blurRadius: 8)]
            : [BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 8)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(label,
              style: GoogleFonts.nunito(
                fontSize: 13, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
    );
  }
}
