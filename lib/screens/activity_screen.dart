import 'package:flutter/material.dart';
import '../data/localization.dart';
import '../main.dart';
import 'theme/kids_theme.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _selectedFilter = 1; // 0=Daily, 1=Weekly, 2=Monthly

  @override
  Widget build(BuildContext context) {
    final lang = XRTamilKidsApp.of(context).language;
    final su = ScreenUtils(context);

    return Scaffold(
      backgroundColor: KidsColors.backgroundLight,
      appBar: AppBar(
        title: Text(translate('Activity', lang), style: KidsText.title(su.titleFontSize)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(su.horizontalPad, 8, su.horizontalPad, 100), // padding for floating nav
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Segmented Toggle ──
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(10),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  _buildToggle(0, 'Daily'),
                  _buildToggle(1, 'Weekly'),
                  _buildToggle(2, 'Monthly'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Chart Area ──
            Container(
              height: 220,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: KidsColors.saffron, // chart card
                borderRadius: BorderRadius.circular(su.cardRadius),
                boxShadow: [
                  BoxShadow(color: KidsColors.saffron.withAlpha(80), blurRadius: 15, offset: const Offset(0, 8)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total hours: 4hr 20 min', style: KidsText.label(13, color: Colors.white)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withAlpha(80)),
                        ),
                        child: Text('3. Feb 2026 ⌄', style: KidsText.body(11, color: Colors.white)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Fake sparkline chart graphic
                  SizedBox(
                    height: 100,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // The fake graph line
                        CustomPaint(
                          size: const Size(double.infinity, 80),
                          painter: _FakeChartPainter(),
                        ),
                        // The '1 hour 20 min' tooltip
                        Positioned(
                          top: 0,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text('1 hour\n20 min', textAlign: TextAlign.center, style: KidsText.label(10, color: KidsColors.saffron)),
                              ),
                              Container(width: 2, height: 60, decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [Colors.white, Colors.white.withAlpha(0)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['09','10','11','12','13','14','15','16']
                        .map((t) => Text(t, style: KidsText.body(11, color: Colors.white70))).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // ── Progress Section ──
            Text(translate('Progress', lang), style: KidsText.display(su.fluid(20.0, 22.0, 24.0, 26.0))),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(child: _ProgressCard(title: 'Vowels', percent: 60, status: 'Normal', color: KidsColors.forest, su: su)),
                const SizedBox(width: 16),
                Expanded(child: _ProgressCard(title: 'Consonants', percent: 50, status: 'Below', color: KidsColors.sunshine, su: su)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _ProgressCard(title: 'Numbers', percent: 80, status: 'Normal', color: KidsColors.forest, su: su)),
                const SizedBox(width: 16),
                Expanded(child: _ProgressCard(title: 'Quiz', percent: 30, status: 'Above', color: KidsColors.bubblegum, su: su)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggle(int index, String text) {
    final isSelected = _selectedFilter == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedFilter = index),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isSelected ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : null,
          ),
          child: Center(
            child: Text(text, style: KidsText.label(13, color: isSelected ? KidsColors.dark : KidsColors.grey)),
          ),
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final String title;
  final int percent;
  final String status;
  final Color color;
  final ScreenUtils su;

  const _ProgressCard({required this.title, required this.percent, required this.status, required this.color, required this.su});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(su.cardRadius),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: KidsText.label(14, color: KidsColors.grey)),
                const SizedBox(height: 8),
                Text('$percent%', style: KidsText.display(24, color: KidsColors.dark)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(status == 'Below' ? Icons.error_rounded : Icons.check_circle_rounded, size: 12, color: color),
                    const SizedBox(width: 4),
                    Text(status, style: KidsText.body(11, color: color)),
                  ],
                ),
              ],
            ),
          ),
          // Vertical progress bar substitute
          Container(
            width: 8, height: 60,
            decoration: BoxDecoration(color: Colors.black.withAlpha(5), borderRadius: BorderRadius.circular(4)),
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 8, height: 60 * (percent / 100),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ],
      ),
    );
  }
}

class _FakeChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.8, size.width * 0.2, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.2, size.width * 0.4, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.6, size.width * 0.6, size.height * 0.1); // Peak
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.8, size.width * 0.8, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.9, size.height * 0.4, size.width, size.height * 0.5);

    canvas.drawPath(path, paint);

    // Draw little dots at vertices
    final dotPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, size.height * 0.7), 4, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.5), 4, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.4), 4, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.1), 5, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.6), 4, dotPaint);
    canvas.drawCircle(Offset(size.width, size.height * 0.5), 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
