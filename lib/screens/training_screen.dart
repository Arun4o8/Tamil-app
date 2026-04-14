import 'package:flutter/material.dart';
import '../data/training.dart';
import '../screens/theme/kids_theme.dart';

class TrainingScreen extends StatefulWidget {
  final String cultureName;
  final List<TrainingMethod> methods;
  final Color color;

  const TrainingScreen({
    super.key,
    required this.cultureName,
    required this.methods,
    required this.color,
  });

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen>
    with TickerProviderStateMixin {
  int _currentStep = 0;
  late AnimationController _cardCtrl;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  @override
  void initState() {
    super.initState();
    _cardCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _cardFade = CurvedAnimation(parent: _cardCtrl, curve: Curves.easeOut);
    _cardSlide = Tween<Offset>(
            begin: const Offset(0.08, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _cardCtrl, curve: Curves.easeOutCubic));
    _cardCtrl.forward();
  }

  @override
  void dispose() {
    _cardCtrl.dispose();
    super.dispose();
  }

  void _animateToStep(int step) {
    _cardCtrl.reverse().then((_) {
      setState(() => _currentStep = step);
      _cardCtrl.forward();
    });
  }

  void _goToNext() {
    if (_currentStep < widget.methods.length - 1) {
      _animateToStep(_currentStep + 1);
    } else {
      _showCompletion();
    }
  }

  void _goToPrev() {
    if (_currentStep > 0) _animateToStep(_currentStep - 1);
  }

  void _showCompletion() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              colors: [Color(0xFFFFF3E0), Color(0xFFE8FDF5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 90, height: 90,
                decoration: BoxDecoration(
                  gradient: KidsColors.saffronGrad,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: KidsColors.saffron.withAlpha(100),
                      blurRadius: 20, offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.celebration_rounded, size: 44, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Congratulations! 🎉',
                textAlign: TextAlign.center,
                style: KidsText.display(22),
              ),
              const SizedBox(height: 10),
              Text(
                'You\'ve completed\n${widget.cultureName} training!',
                textAlign: TextAlign.center,
                style: KidsText.body(15, color: KidsColors.darkMid),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: KidsColors.sunshine.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: KidsColors.sunshine.withAlpha(80)),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.star_rounded, color: KidsColors.sunshine, size: 18),
                  const SizedBox(width: 6),
                  Text('Cultural Explorer Badge Earned!',
                      style: KidsText.label(13, color: KidsColors.saffronDark)),
                ]),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () { Navigator.pop(context); Navigator.pop(context); },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: widget.color, width: 2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text('Back',
                              style: KidsText.title(15, color: widget.color)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() => _currentStep = 0);
                        _cardCtrl.forward();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [widget.color, widget.color.withAlpha(200)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text('Try Again',
                              style: KidsText.title(15, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final method = widget.methods[_currentStep];
    final progress = (_currentStep + 1) / widget.methods.length;
    final su = ScreenUtils(context);

    return Scaffold(
      backgroundColor: KidsColors.backgroundLight,
      appBar: AppBar(
        title: Text('${widget.cultureName} Training',
            style: KidsText.title(su.titleFontSize, color: Colors.white)),
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [widget.color.withAlpha(20), KidsColors.backgroundLight],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(su.horizontalPad),
            child: Column(
              children: [
                // Progress section
                Row(
                  children: [
                    Text(
                      'Method ${_currentStep + 1} of ${widget.methods.length}',
                      style: KidsText.label(su.bodyFontSize, color: widget.color),
                    ),
                    const Spacer(),
                    // Dot indicators
                    Row(
                      children: List.generate(widget.methods.length, (i) {
                        return GestureDetector(
                          onTap: () => _animateToStep(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.only(left: 6),
                            width: i == _currentStep ? 20 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: i <= _currentStep
                                  ? widget.color
                                  : Colors.grey.shade300,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation(widget.color),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 20),

                // Method Card (animated)
                Expanded(
                  child: SlideTransition(
                    position: _cardSlide,
                    child: FadeTransition(
                      opacity: _cardFade,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(su.fluid(20.0, 24.0, 28.0, 32.0)),
                        decoration: KidsDecor.card(radius: su.cardRadius),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Step icon circle
                            Container(
                              width: su.fluid(90.0, 100.0, 110.0, 130.0),
                              height: su.fluid(90.0, 100.0, 110.0, 130.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    widget.color.withAlpha(30),
                                    widget.color.withAlpha(10)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: widget.color.withAlpha(60), width: 2),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.directions_run_rounded,
                                  size: su.fluid(40.0, 48.0, 54.0, 64.0),
                                  color: widget.color,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Step badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: widget.color.withAlpha(20),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                  'Step ${_currentStep + 1} • ${widget.cultureName}',
                                  style: KidsText.label(12, color: widget.color)),
                            ),
                            const SizedBox(height: 14),

                            Text(
                              method.title,
                              textAlign: TextAlign.center,
                              style: KidsText.display(su.titleFontSize),
                            ),
                            const SizedBox(height: 16),

                            Expanded(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Text(
                                  method.description,
                                  textAlign: TextAlign.center,
                                  style: KidsText.body(su.bodyFontSize,
                                      color: KidsColors.darkMid),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // AR/XR buttons
                            Row(
                              children: [
                                Expanded(
                                  child: _ActionButton(
                                    icon: Icons.camera_alt_rounded,
                                    label: 'AR View',
                                    color: KidsColors.forest,
                                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('📸 AR View — point camera at a flat surface!'),
                                        backgroundColor: KidsColors.forest,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _ActionButton(
                                    icon: Icons.view_in_ar_rounded,
                                    label: 'XR View',
                                    color: KidsColors.sky,
                                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('🥽 XR View — Unity Engine integration coming!'),
                                        backgroundColor: KidsColors.sky,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Navigation
                Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: GestureDetector(
                          onTap: _goToPrev,
                          child: Container(
                            height: su.buttonHeight,
                            decoration: BoxDecoration(
                              border: Border.all(color: widget.color, width: 2.5),
                              borderRadius: BorderRadius.circular(su.cardRadius - 4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_back_ios_new_rounded,
                                    color: widget.color, size: 18),
                                const SizedBox(width: 6),
                                Text('Previous',
                                    style: KidsText.title(15, color: widget.color)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (_currentStep > 0) const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: _goToNext,
                        child: Container(
                          height: su.buttonHeight,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [widget.color, widget.color.withAlpha(200)],
                            ),
                            borderRadius:
                                BorderRadius.circular(su.cardRadius - 4),
                            boxShadow: [
                              BoxShadow(
                                color: widget.color.withAlpha(100),
                                blurRadius: 16, offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currentStep < widget.methods.length - 1
                                    ? 'Next Method'
                                    : 'Complete! 🎉',
                                style: KidsText.title(15, color: Colors.white),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                _currentStep < widget.methods.length - 1
                                    ? Icons.arrow_forward_ios_rounded
                                    : Icons.celebration_rounded,
                                color: Colors.white, size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Action Button ────────────────────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon, required this.label,
    required this.color, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: color.withAlpha(15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withAlpha(80), width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 6),
            Text(label, style: KidsText.label(14, color: color)),
          ],
        ),
      ),
    );
  }
}
