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
  FlashcardItem('கருப்பு', 'Karuppu', 'Black', Colors.black87),
  FlashcardItem('வெள்ளை', 'Vellai', 'White', Colors.grey.shade400),
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

    return Scaffold(
      backgroundColor: KidsColors.backgroundLight,
      appBar: AppBar(
        title: Text(translate('Learn Tamil', lang), style: KidsText.title(su.titleFontSize)),
        backgroundColor: KidsColors.white,
        centerTitle: false,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: KidsColors.saffron,
          indicatorWeight: 4,
          labelColor: KidsColors.saffron,
          unselectedLabelColor: KidsColors.grey,
          labelStyle: KidsText.label(14),
          unselectedLabelStyle: KidsText.body(14),
          tabs: const [
            Tab(text: 'Vowels', icon: Icon(Icons.sort_by_alpha_rounded)),
            Tab(text: 'Consonants', icon: Icon(Icons.spellcheck_rounded)),
            Tab(text: 'Numbers', icon: Icon(Icons.format_list_numbered_rounded)),
            Tab(text: 'Colors', icon: Icon(Icons.color_lens_rounded)),
            Tab(text: 'Basics', icon: Icon(Icons.forum_rounded)),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [KidsColors.backgroundLight, Color(0xFFF9F0E6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            _FlashcardGrid(items: vowels, su: su),
            _FlashcardGrid(items: consonants, su: su),
            _FlashcardGrid(items: numbers, su: su),
            _FlashcardGrid(items: colorsList, su: su),
            _FlashcardList(items: basics, su: su),
          ],
        ),
      ),
    );
  }
}

// ─── GRID LAYOUT (VOWELS & NUMBERS) ──────────────────────────────────────────
class _FlashcardGrid extends StatelessWidget {
  final List<FlashcardItem> items;
  final ScreenUtils su;
  const _FlashcardGrid({required this.items, required this.su});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(su.horizontalPad),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: su.isTablet ? 4 : (su.width > 400 ? 3 : 2),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        return _FlipCard(item: items[index], su: su);
      },
    );
  }
}

// ─── LIST LAYOUT (BASICS & SENTENCES) ────────────────────────────────────────
class _FlashcardList extends StatelessWidget {
  final List<FlashcardItem> items;
  final ScreenUtils su;
  const _FlashcardList({required this.items, required this.su});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(su.horizontalPad),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
            height: su.fluid(140.0, 150.0, 160.0, 180.0),
            child: _FlipCard(item: items[index], su: su),
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

  const _FlipCard({required this.item, required this.su});

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
      duration: const Duration(milliseconds: 400),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
              ..setEntry(3, 2, 0.001) // perspective
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
        color: KidsColors.white,
        borderRadius: BorderRadius.circular(widget.su.cardRadius),
        border: Border.all(color: widget.item.color.withAlpha(40), width: 3),
        boxShadow: [
          BoxShadow(
            color: widget.item.color.withAlpha(40),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Tamil character centred ──────────────────────────────────────
          Positioned.fill(
            bottom: 36,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.item.tamilText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: widget.item.tamilText.length > 5
                          ? widget.su.fluid(24.0, 28.0, 32.0, 36.0)
                          : widget.su.fluid(54.0, 64.0, 72.0, 84.0),
                      fontWeight: FontWeight.w900,
                      color: widget.item.color,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── "Tap to flip" badge at bottom ───────────────────────────────
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: widget.item.color.withAlpha(22),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: widget.item.color.withAlpha(70), width: 1),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.touch_app_rounded, size: 14, color: widget.item.color),
                        const SizedBox(width: 5),
                        Text(
                          'Tap to flip',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: widget.item.color,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
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
            colors: [widget.item.color, widget.item.color.withAlpha(200)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(widget.su.cardRadius),
          boxShadow: [
            BoxShadow(
              color: widget.item.color.withAlpha(80),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.item.englishText,
                    textAlign: TextAlign.center,
                    style: KidsText.display(widget.su.fluid(24.0, 26.0, 30.0, 34.0), color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.item.description,
                    textAlign: TextAlign.center,
                    style: KidsText.body(widget.su.fluid(13.0, 14.0, 15.0, 16.0), color: Colors.white70),
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
