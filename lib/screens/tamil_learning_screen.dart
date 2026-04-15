import 'package:flutter/material.dart';
import 'dart:math';
import '../main.dart';
import '../data/localization.dart';
import 'theme/kids_theme.dart';

// ─── DATA MODELS ─────────────────────────────────────────────────────────────
class FlashcardItem {
  final String tamilText;
  final String englishText;
  final String description;
  final Color color;

  FlashcardItem(this.tamilText, this.englishText, this.description, this.color);
}

// ─── DATA SOURCES ────────────────────────────────────────────────────────────
final List<FlashcardItem> vowels = [
  FlashcardItem('அ', 'a', 'Like in "Amma" (Mother)', KidsColors.saffron),
  FlashcardItem('ஆ', 'aa', 'Like in "Aadu" (Goat)', KidsColors.teal),
  FlashcardItem('இ', 'i', 'Like in "Ilai" (Leaf)', KidsColors.bubblegum),
  FlashcardItem('ஈ', 'ee', 'Like in "Eetti" (Spear)', KidsColors.sky),
  FlashcardItem('உ', 'u', 'Like in "Ulagam" (World)', KidsColors.sunshine),
  FlashcardItem('ஊ', 'oo', 'Like in "Oosi" (Needle)', KidsColors.grape),
  FlashcardItem('எ', 'e', 'Like in "Eli" (Rat)', KidsColors.forest),
  FlashcardItem('ஏ', 'ee', 'Like in "Eani" (Ladder)', KidsColors.saffronDark),
  FlashcardItem('ஐ', 'ai', 'Like in "Ainthu" (Five)', KidsColors.tealDark),
  FlashcardItem('ஒ', 'o', 'Like in "Ottagam" (Camel)', KidsColors.bubblegumLight),
  FlashcardItem('ஓ', 'oo', 'Like in "Odam" (Boat)', KidsColors.skyLight),
  FlashcardItem('ஔ', 'au', 'Like in "Avvai" (Old Woman)', KidsColors.sunshineLight),
  FlashcardItem('ஃ', 'ah', 'Aaytha Ezhuthu (Special Letter)', KidsColors.grey),
];

final List<FlashcardItem> numbers = [
  FlashcardItem('௧\n1', 'Onru', 'One', KidsColors.saffron),
  FlashcardItem('௨\n2', 'Irandu', 'Two', KidsColors.teal),
  FlashcardItem('௩\n3', 'Moondru', 'Three', KidsColors.bubblegum),
  FlashcardItem('௪\n4', 'Naangu', 'Four', KidsColors.sky),
  FlashcardItem('௫\n5', 'Ainthu', 'Five', KidsColors.sunshine),
  FlashcardItem('௬\n6', 'Aaru', 'Six', KidsColors.grape),
  FlashcardItem('௭\n7', 'Ezhu', 'Seven', KidsColors.forest),
  FlashcardItem('௮\n8', 'Ettu', 'Eight', KidsColors.saffronDark),
  FlashcardItem('௯\n9', 'Onbadhu', 'Nine', KidsColors.tealDark),
  FlashcardItem('௰\n10', 'Pathu', 'Ten', KidsColors.bubblegumLight),
];

final List<FlashcardItem> basics = [
  FlashcardItem('வணக்கம்', 'Vanakkam', 'Hello / Welcome', KidsColors.forest),
  FlashcardItem('நன்றி', 'Nandri', 'Thank you', KidsColors.bubblegum),
  FlashcardItem('காலை வணக்கம்', 'Kaalai Vanakkam', 'Good Morning', KidsColors.sunshine),
  FlashcardItem('எப்படி இருக்கிறீர்கள்?', 'Eppadi Irukkireergal?', 'How are you?', KidsColors.sky),
  FlashcardItem('நான் நன்றாக இருக்கிறேன்', 'Naan Nandraaga Irukkiren', 'I am fine', KidsColors.saffron),
  FlashcardItem('ஆம்', 'Aam', 'Yes', KidsColors.teal),
  FlashcardItem('இல்லை', 'Illai', 'No', KidsColors.grape),
  FlashcardItem('மன்னிக்கவும்', 'Mannikkavum', 'Sorry / Excuse me', KidsColors.grey),
];

final List<FlashcardItem> consonants = [
  FlashcardItem('க்', 'ik', 'Like in "Kaakam" (Crow)', KidsColors.saffron),
  FlashcardItem('ங்', 'ing', 'Like in "Sangu" (Conch)', KidsColors.teal),
  FlashcardItem('ச்', 'ich', 'Like in "Pachai" (Green)', KidsColors.bubblegum),
  FlashcardItem('ஞ்', 'inj', 'Like in "Oonjal" (Swing)', KidsColors.sky),
  FlashcardItem('ட்', 'it', 'Like in "Petti" (Box)', KidsColors.sunshine),
  FlashcardItem('ண்', 'in', 'Like in "Vandu" (Beetle)', KidsColors.grape),
  FlashcardItem('த்', 'ith', 'Like in "Vaathu" (Duck)', KidsColors.forest),
  FlashcardItem('ந்', 'indh', 'Like in "Panthu" (Ball)', KidsColors.saffronDark),
  FlashcardItem('ப்', 'ip', 'Like in "Kappal" (Ship)', KidsColors.tealDark),
  FlashcardItem('ம்', 'im', 'Like in "Maram" (Tree)', KidsColors.bubblegumLight),
  FlashcardItem('ய்', 'iy', 'Like in "Naay" (Dog)', KidsColors.skyLight),
  FlashcardItem('ர்', 'ir', 'Like in "Erumbu" (Ant)', KidsColors.sunshineLight),
  FlashcardItem('ல்', 'il', 'Like in "Puli" (Tiger)', KidsColors.grey),
  FlashcardItem('வ்', 'iv', 'Like in "Sevvandhi" (Flower)', KidsColors.saffron),
  FlashcardItem('ழ்', 'izh', 'Like in "Pazham" (Fruit)', KidsColors.teal),
  FlashcardItem('ள்', 'ill', 'Like in "Mull" (Thorn)', KidsColors.bubblegum),
  FlashcardItem('ற்', 'irr', 'Like in "Kaatru" (Wind)', KidsColors.sky),
  FlashcardItem('ன்', 'inn', 'Like in "Maan" (Deer)', KidsColors.sunshine),
];

final List<FlashcardItem> colorsList = [
  FlashcardItem('சிவப்பு', 'Sivappu', 'Red', Colors.red),
  FlashcardItem('நீலம்', 'Neelam', 'Blue', Colors.blue),
  FlashcardItem('பச்சை', 'Pachai', 'Green', Colors.green),
  FlashcardItem('மஞ்சள்', 'Manjal', 'Yellow', Colors.orangeAccent),
  FlashcardItem('ஆரஞ்சு', 'Orange', 'Orange', Colors.orange),
  FlashcardItem('ஊதா', 'Oodha', 'Purple / Violet', Colors.purple),
  FlashcardItem('கருப்பு', 'Karuppu', 'Black', Colors.blueGrey),
  FlashcardItem('வெள்ளை', 'Vellai', 'White', Colors.white70),
];

// ─── MAIN SCREEN ─────────────────────────────────────────────────────────────
class TamilLearningScreen extends StatefulWidget {
  const TamilLearningScreen({super.key});

  @override
  State<TamilLearningScreen> createState() => _TamilLearningScreenState();
}

class _TamilLearningScreenState extends State<TamilLearningScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = XRTamilKidsApp.of(context).language;
    final su = ScreenUtils(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? KidsColors.backgroundDark : KidsColors.backgroundLight,
      appBar: AppBar(
        title: Text(translate('Learn Tamil', lang), 
          style: KidsText.title(22).copyWith(color: isDark ? KidsColors.textPrimary : KidsColors.dark)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: KidsColors.saffron,
          indicatorWeight: 3,
          labelColor: KidsColors.saffron,
          unselectedLabelColor: KidsColors.textSecondary,
          labelStyle: KidsText.label(14, fontWeight: FontWeight.w800),
          unselectedLabelStyle: KidsText.body(14),
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
          tabs: const [
            Tab(text: 'Vowels'),
            Tab(text: 'Consonants'),
            Tab(text: 'Numbers'),
            Tab(text: 'Colors'),
            Tab(text: 'Basics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _FlashcardGrid(items: vowels, su: su, isDark: isDark),
          _FlashcardGrid(items: consonants, su: su, isDark: isDark),
          _FlashcardGrid(items: numbers, su: su, isDark: isDark),
          _FlashcardGrid(items: colorsList, su: su, isDark: isDark),
          _FlashcardList(items: basics, su: su, isDark: isDark),
        ],
      ),
    );
  }
}

// ─── GRID LAYOUT (VOWELS & NUMBERS) ──────────────────────────────────────────
class _FlashcardGrid extends StatelessWidget {
  final List<FlashcardItem> items;
  final ScreenUtils su;
  final bool isDark;
  const _FlashcardGrid({required this.items, required this.su, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(su.horizontalPad, 20, su.horizontalPad, 40),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: su.isTablet ? 4 : (su.width > 400 ? 3 : 2),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        return _FlipCard(item: items[index], su: su, isDark: isDark);
      },
    );
  }
}

// ─── LIST LAYOUT (BASICS & SENTENCES) ────────────────────────────────────────
class _FlashcardList extends StatelessWidget {
  final List<FlashcardItem> items;
  final ScreenUtils su;
  final bool isDark;
  const _FlashcardList({required this.items, required this.su, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(su.horizontalPad, 20, su.horizontalPad, 40),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
            height: 140,
            child: _FlipCard(item: items[index], su: su, isDark: isDark),
          ),
        );
      },
    );
  }
}

// ─── INTERACTIVE FLIP CARD WIDGET ────────────────────────────────────────────
class _FlipCard extends StatefulWidget {
  final FlashcardItem item;
  final ScreenUtils su;
  final bool isDark;

  const _FlipCard({required this.item, required this.su, required this.isDark});

  @override
  State<_FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_controller.isAnimating) return;
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final isUnder = angle > pi / 2;
          
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: isUnder ? _buildBackSide() : _buildFrontSide(),
          );
        },
      ),
    );
  }

  Widget _buildFrontSide() {
    return Container(
      decoration: BoxDecoration(
        color: widget.isDark ? KidsColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _isFront ? widget.item.color.withAlpha(80) : Colors.transparent, 
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.item.color.withAlpha(widget.isDark ? 20 : 40),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Glow
          if (widget.isDark)
            Positioned(
              top: -20, right: -20,
              child: Container(
                width: 60, height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.item.color.withAlpha(15),
                ),
              ),
            ),
          
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.item.tamilText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: widget.item.tamilText.length > 5 ? 28 : 64,
                    fontWeight: FontWeight.w900,
                    color: widget.item.color,
                    fontFamily: 'NotoSansTamil',
                    shadows: widget.isDark ? [
                      Shadow(color: widget.item.color.withAlpha(100), blurRadius: 15)
                    ] : null,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: widget.item.color.withAlpha(15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'TAP TO REVEAL',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: widget.item.color.withAlpha(180),
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackSide() {
    return Transform(
      transform: Matrix4.identity()..rotateY(pi),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [widget.item.color, widget.item.color.withAlpha(180)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: widget.item.color.withAlpha(80),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.item.englishText,
                textAlign: TextAlign.center,
                style: KidsText.display(28, color: Colors.white).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.item.description,
                textAlign: TextAlign.center,
                style: KidsText.body(14, color: Colors.white.withAlpha(200)).copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
